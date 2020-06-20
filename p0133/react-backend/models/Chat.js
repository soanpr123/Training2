const { sequelize, Sequelize } = require('./Sequelize')

const Chat = sequelize.define('Chat', {
    Id: {
        type: Sequelize.INTEGER(11),
        allowNull: false,
        primaryKey: true,
        autoIncrement: true,
        field: 'Id'
    },
    Participants: {
        type: Sequelize.STRING(255),
        defaultValue: null,
        field: 'Participants'
    },
    Room_name: {
        type: Sequelize.STRING(255),
        defaultValue: null,
        field: 'Room_name'
    },
    Notif: {
        type: Sequelize.TEXT,
        defaultValue: null,
        field: 'Notif'
    },
    Admin: {
        type: Sequelize.TEXT,
        defaultValue: null,
        field: 'Admin'
    },
    Type: {
        type: Sequelize.STRING(5),
        defaultValue: null,
        field: 'Type'
    },
    Deactivated: {
      type: Sequelize.TINYINT(1),
      defaultValue: 0,
      field: 'Deactivated'
    },
    CallStatus: {
      type: Sequelize.ENUM,
      values: ['OnCall', 'NoCall'],
      defaultValue: 'NoCall',
      field: 'CallStatus'
    },
    CallId: {
      type: Sequelize.STRING(255),
      defaultValue: null,
      field: 'CallId'
    }
}, { timestamps: false, freezeTableName: true, tableName: 'chat' })

module.exports = Chat
