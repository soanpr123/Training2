var redis = require('redis');
var settings = require('../public/config')

class Redis {
    constructor() {
        this.host = settings.redis_config.host || 'localhost'
        this.port = settings.redis_config.port || '6379'
        this.connected = false
        this.client = null
    }

    getConnection() {
        if (this.connected) return this.client
        else {
            this.client = redis.createClient({
                host: this.host,
                port: this.port
            })
            return this.client
        }
    }
}
module.exports = new Redis()