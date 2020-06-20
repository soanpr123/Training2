const { sequelize, Sequelize } = require('./Sequelize')
const User = require('./User')

const Schedule = sequelize.define('Schedule', {
  id: {
    type: Sequelize.INTEGER(11),
    allowNull: false,
    primaryKey: true,
    autoIncrement: true,
    field: 'id'
  },
  participants: {
    type: Sequelize.STRING(255),
    defaultValue: null,
    field: 'participants'
  },
  startDate: {
    type: Sequelize.DOUBLE(32, 0),
    allowNull: false,
    field: 'startDate'
  },
  endDate: {
    type: Sequelize.DOUBLE(32, 0),
    defaultValue: null,
    field: 'endDate'
  },
  status: {
    type: Sequelize.ENUM,
    values: ['OnGoing', 'Ended'],
    defaultValue: 'OnGoing',
    field: 'status'
  },
  groupName: {
    type: Sequelize.STRING(255),
    defaultValue: null,
    field: 'groupName'
  },
}, { timestamps: false, freezeTableName: true, tableName: 'callLogs' })

module.exports = Schedule
