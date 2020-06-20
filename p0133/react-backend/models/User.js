const { sequelize, Sequelize } = require('./Sequelize')
const Schedule = require('./Schedule')
const Notification = require('./Notification')

const User = sequelize.define('users', {
    id: {
        type: Sequelize.INTEGER(11),
        allowNull: false,
        primaryKey: true,
        autoIncrement: true,
        field: 'id'
    },
    first_name: {
        type: Sequelize.STRING(255),
        allowNull: false,
        field: 'first_name'
    },
    last_name: {
        type: Sequelize.STRING(255),
        allowNull: false,
        field: 'last_name'
    },
    email: {
        type: Sequelize.STRING(255),
        allowNull: false,
        unique: true,
        field: 'email'
    },
    passwrd: {
        type: Sequelize.TEXT,
        allowNull: false,
        field: 'passwrd'
    },
    phone: {
        type: Sequelize.STRING(255),
        defaultValue: null,
        field: 'phone'
    },
    bio: {
        type: Sequelize.TEXT,
        defaultValue: null,
        field: 'bio'
    },
    company: {
        type: Sequelize.STRING(255),
        defaultValue: null,
        field: 'company'
    },
    friends_list: {
        type: Sequelize.TEXT,
        defaultValue: null,
        field: 'friends_list'
    },
    verified: {
        type: Sequelize.TINYINT(1),
        defaultValue: null,
        field: 'verified'
    },
    saltKey: {
        type: Sequelize.TEXT,
        defaultValue: null,
        field: 'saltKey'
    },
    activated: {
        type: Sequelize.TINYINT(1),
        defaultValue: null,
        field: 'activated'
    },
    status: {
        type: Sequelize.ENUM,
        values: ['Online', 'Offline', 'Away', 'Busy'],
        defaultValue: 'Offline',
        field: 'status'
    },
    role: {
        type: Sequelize.ENUM,
        values: ['admin', 'users', 'cbtv', 'tempuser'],
        defaultValue: 'users',
        field: 'role'
    },
    display_name: {
        type: Sequelize.STRING(255),
        defaultValue: null,
        field: 'display_name'
    },
    nbConnect: {
        type: Sequelize.INTEGER(11),
        defaultValue: null,
        field: 'nbConnect'
    },
    invitations: {
        type: Sequelize.TEXT,
        defaultValue: null,
        field: 'invitations'
    },
    avatars: {
        type: Sequelize.STRING(255),
        defaultValue: null,
        field: 'avatars'
    },
    ldapuser: {
        type: Sequelize.TINYINT(1),
        defaultValue: 0,
        field: 'ldapuser'
    },
    personalId: {
        type: Sequelize.TINYINT(1),
        defaultValue: null,
        field: 'personalId'
    },
    createdDate: {
        type: Sequelize.DOUBLE(32, 0),
        defaultValue: Date.now,
        field: 'createdDate'
    }
}, { timestamps: false, freezeTableName: true, tableName: 'users' })

Schedule.belongsTo(User, { foreignKey: 'userId', targetKey: 'id', as: 'uid' })
Schedule.belongsTo(User, { foreignKey: 'cbtvId', targetKey: 'id', as: 'cid' })

Notification.belongsTo(User, { foreignKey: 'fromId', targetKey: 'id', as: 'fromid' })
Notification.belongsTo(User, { foreignKey: 'toId', targetKey: 'id', as: 'toid' })

module.exports = User
