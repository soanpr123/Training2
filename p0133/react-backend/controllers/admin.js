const User = require('../models/User')
const Chat = require('../models/Chat')
const CallLog = require('../models/CallLog')
const Constant = require('../constant')
const idFunction = require('../public/javascripts/getId')
const crypto = require('../public/javascripts/saltHashPassword/index')

exports.afficheUsers = async (req, res) => {
    const idUser = await idFunction.getID(req.body.token)
    User.findAll({
        attributes: Constant.USER_RETURN_ATTRIBUTES,
        where: {
            id: { $ne: idUser }
        }
    }).then(result => {
        return res.json({ tab: result })
    }).catch(err => {
        console.log(err)
        res.json({ message: 'err' })
    })

}

exports.statistics = async (req, res) => {
    try {
        const id = await idFunction.getID(req.body.token)
        const users = await User.findAll()
        const groups = await Chat.findAll({
            where: {
                Type: 'Group'
            }
        })
        const callLogs = await CallLog.findAll()
        const messages = global.redis_messages.map(room => (room.messages.length)).reduce((acc,next) => acc + next, 0)
        console.log(global.redis_messages[0])
        return res.json({ totalUsers: users.length - 1, totalGroups: groups.length, totalCalls: callLogs.length, totalMessages: messages })
    } catch (error) {
        console.log(error)
        res.json({ message: 'err' })
    }
}

exports.deleteUsers = async (req, res) => {
    const idUser = await idFunction.getID(req.body.token)
    User.destroy({
        where: {
            id: req.body.id
        }
    }).then(success => {
        return User.findAll({
            attributes: ['id', 'friends_list']
        })
    }).then(async result => {
        for (let x = 0; x < result.length; x++) {
            if (result[x].friends_list != null) {
                let allFriends = result[x].friends_list.split(',')
                for (let i = 0; i < allFriends.length; i++) {
                    if (allFriends[i] == req.body.id.toString()) {
                        allFriends.splice(i, 1);
                    }
                }
                await User.update({
                    friends_list: allFriends.join(',')
                }, {
                    where: {
                        id: result[x].id
                    }
                })
            }
        }
        return User.findAll({
            attributes: Constant.USER_RETURN_ATTRIBUTES,
            where: {
                id: { $ne: idUser }
            }
        })
    }).then(result => {
        return res.json({ message: 'User deleted', tab: result })
    }).catch(err => {
        console.log(err)
        res.json({ message: 'error delete function' })
    })

}

exports.searchUser = async (req, res) => {
    const idUser = await idFunction.getID(req.body.token)
    User.findAll({
        where: {
            attributes: Constant.USER_RETURN_ATTRIBUTES,
            id: { $ne: idUser },
            $or: [{
                first_name: { $eq: req.body.value }
            }, {
                last_name: { $eq: req.body.value }
            }, {
                email: { $eq: req.body.value }
            }]
        },
    }).then(result => {
        return res.json({ tab: result })
    }).catch(err => {
        console.log(err);
        res.json({ message: 'err' })
    })
}

exports.editUsers = async (req, res) => {
    const idUser = await idFunction.getID(req.body.token)
    const updateData = {
        first_name: req.body.first_name,
        last_name: req.body.last_name,
        display_name: req.body.display_name,
        email: req.body.email,
        role: req.body.role,
        activated: req.body.activated,
        verified: req.body.verified
    }
    await User.update(updateData, {
        where: {
            id: req.body.id
        }
    })
    User.findAll({
        attributes: Constant.USER_RETURN_ATTRIBUTES,
        where: {
            id: { $ne: idUser }
        }
    }).then(result => {
        return res.json({ tab: result });
    }).catch(err => {
        console.log(err);
        res.json({ message: 'err' });
    })
}

exports.addUser = async (req, res) => {
    const idUser = await idFunction.getID(req.body.token)
    let passwordData = await crypto.saltHashPassword(req.body.password)
    const addUser = {
        first_name: req.body.first_name,
        last_name: req.body.last_name,
        email: req.body.email,
        passwrd: passwordData.passwordHash,
        phone: req.body.phone,
        bio: null,
        company: null,
        friends_list: '',
        verified: req.body.verified,
        saltKey: passwordData.salt,
        activated: req.body.activated,
        status: 'Offline',
        role: req.body.role,
        display_name: req.body.display_name,
        nbConnect: 0,
        invitations: '',
        avatars: 'Anonyme.jpeg',
        personalId: req.body.personalId,
        createdDate: Date.now()
    }
    const user = await User.findOne({
        where: {
            email: req.body.email
        }
    })
    if (user) {
        res.json({ message: 'account' })
    } else {
        User.create(addUser).then(result => {
            return User.findAll({
                attributes: Constant.USER_RETURN_ATTRIBUTES,
                where: {
                    id: { $ne: idUser }
                }
            })
        }).then(result => {
            res.json({ tab: result })
        }).catch(err => {
            console.log(err)
            res.send({ message: 'err add' })
        })
    }
}
