const jwt = require('jsonwebtoken')
const settings = require('../public/config')
const idFunction = require('../public/javascripts/getId')
const emailFunction = require('../public/javascripts/getEmail')
const mailer = require('../public/javascripts/mailer')
const User = require('../models/User')
const Constant = require('../constant')
const fs = require('fs');
const PUBLIC_KEY = fs.readFileSync('./public.key', 'utf8')

/**
 * STEP TO VERIFY WITH LDAP: Verify with SQL database
 * -> if not -> verify with LDAP database
 * if yes -> create a new one in SQL database based on LDAP
 */

exports.login = async (req, routerRes, next) => {
	//verify if the email is in db
	var query = `SELECT * FROM users WHERE email='${req.body.email}'`  //req.body.email could be username or enail
	db.query(query, (err, result) => {
		if (err) {
			console.log(err);
			routerRes.json({ message: 'err query', password: '', saltKey: '' })
		};
		if (result.length <= 0) { //cannot find user in SQL database, start verifying with ldap

			//--------------verify with LDAP start------------
			try {
				if (ldapClient.connected) {
					let ldapSearchResult = [];
					const ldapClientSearchOption = {
						filter: `(uid=${req.body.email})`,
						scope: 'sub',
						attributes: ["cn", "uid"]
					};
					ldapClient.search('ou=sinhvien,dc=vnu,dc=vn', ldapClientSearchOption, (err, res) => {
						res.on('error', (err) => {
							console.log("Ldap search err", err);
							routerRes.json({ message: 'err', password: '', saltKey: '', message2: err });
						});
						res.on('searchEntry', (entry) => {
							ldapSearchResult.push(entry);
						});
						res.on('end', (ldapResult) => {

							if (ldapSearchResult.length > 0) {
								let userObj = {};
								console.log("ldapSearchResult", ldapSearchResult.attributes)
								userObj[ldapSearchResult[0].attributes[0].type] = new TextDecoder("utf-8").decode(ldapSearchResult[0].attributes[0]._vals[0]);
								userObj[ldapSearchResult[0].attributes[1].type] = new TextDecoder("utf-8").decode(ldapSearchResult[0].attributes[1]._vals[0]);

								console.log("userObj", userObj)
								const email = userObj.uid //MODIFY THIS
								const phone = '(000) 000-0000'; //MODIFY THIS
								const personalId = email;
								const first_name = 'First'; //MODIFY THIS
								const last_name = 'Last'; //MODIFY THIS
								const display_name = encodeURI(userObj.cn);
								// const passwordData = 'rd. MODIFY THIS!!!
								const passwrd = (new Date()).getTime().toString();
								const saltKey = (new Date()).getTime(+24).toString();
								let createNew = `INSERT INTO users (id, first_name, last_name, email, passwrd, phone, bio, company, friends_list, verified, saltKey, activated, status, role, display_name, nbConnect,invitations,avatars,ldapuser, personalId) VALUES (0,'${first_name}','${last_name}','${email}','${passwrd}','${phone}',NULL,NULL,'',1,'${saltKey}',1,'Offline','users','${display_name}',0,'','Anonyme.jpeg',1,'${personalId}')`;
								db.query(createNew, (err, createNewResult) => {
									if (err) {
										console.log(err);
										routerRes.json({ message: 'err', password: '', saltKey: '', message2: err });
									} else {
										routerRes.json({ message: 'ldapuser', password: '', saltKey: '' });
									}
								});
							} else {
								routerRes.json({ message: 'no account', password: '', saltKey: '' });
							}
						});
					})
				} else {
					routerRes.json({ message: 'err', password: '', saltKey: '', message2: "ldap not connected" });
				}
			} catch (e) {
				console.log(e);
				routerRes.json({ message: 'err', password: '', saltKey: '', message2: err });
			}
			//--------------verify with LDAP end------------

		} else {
			//if in db verify if it is verified
			let verify = "SELECT passwrd, saltKey, verified, id, activated, nbConnect, role, ldapuser FROM users WHERE email='" + req.body.email + "'";
			db.query(verify, (err, result) => {
				if (result[0].verified == 0) {
					//if not verified, return not verified and hashed password and saltKey
					routerRes.json({ message: 'not verified', password: result[0].passwrd, saltKey: result[0].saltKey });
				} else if (result[0].activated == 0) {
					//if account is desactivated by the admin of the website
					routerRes.json({ message: 'not activated', password: result[0].passwrd, saltKey: result[0].saltKey });
				} else {
					//JWT token
					var payload = { "id": result[0].id, "role": result[0].role, "email": req.body.email };
					var secretKey = settings.defaultSettings.PRIVATE_KEY;
					let token = jwt.sign(payload, secretKey, { expiresIn: "24h", algorithm: 'HS256' });
					var numberConnect = result[0].nbConnect;
					var addConnect = "UPDATE users SET nbConnect =" + result[0].nbConnect + "+1, status='Online' WHERE email='" + req.body.email + "'"
					if (result[0].ldapuser) {
						routerRes.json({ message: 'ldapuser', password: '', saltKey: '' })
					} else {
						db.query(addConnect, (err, resul) => {
							if (err) {
								routerRes.json({ message: 'error addConnect', password: '', saltKey: '' })
							} else {
								//if verified, return hashed password and saltKey
								routerRes.json({ password: result[0].passwrd, saltKey: result[0].saltKey, message: '', id: result[0].id, nbConnect: numberConnect, webToken: token });
							}
						})
					}
				}
			})
		}
	})
}

