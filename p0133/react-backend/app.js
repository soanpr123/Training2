//import module
require('dotenv').config({ path: '.env' })
const Setting = require('./public/config')
const createError = require('http-errors')
const mysql = require('mysql')
const feathers = require('@feathersjs/feathers')
const express = require('@feathersjs/express')
const path = require('path');
const cookieParser = require('cookie-parser')
const logger = require('morgan');
const cors = require('cors')
const fs = require('fs')
const https = require('http')
const socket = require('socket.io')
const expressValidator = require('express-validator')
const ldap = require('./services/ldap')
const redis = require('./services/redis')

const app = express(feathers())
const expressSwagger = require('express-swagger-generator')(app)

app.configure(express.rest())

let options = {
	swaggerDefinition: {
		info: {
			description: 'Provided by BHsoft',
			title: 'WebRTC API',
			version: '1.0.0',
		},
		host: `${Setting.defaultSettings.FE_URL}`,
		produces: [
			"application/json"
		],
		// schemes: ['http', 'https']
	},
	basedir: __dirname,
	files: ['./routes/*.js']
}
expressSwagger(options)

//- Reconnection function
function reconnect(connection) {
	console.log("\n New connection tentative...")
	connection = mysql.createPool(Setting.db_config)
	//- Try to reconnect
	connection.getConnection(function (err) {
		if (err) {
			//- Try to connect every 2 seconds.
			setTimeout(reconnect(connection), 2000)
		} else {
			console.log("\n\t *** New connection established with the database. ***")
			return connection;
		}
	})
}

/*-----create socket servers-----*/
var server = https.createServer({
	key: fs.readFileSync('key.pem'),
	cert: fs.readFileSync('cert.pem')
}, app).listen(3005);
var io = socket(server, {
	pingInterval: 25000,
	pingTimeout: 120000,
	cookie: false
})
global.io = io;

const corsOptions = {
	origin: ['https://webrtc.bachasoftware.com', 'http://117.6.135.148:8556', 'http://localhost:3000', 'https://webrtc.uet.vnu.edu.vn'],
	credentials: true
}

// allow CORS
app.all('*', function (req, res, next) {
	res.header("Access-Control-Allow-Origin", "*")
	res.header('Access-Control-Allow-Methods', 'GET,PUT,POST,DELETE,OPTIONS')
	res.header('Access-Control-Allow-Headers', 'Content-type,Accept,X-Access-Token,X-Key')
	if (req.method == 'OPTIONS') {
		res.status(200).end()
	} else {
		next()
	}
});

//- connection to db
var connection = mysql.createPool(Setting.db_config);
connection.getConnection(function (err) {
	if (err) {
		console.log("\n\t *** Cannot establish a connection with the database. ***");
		connection = reconnect(connection);
	} else {
		console.log("\n\t *** New connection established with the database. ***")
	}
});
global.db = connection;

//--connect to LDAP Server
const ldapClient = ldap.getConnection();
ldapClient.on('connect', () => {
	console.log('Connected to LDAP!')
})

ldapClient.on('error', function (err) {
	console.log("Cannot connect to LDAP server")
});

global.ldapClient = ldapClient

//--connect to Redis Server
const redisClient = redis.getConnection();
redisClient.on('connect', () => {
	console.log('Connected to Redis!');
});
redisClient.on('error', () => {
	console.log('Something went wrong with Redis!')
})
global.redisClient = redisClient;

//- Error listener
connection.on('error', function (err) {
	if (err.code === "PROTOCOL_CONNECTION_LOST") {
		console.log("/!\\ Cannot establish a connection with the database. /!\\ (" + err.code + ")");
		return reconnect(connection);
	} else if (err.code === "PROTOCOL_ENQUEUE_AFTER_QUIT") {
		console.log("/!\\ Cannot establish a connection with the database. /!\\ (" + err.code + ")");
		return reconnect(connection);
	} else if (err.code === "PROTOCOL_ENQUEUE_AFTER_FATAL_ERROR") {
		console.log("/!\\ Cannot establish a connection with the database. /!\\ (" + err.code + ")");
		return reconnect(connection);
	} else if (err.code === "PROTOCOL_ENQUEUE_HANDSHAKE_TWICE") {
		console.log("/!\\ Cannot establish a connection with the database. /!\\ (" + err.code + ")");
	} else {
		console.log("/!\\ Cannot establish a connection with the database. /!\\ (" + err.code + ")");
		return reconnect(connection);
	}
});

/*--SETTINGS OF APP--*/
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'jade');
app.use(cors(corsOptions));
app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.resolve(__dirname, 'public')));
app.use(expressValidator())

//require router
require('./routes/connection')(app)
require('./routes/password')(app)
require('./routes/user')(app)
require('./routes/friends')(app)
require('./routes/invitations')(app)
require('./routes/admin')(app)
require('./routes/authorization')(app)
require('./routes/chat')(app)

// catch 404 and forward to error handler
app.use(function (req, res, next) {
	next(createError(404));
});

// error handler
app.use(function (err, req, res, next) {
	res.locals.message = err.message;
	res.locals.error = req.app.get('env') === 'development' ? err : {};
	res.status(err.status || 500);
});

module.exports = app;
