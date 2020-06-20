const Setting = require('../public/config')
const User = require('../models/User')
const Constant = require('../constant')
const idFunction = require('../public/javascripts/getId')
const jwt = require('jsonwebtoken')
const mailer = require('../public/javascripts/mailer')


exports.sendInvitation = async (req, res) => {
    const idUser = await idFunction.getID(req.body.token)
    req.checkBody('token', 'Token is required').notEmpty()
    const errors = req.validationErrors()
    if (errors) {
        return res.status(200).send(JSON.stringify({ state: false, msg: errors[0].msg }))
    } else {
        const user = await User.findOne({
            attributes: ['id'],
            where: {
                email: req.body.email
            }
        })
        if (!user) {
            const token = jwt.sign({ id: idUser }, Setting.defaultSettings.PRIVATE_KEY, Constant.JWT_OPTION)
            mailer.sendMail(req.body.email, 'Join Voispy now', `<a href="${Setting.defaultSettings.FE_URL}/signup/${token}">Sign up on VOISPY now</a>`).then(r => {
                res.status(200).send(JSON.stringify({ state: true, msg: 'Mail sent successfully!' }))
            }).catch(err => {
                console.log(err)
                return res.status(500).send(JSON.stringify({ state: false, msg: 'err' }))
            })
        } else {
            let idFriend = user.id
            User.findOne({
                attributes: ['friends_list', 'invitations'],
                where: {
                    id: idUser
                }
            }).then(async result => {
                let friendsList = result.friends_list.split(',')
                let invitations = result.invitations.split(',')
                let friend = true
                let invite = true
                for (let i = 0; i < friendsList.length; i++) {//We check if the user he want to add is not already in his/her friend list
                    if (friendsList[i] == idFriend) {
                        friend = false
                        res.json({ message: 'already friend', id: idFriend })
                    }
                }
                for (let i = 0; i < invitations.length; i++) {
                    if (invitations[i] == idFriend) {
                        invite = false;
                        res.json({ message: 'You already receive an invitation from this user ! Check your invitations', id: idUser })
                    }
                }
                if (friend && invite) {
                    User.findOne({
                        attributes: ['invitations'],
                        where: {
                            id: idFriend
                        }
                    }).then(async result => {
                        if (result.invitations == '') {
                            await User.update({
                                invitations: idUser
                            }, {
                                where: {
                                    id: idFriend
                                }
                            })
                            res.json({ message: '1st invitation send', id: idFriend })
                        } else {
                            let invitationsFriend = result.invitations.split(',')
                            let newInvitations = result.invitations + ',' + idUser
                            let test = true
                            for (let i = 0; i < invitationsFriend.length; i++) {
                                if (invitationsFriend[i] == idUser) {
                                    test = false
                                    res.json({ message: 'invitations already send', id: idFriend })
                                }
                            }
                            if (test) {
                                await User.update({
                                    invitations: newInvitations
                                }, {
                                    where: {
                                        id: idFriend
                                    }
                                })
                                res.json({ message: 'invitation send', id: idUser })
                            }
                        }
                    }).catch(e => {
                        console.log(e)
                        res.json({ message: 'error invitations request' })
                    })
                }
            }).catch(err => {
                console.log(err)
                return res.status(500).send(JSON.stringify({ state: false, msg: 'err' }))
            })
        }
    }
}

exports.refuseInvitation = async (req, res) => {
    const idUser = await idFunction.getID(req.body.token)
    var idFriend = req.body.id
    const user = await User.findOne({
        attributes: ['invitations'],
        where: {
            id: idUser
        }
    })
    let invitations = user.invitations.split(',')
    for (let i = 0; i < invitations.length; i++) {
        if (invitations[i] == idFriend.toString()) {
            invitations.splice(i, 1)
        }
    }
    let newInvite = ''
    if (invitations.length > 0) {
        newInvite = invitations.join(',')
    }

    await User.update({
        invitations: newInvite
    }, {
        where: {
            id: idUser
        }
    })

    if (newInvite == '') {
        res.json({ message: 'invitation refused ok & No I' })
    } else {
        User.findAll({
            attributes: ['id', 'first_name', 'last_name', 'email'],
            where: {
                id: { $in: newInvite }
            }
        }).then(r => {
            res.json({ message: 'invitation refused ok & I', newInvitsInfo: r })
        }).catch(e => {
            res.json({ message: 'erreur new Invits' })
        })
    }
}

exports.acceptInvitation = async (req, res) => {
    const idUser = await idFunction.getID(req.body.token)
    const user = await User.findOne({
        attributes: ['friends_list', 'invitations'],
        where: {
            id: idUser
        }
    })

    let invitations = user.invitations.split(',')
    for (let i = 0; i < invitations.length; i++) {
        if (invitations[i] == req.body.idFriend.toString()) {
            invitations.splice(i, 1);
        }
    }

    let newInvite = ''
    if (invitations.length > 0) {
        newInvite = invitations.join(',')
    }

    let updateFriendList = {
        friends_list: user.friends_list ? user.friends_list + ',' + req.body.idFriend : req.body.idFriend,
        invitations: newInvite
    }
    await User.update(updateFriendList, {
        where: {
            id: idUser
        }
    })

    const friend = await User.findOne({
        attributes: ['friends_list'],
        where: {
            email: req.body.emailFriend
        }
    })

    let friendFriendList = {
        friends_list: friend.friends_list ? friend.friends_list + "," + idUser : idUser
    }
    let where = friend.friends_list ? { where: { email: req.body.emailFriend } } : { where: { id: req.body.idFriend } }
    await User.update(friendFriendList, where)

    User.findAll({
        attributes: ['first_name', 'last_name', 'status', 'avatars'],
        where: {
            id: { $in: user.friends_list.split(',') }
        }
    }).then(newFriendsInfo => {
        if (user.invitations != '') {
            User.findAll({
                attributes: ['id', 'first_name', 'last_name', 'email'],
                where: {
                    id: { $in: invitations }
                }
            }).then(result => {
                res.json({ message: 'New Invitations', newFriendsInfo: newFriendsInfo, newInvitsInfo: result })
            })
        } else {
            res.json({ message: 'No more invitations', newFriendsInfo: newFriendsInfo })
        }
    }).catch(err => {
        res.json({ message: 'err' })
    })
}
