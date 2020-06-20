const ldap = require('ldapjs');
const settings = require('../public/config')

class Ldap {
    constructor() {
        this.connected = false
        this.client = null
    }

    getConnection() {
        if (this.connected) return this.client
        else {
            console.log("Attempting to connect to LDAP server")
            this.client = ldap.createClient({
              url: settings.ldap_config.url,
              timeout: settings.ldap_config.timeout,
              connectTimeout: settings.ldap_config.connectTimeout,
              reconnect: settings.ldap_config.reconnect
            })
            return this.client
        }
    }
}
module.exports = new Ldap()
