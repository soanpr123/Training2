const Setting = require('../public/config')
const idFunction = require('../public/javascripts/getId')
const jwt = require('jsonwebtoken')
const fs = require("fs")
const multer = require('multer')
const md5 = require('md5')
const mailer = require('../public/javascripts/mailer')
const User = require('../models/User')
const Constant = require('../constant')

function scrapeNumbers(string) {
    let seen = {};
    let results = [];
    string.match(/\d+/g).forEach(function (x) {
        if (seen[x] === undefined)
            results.push(parseInt(x));
        seen[x] = true;
    });
    return results;
}

const storage = multer.diskStorage({
    destination: function (req, file, cb) {
        cb(null, 'public/avatars')
    },
    filename: function (req, file, cb) {
        cb(null, md5(Date.now()) + '_' + file.originalname)
        //cb(null,file.originalname)
    }
})

const upload = multer({ storage: storage }).single('file')
/*
const multipartUpload = multer({storage : multer.diskStorage({
    destination : function (req,file,cb) {cb(null, 'public/avatars')},
    filename : function(req,file,cb){cb(null,Date.now()+'_'+file.originalname)}
})}).single('file')*/

exports.editProfile = async (req, res) => {
    const idUser = await idFunction.getID(req.body.token)
    let bio1 = req.body.bio
    let bio2 = bio1.split("'")
    let updateUser = {
        first_name: req.body.first_name,
        last_name: req.body.last_name,
        display_name: req.body.display_name,
        phone: req.body.phone,
        company: req.body.company,
        bio: bio2.join("\\'")
    }
    User.update(updateUser, {
        where: {
            id: idUser
        }
    }).then(result => {
        res.json({ message: 'Successful editing' })
    }).catch(err => {
        console.log(err)
        res.json({ message: 'err' })
    })
}

exports.changeAvatar = (req, res) => {
    upload(req, res, async function (err) {
        if (err) {
            console.log(err);
            res.json({ message: 'err' })
        } else {
            User.findOne({
                attributes: ['avatars'],
                where: {
                    id: await idFunction.getID(req.body.token)
                }
            }).then(async result => {
                if (!req.file) {
                    res.json({ msg: 'Required image' })
                } else {
                    if (result.avatars != 'Anonyme.jpeg') {
                        try {
                            fs.unlinkSync('public/avatars/' + result.avatars)
                        } catch (error) {
                            console.log(error)
                        }
                    }
                    return User.update({
                        avatars: req.file.filename
                    }, {
                        where: {
                            id: await idFunction.getID(req.body.token)
                        }
                    })
                }
            }).then(result => {
                res.json({ file: req.file.filename })
            }).catch(err => {
                console.log(err)
                res.json({ message: 'err' })
            })
        }
    })
}

exports.deleteAvatar = async (req, res) => {
    const idUser = await idFunction.getID(req.body.token)
    User.findOne({
        attributes: ['avatars'],
        where: {
            id: idUser
        }
    }).then(result => {
        if (result.avatars != 'Anonyme.jpeg') {
            try {
                fs.unlinkSync('public/avatars/' + result.avatars)
            } catch (error) {
                console.log(error)
                res.json({ message: 'err' })
            }
        }
        return User.update({
            avatars: 'Anonyme.jpeg'
        }, {
            where: {
                id: idUser
            }
        })
    }).then(result => {
        res.json({ file: req.file.filename })
    }).catch(err => {
        console.log(err)
        res.json({ message: 'err' })
    })
}

exports.changeEmail = async (req, res) => {
    const idUser = await idFunction.getID(req.body.token)
    User.findOne({
        where: {
            id: idUser,
            email: req.body.email
        }
    }).then(async result => {
        console.log(1)
        let payload = {
            'id': idUser,
            'email': req.body.newEmail
        }
        let token = jwt.sign(payload, Setting.defaultSettings.PRIVATE_KEY, Constant.JWT_OPTION)
        let content = `
            <div style="padding:5% 7% 5% 7%; border-spacing: 0;vertical-align: top;text-align: left;background: black">
                <div style="font-size: 14px;font-weight: normal;color: white;font-family: 'Open Sans', Helvetica, sans-serif;padding: 0;text-align: left;line-height: 1.3;">
                    <strong>New Email Address:</strong> <a style="color: #2D7ABF;text-decoration: underline;">${req.body.newEmail}</a>
                </div>
            </div>

            <div style="padding:5% 7% 5% 7%">
                <p style="${Constant.MAIL_STYLE.body}">
                    We received a request to change your email address. If you requested this change, please click the link below to continue.
                </p>

                <p style="${Constant.MAIL_STYLE.body}">
                    If you have any questions, please do not hesitate to email us at <a href="mailto:webrtc.bhsoft@gmail.com" style="color: #2D7ABF;text-decoration: underline;">webrtc.bhsoft@gmail.com</a>
                </p>
                <a href="${Setting.defaultSettings.FE_URL + '/verifiedEmail/' + token}" style="color: #ffffff;text-decoration: none;background-color: #2D7ABF;border-bottom: 2px solid #052D51;border-radius: 3px;display: block;font-size: 13px;font-weight: bold;line-height: 50px;text-align: center;min-width: 200px;width: auto;-webkit-text-size-adjust: none;max-width:50px;font-family: 'Helvetica', 'Arial', sans-serif;margin: 10% 0 8% 0;">
                    Change Email
                </a>
            </div>
        `
        const user = await User.findOne({
            where: {
                email: req.body.newEmail
            }
        })
        if (user) {
            res.json({ message: 'already used' })
        } else {
            mailer.sendMail(req.body.newEmail, 'UET Communication - Verify new email', content).then(result => {
                res.json({ message: 'mail send' })
            })
        }
    }).catch(err => {
        console.log(2)
        console.log(err)
        res.json({ message: 'Wrong email address' })
    })
}

