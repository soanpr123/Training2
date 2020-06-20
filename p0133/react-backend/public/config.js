const defaultSettings = {
    FE_URL: process.env.FE_URL,
    REACT_APP_GA_PROPERTY: process.env.REACT_APP_GA_PROPERTY,
    EMAIL_ADDRESS: process.env.EMAIL_ADDRESS,
    MDP_EMAIL: process.env.MDP_EMAIL,
    PRIVATE_KEY: process.env.PRIVATE_KEY,
    DOCUMENT_TITLE: process.env.DOCUMENT_TITLE
};

const redis_config = {
    port: process.env.REDIS_PORT,
    host: process.env.REDIS_HOST
}

const db_config = {
    host: process.env.DB_HOST,
    port: process.env.DB_PORT,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_DATABASE
}


const ldap_config = {  //check index.js and ldap.js file for LDAP authentication
    url: process.env.LDAP_URL, //ldap server url MODIFY THIS
    timeout: process.env.LDAP_TIMEOUT,
    connectTimeout: process.env.LDAP_CONNECT_TIMEOUT,
    reconnect: process.env.LBDA_RECONNECT,
    user: process.env.LDAP_USER, //ldap user to accquire permission for search  MODIFY THIS
    password: process.env.LDAP_PASSWORD, //ldap user to accquire permission for search  MODIFY THIS
    basedn: process.env.LDAP_BASEDN, //ldap base distinguished name to perform search  MODIFY THIS
}


const settings = { defaultSettings, db_config, redis_config, ldap_config };

module.exports = settings
