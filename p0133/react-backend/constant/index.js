module.exports = {
    DATABASE_DIALECT: {
        accept_charset: 'utf8',
        COLLATE: 'utf8_general_ci',
        connect_timeout: 30000
    },
    DATABASE_POOL: {
        max: 5,
        min: 0,
        acquire: 30000,
        idle: 10000
    },
    USER_RETURN_ATTRIBUTES: [
        'id',
        'first_name',
        'last_name',
        'display_name',
        'email',
        'phone',
        'personalId',
        'company',
        'verified',
        'activated',
        'role',
        'nbConnect',
        'ldapuser',
        'createdDate'
    ],
    JWT_OPTION: {
        expiresIn: "24h",
        algorithm: 'HS256'
    },
    MAIL_STYLE: {
        body: "margin-bottom: 10px; font-size: 14px; font-weight: normal; color: #404040; font-family: 'Open Sans', Helvetica, sans-serif; text-align: left; line-height: 1.3;",
        footer: "font-size: 12px ; font-weight: normal; color: #404040; font-family: 'Open Sans', Helvetica, sans-serif; padding: 0; text-align: center; line-height: 15px;"
    }
}