exports.userProfile = async (req, res) => {
    const idUser = await idFunction.getID(req.body.token)
    if (req.body.token) {
        const user = await User.findOne({
            attributes: [
                'id', 'first_name', 'last_name', 'email',
                'phone', 'company', 'display_name', 'bio',
                'status', 'friends_list', 'invitations', 'avatars'
            ],
            where: {
                id: idUser
            }
        })
        if (user) {
            let friendsList = user.friends_list != '' ? scrapeNumbers(user.friends_list).toString() : ''
            let friendArray = friendsList.split(',')
            let invitationArray = user.invitations.split(',')
            await User.update({
                friends_list: friendsList
            }, {
                where: {
                    id: user.id
                }
            })

            if (friendsList != '') {
                User.findAll({
                    attributes: ['id', 'first_name', 'last_name', 'display_name', 'status', 'avatars'],
                    where: {
                        id: { $in: friendArray }
                    }
                }).then(friendInfo => {
                    if (user.invitations != '') {
                        User.findAll({
                            attributes: ['id', 'first_name', 'last_name', 'email', 'status', 'display_name'],
                            where: {
                                id: { $in: invitationArray }
                            }
                        }).then(r => {
                            res.json({
                                message: 'F and I',
                                infoUser: user,
                                infoFriends: friendInfo,
                                infoInvits: r,
                                avatarUser: user.avatars
                            })
                        }).catch(e => {
                            console.log('Err request infoI: ' + e)
                            res.json({ message: 'error request infoInvitation with friends' })
                        })
                    } else {
                        res.json({ message: 'F and No I', infoUser: user, infoFriends: friendInfo, avatarUser: user.avatars })
                    }
                }).catch(err => {
                    console.log(err)
                    res.json({ message: 'error request infoFriends' })
                })
            } else {
                if (user.invitations != '') {
                    User.findAll({
                        attributes: ['id', 'first_name', 'last_name', 'email', 'status', 'display_name'],
                        where: {
                            id: { $in: invitationArray }
                        }
                    }).then(result => {
                        res.json({
                            message: 'No F and I',
                            infoUser: user,
                            infoInvits: result,
                            avatarUser: user.avatars,
                            infoFriends: []
                        })
                    }).catch(err => {
                        console.log('Error request infoInvitation ' + err)
                        res.json({ message: 'error request infoInvitation with friends' })
                    })
                } else {
                    res.json({ message: 'No F and No I', infoUser: user, avatarUser: user.avatars })
                }
            }
        } else {
            res.json({ message: 'error request' })
        }
    } else {
        res.json({ mes: 'err' })
    }

}

exports.userStatus = async (req, res) => {
    const idUser = await idFunction.getID(req.body.token)
    if (req.body.token) {
        User.update({
            status: req.body.status
        }, {
            where: {
                id: idUser
            }
        }).then(result => {
            res.json({ message: 'update status' })
        }).catch(err => {
            res.json({ message: 'error' })
        })
    } else {
        res.json({ message: 'error' })
    }
}

exports.updateStatus = async (req, res) => {
    const idUser = await idFunction.getID(req.body.token)
    if (req.body.token) {
        User.findOne({
            attributes: ['friends_list', 'invitations'],
            where: {
                id: idUser
            }
        }).then(user => {
            let invitations = user.invitations
            let friendsList = user.friends_list !== '' ? scrapeNumbers(user.friends_list).toString() : ''
            let invitationArray = invitations.split(',')
            let friendArray = friendsList.split(',')
            if (friendsList != '') {
                User.findAll({
                    attributes: ['id', 'first_name', 'last_name', 'display_name', 'status', 'avatars', 'email'],
                    where: {
                        id: { $in: friendArray }
                    }
                }).then(result => {
                    if (user.invitations == '') {
                        res.json({ message: 'update status', status: result });
                    } else {
                        User.findAll({
                            attributes: ['id', 'first_name', 'last_name', 'email', 'display_name'],
                            where: {
                                id: { $in: invitationArray }
                            }
                        }).then(r => {
                            res.json({ message: 'invitation', data: r, status: result })
                        }).catch(e => {
                            console.log('Update status err: ' + e)
                            res.json({ message: 'error invitations infos request' })
                        })
                    }
                }).catch(err => {
                    console.log('Update status err: ' + err)
                    res.json({ message: 'error invitations infos request' })
                })
            } else {
                if (invitations != '') {
                    User.findAll({
                        attributes: ['id', 'first_name', 'last_name', 'email', 'display_name'],
                        where: {
                            id: { $in: invitationArray }
                        }
                    }).then(result => {
                        res.json({ message: 'invitation', data: result, status: [] })
                    }).catch(err => {
                        console.log('Update status err:  ' + err)
                        res.json({ message: 'error invitations infos request' })
                    })
                } else {
                    res.json({ message: 'nothing' })
                }
            }
        }).catch(err => {
            console.log('Update status err: ' + err)
            res.json({ message: 'err' })
        })
    } else {
        res.json({ mes: 'err' })
    }
}

exports.singleUserProfile = (req, res) => {
    User.findOne({
        attributes: ['id', 'email', 'display_name', 'status', 'avatars'],
        where: {
            id: req.body.idFriend
        }
    }).then(result => {
        let user = {
            id: result.id,
            email: result.email,
            display_name: result.display_name,
            status: result.status,
            avatars: result.avatars,
        };
        res.json({ user: user })
    }).catch(err => {
        console.log(err)
        res.json({ message: 'err' })
    })
}
