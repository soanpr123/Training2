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
    userId: {
        type: Sequelize.INTEGER(11),
        allowNull: false,
        references: User,
        referencesKey: 'id',
        field: 'userId'
    },
    scheduleStatus: {
        type: Sequelize.ENUM,
        values: ['Waiting', 'OnCall', 'MissedCall', 'Done', 'Rejected', 'Expired'],
        defaultValue: 'Waiting',
        field: 'scheduleStatus'
    },
    cbtvId: {
        type: Sequelize.INTEGER(11),
        defaultValue: null,
        references: User,
        referencesKey: 'id',
        field: 'cbtvId'
    },
    createdDate: {
        type: Sequelize.DOUBLE(32, 0),
        allowNull: false,
        field: 'createdDate'
    },
    startDate: {
        type: Sequelize.DOUBLE(32, 0),
        defaultValue: null,
        field: 'startDate'
    },
    endDate: {
        type: Sequelize.DOUBLE(32, 0),
        defaultValue: null,
        field: 'endDate'
    },
    note: {
        type: Sequelize.TEXT,
        defaultValue: null,
        field: 'note'
    },
    bookingExpireDate: {
        type: Sequelize.DOUBLE(32, 0),
        allowNull: false,
        field: 'bookingExpireDate'
    },
    room_id: {
        type: Sequelize.INTEGER(11),
        defaultValue: null,
        field: 'room_id'
    },
    topic: {
        type: Sequelize.ENUM,
        values: ['chung', 'daotao_chuongtrinh', 'congtac_sinhvien', 'taichinh_hocphi'],
        allowNull: false,
        field: 'topic'
    }
}, { timestamps: false, freezeTableName: true, tableName: 'schedule' })

module.exports = Schedule