exports.ldap = async (req, routerRes, next) => {
	let decoded = jwt.verify(req.body.encryptedUser, PUBLIC_KEY, { algorithm: ['RS256'] })
	let username = decoded.username.toString();
	let password = decoded.password.toString();
	console.log({
		username: username,
		password: password
	})
	if (ldapClient.connected) {
		//    ldapClient.bind(`uid=${username}`,password,(err) => {
		ldapClient.bind(`uid=${username},ou=sinhvien,ou=dhcn,ou=sinhvien,dc=vnu,dc=vn`, password, (err) => {
			if (err) {
				console.log("Ldap authentication err:", err)
				routerRes.json({ message: 'no account', password: '', saltKey: '' });
			} else {
				let verify = "SELECT passwrd, saltKey, verified, id, activated, nbConnect, role FROM users WHERE email='" + username + "'";
				db.query(verify, (err, result) => {
					if (err) {
						console.log("SQL err", err);
						routerRes.json({ message: 'err', password: '', saltKey: '' });
					} else {
						//JWT token
						console.log("jwt")
						var payload = { "id": result[0].id, "role": result[0].role, "email": username };
						var secretKey = settings.defaultSettings.PRIVATE_KEY;
						let token = jwt.sign(payload, secretKey, { expiresIn: "24h", algorithm: 'HS256' });
						var numberConnect = result[0].nbConnect;
						var addConnect = "UPDATE users SET nbConnect =" + result[0].nbConnect + "+1, status='Online' WHERE email='" + username + "'"
						db.query(addConnect, (err, resul) => {
							if (err) {
								console.log("SQL err", err)
								routerRes.json({ message: 'err', password: '', saltKey: '' })
							} else {
								//if verified, return hashed password and saltKey
								routerRes.json({ password: result[0].passwrd, saltKey: result[0].saltKey, message: 'logged', id: result[0].id, nbConnect: numberConnect, webToken: token });
							}
						})
					}
				})
			}
		})
	} else {
		routerRes.json({ message: 'err', password: '', saltKey: '' })
	}
}

