const Setting = require('../public/config')
const Constant = require('../constant')
const Sequelize = require('sequelize')
const Op = Sequelize.Op

const operatorsAliases = {
    $eq: Op.eq,
    $ne: Op.ne,
    $gte: Op.gte,
    $gt: Op.gt,
    $lte: Op.lte,
    $lt: Op.lt,
    $not: Op.not,
    $in: Op.in,
    $notIn: Op.notIn,
    $is: Op.is,
    $like: Op.like,
    $notLike: Op.notLike,
    $iLike: Op.iLike,
    $notILike: Op.notILike,
    $regexp: Op.regexp,
    $notRegexp: Op.notRegexp,
    $iRegexp: Op.iRegexp,
    $notIRegexp: Op.notIRegexp,
    $between: Op.between,
    $notBetween: Op.notBetween,
    $overlap: Op.overlap,
    $contains: Op.contains,
    $contained: Op.contained,
    $adjacent: Op.adjacent,
    $strictLeft: Op.strictLeft,
    $strictRight: Op.strictRight,
    $noExtendRight: Op.noExtendRight,
    $noExtendLeft: Op.noExtendLeft,
    $and: Op.and,
    $or: Op.or,
    $any: Op.any,
    $all: Op.all,
    $values: Op.values,
    $col: Op.col
};

const sequelize = new Sequelize(Setting.db_config.database, Setting.db_config.user, Setting.db_config.password, {
    host: Setting.db_config.host,
    port: Setting.db_config.port,
    dialect: 'mysql',
    logging: false,
    // dialectOptions: {
    //     supportBigNumbers: true,
    //     bigNumberStrings: true,
    //     multipleStatements: true,
    //     charset: Constant.DATABASE_DIALECT.ACCEPT_CHARSET,
    //     collat: Constant.DATABASE_DIALECT.COLLATE,
    //     connectTimeout: Constant.DATABASE_CONNECT_TIMEOUT
    // },
    pool: {
        max: Constant.DATABASE_POOL.max,
        min: Constant.DATABASE_POOL.min,
        acquire: Constant.DATABASE_POOL.acquire,
        idle: Constant.DATABASE_POOL.idle
    },
    operatorsAliases
})

module.exports = { sequelize, Sequelize }
