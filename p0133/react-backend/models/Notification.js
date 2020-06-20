const { sequelize, Sequelize } = require('./Sequelize')
const User = require('./User')

const Notification = sequelize.define('Notification', {
    id: {
        type: Sequelize.INTEGER(11),
        allowNull: false,
        primaryKey: true,
        autoIncrement: true,
        field: 'id'
    },
    created: {
        type: Sequelize.DOUBLE(32, 0),
        allowNull: false,
        field: 'created'
    },
    fromId: {
        type: Sequelize.INTEGER(11),
        allowNull: false,
        references: User,
        referencesKey: 'id',
        field: 'fromId'
    },
    toId: {
        type: Sequelize.INTEGER(11),
        references: User,
        referencesKey: 'id',
        defaultValue: null,
        field: 'toId'
    },
    startDate: {
        type: Sequelize.DOUBLE(32, 0),
        allowNull: false,
        field: 'startDate'
    },
    endDate: {
        type: Sequelize.DOUBLE(32, 0),
        field: 'endDate'
    },
    message: {
        type: Sequelize.TEXT,
        allowNull: false,
        field: 'message'
    },
    type: {
        type: Sequelize.ENUM,
        values: ['system', 'admin'],
        defaultValue: 'system',
        allowNull: false,
        field: 'type'
    },
    status: {
        type: Sequelize.ENUM,
        values: ['read', 'open', 'draft', 'done'],
        defaultValue: 'draft',
        allowNull: false,
        field: 'status'
    }
}, { timestamps: false, freezeTableName: true, tableName: 'notification' })

module.exports = Notification