exports.signUp = async (req, res) => {
	const user = await User.findOne({
		where: {
			email: req.body.email
		}
	})
	if (user) {
		res.send({ message: "user existed" })
	} else {
		const tempUser = {
			first_name: req.body.firstName,
			last_name: req.body.lastName,
			email: req.body.email,
			passwrd: req.body.hashed.passwordHash,
			phone: req.body.phoneNumber,
			bio: null,
			company: null,
			friends_list: '',
			verified: false,
			saltKey: req.body.hashed.salt,
			activated: false,
			status: 'Offline',
			role: 'users',
			display_name: req.body.displayName,
			nbConnect: 0,
			invitations: '',
			avatars: 'Anonyme.jpeg',
			createdDate: Date.now()
		}
		User.create(tempUser).then(result => {
			return User.findOne({
				where: {
					email: req.body.email
				}
			})
		}).then(async result => {
			let payload = { id: result.id, email: result.email }
			let token = jwt.sign(payload, settings.defaultSettings.PRIVATE_KEY, Constant.JWT_OPTION)
			let content = `
				<div style="padding: 20px; border-spacing: 0;vertical-align: top;text-align: left;background: black">
					<div style="font-size: 14px;font-weight: normal;color: white;font-family: 'Open Sans', Helvetica, sans-serif;padding: 0;text-align: left;line-height: 1.3;">
						<strong>Account Name</strong>: ${decodeURI(result.display_name)}
					</div>

					<div style="font-size: 14px;font-weight: normal;color: white;font-family: 'Open Sans', Helvetica, sans-serif;padding: 0;text-align: left;line-height: 1.3;">
						<strong>Email Address:</strong> <a style="color: #2D7ABF;text-decoration: underline;">${result.email}</a>
					</div>
				</div>

				<div style="padding:5% 7% 5% 7%">
					<p style="${Constant.MAIL_STYLE.body}">
						Thank you for registering for ${settings.defaultSettings.DOCUMENT_TITLE}. Please verify your email address.
					</p>
					<p style="${Constant.MAIL_STYLE.body}">
						If you have any questions, please do not hesitate to email us at
							<a href="mailto:webrtc.bhsoft@gmail.com" style="color: #2D7ABF;text-decoration: underline;">
								webrtc.bhsoft@gmail.com
							</a>
					</p>
					<a href="${settings.defaultSettings.FE_URL + '/verifiedEmail/' + token}" style="color: #ffffff;text-decoration: none;background-color: #2D7ABF;border-bottom: 2px solid #052D51;border-radius: 3px;display: block;font-size: 13px;font-weight: bold;line-height: 50px;text-align: center;min-width: 200px;width: auto;-webkit-text-size-adjust: none;max-width:50px;font-family: 'Helvetica', 'Arial', sans-serif;margin: 10% 0 8% 0;">
						Complete your profile
					</a>
				</div>
			`

			let contentAdmin = `
				<div style="padding: 20px; border-spacing: 0;vertical-align: top;text-align: left;background: black">
					<div style="font-size: 14px;font-weight: normal;color: white;font-family: 'Open Sans', Helvetica, sans-serif;padding: 0;text-align: left;line-height: 1.3;">
						<strong>Account Name</strong>: ${decodeURI(result.display_name)}
					</div>

					<div style="font-size: 14px;font-weight: normal;color: white;font-family: 'Open Sans', Helvetica, sans-serif;padding: 0;text-align: left;line-height: 1.3;">
						<strong>Email Address:</strong> <a style="color: #2D7ABF;text-decoration: underline;">${result.email}</a>
					</div>
				</div>

				<div style="padding:5% 7% 5% 7%">
					<p style="${Constant.MAIL_STYLE.body}">
						A new email is registered in ${settings.defaultSettings.DOCUMENT_TITLE}.
					</p>
					<p style="${Constant.MAIL_STYLE.body}">

					</p>
					<a href="${settings.defaultSettings.FE_URL + '/activateAccount/' + token}" style="color: #ffffff;text-decoration: none;background-color: #2D7ABF;border-bottom: 2px solid #052D51;border-radius: 3px;display: block;font-size: 13px;font-weight: bold;line-height: 50px;text-align: center;min-width: 200px;width: auto;-webkit-text-size-adjust: none;max-width:50px;font-family: 'Helvetica', 'Arial', sans-serif;margin: 10% 0 8% 0;">
						Acitivate user account
					</a>
					<a href="${settings.defaultSettings.FE_URL + '/deleteAccount/' + token}" style="color: #ffffff;text-decoration: none;background-color: #c01414;border-bottom: 2px solid #052D51;border-radius: 3px;display: block;font-size: 13px;font-weight: bold;line-height: 50px;text-align: center;min-width: 200px;width: auto;-webkit-text-size-adjust: none;max-width:50px;font-family: 'Helvetica', 'Arial', sans-serif;margin: 10% 0 8% 0;">
						Deacitivate user account
					</a>
				</div>
			`

			try {
				await mailer.sendMail(req.body.email, `${settings.defaultSettings.DOCUMENT_TITLE} - Verify your email address`, content)

				// replace this email by admin's email
				await mailer.sendMail('webrtc.bhsoft@gmail.com', `${settings.defaultSettings.DOCUMENT_TITLE} - Activate email address`, contentAdmin)

				res.send({ message: 'success' })
			} catch (error) {
				res.send({ message: 'err' })
			}
		}).catch(err => {
			console.log(err)
			res.send({ message: 'err' })
		})
	}
}

exports.verifiedEmail = async (req, res) => {
	const idUser = await idFunction.getID(req.body.token)
	User.update({
		verified: true,
		email: emailFunction.getEmail(req.body.token),

	}, {
		where: {
			id: idUser
		}
	}).then(result => {
		res.json({ message: 'verified' })
	}).catch(err => {
		console.log(err)
		res.json({ message: 'err' })
	})
}

exports.activiteAccount = async (req, res) => {
	const idUser = await idFunction.getID(req.body.token)
	User.update({
		activated: true,
		email: emailFunction.getEmail(req.body.token),
	}, {
		where: {
			id: idUser
		}
	}).then(result => {
		res.json({ message: 'activated' })
	}).catch(err => {
		console.log(err)
		res.json({ message: 'err' })
	})
}

exports.deleteAccount = async (req, res) => {
	const idUser = await idFunction.getID(req.body.token)
	User.destroy({
		where: {
			id: idUser
		}
	}).then(result => {
		res.json({ message: 'deactivated' })
	}).catch(err => {
		console.log(err)
		res.json({ message: 'err' })
	})
}
