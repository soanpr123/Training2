const idFunction = require('../public/javascripts/getId')
const User = require('../models/User')
const Chat = require('../models/Chat')

let redis_messages = []
global.redisClient.on('connect', () => {
    global.redisClient.get('messages', (err, reply) => {
        if (reply) {
            redis_messages = JSON.parse(reply)
        }
    })
})

scrapeNumbers = (string) => {
    var seen = {};
    var results = [];
    string.match(/\d+/g).forEach(function (x) {
        if (seen[x] === undefined)
            results.push(parseInt(x));
        seen[x] = true;
    });
    return results;
}

exports.userFriends = async (req, res) => {
    const idUser = await idFunction.getID(req.body.token)
    const user = await User.findOne({
        attributes: ['friends_list'],
        where: {
            id: { $in: idUser }
        }
    })
    let friendsList = user.friends_list.split(',')
    if (friendsList.length > 0) {
        User.findAll({
            attributes: ['first_name', 'last_name', 'display_name', 'status', 'avatars'],
            where: {
                id: { $in: friendsList }
            }
        }).then(r => {
            res.json({ message: 'friends', friendsInfos: r })
        }).catch(e => {
            res.json({ message: 'error infoFriends request' })
        })
    } else {
        res.json({ message: 'No friends' })
    }
}

exports.searchFriend = async (req, res) => {
    const idUser = await idFunction.getID(req.body.token)
    User.findAll({
        attributes: ['first_name', 'last_name', 'display_name', 'email'],
        where: {
            id: { $ne: idUser }
        }
    }).then(result => {
        for (var i = 0; i < result.length; i++) {
            result[i].first_name = decodeURI(result[i].first_name);
            result[i].last_name = decodeURI(result[i].last_name);
            result[i].display_name = decodeURI(result[i].display_name);
        }
        res.json({ message: 'request ok', data: result });
    }).catch(e => {
        res.json({ message: 'err request' })
    })
}

exports.friendInfo = (req, res) => {
    User.findOne({
        attributes: ['id', 'first_name', 'last_name', 'display_name', 'email', 'bio', 'company', 'phone', 'status'],
        where: {
            id: req.body.idFriend
        }
    }).then(result => {
        res.json({ message: 'info', info: result })
    }).catch(e => {
        console.log(e)
        res.json({ message: '' })
    })
}

exports.deleteFriend = async (req, res) => {
    const idUser = await idFunction.getID(req.body.token)
    let idFriend = req.body.idFriend

    const listFriend = await User.findOne({
        attributes: ['friends_list'],
        where: {
            id: idUser
        }
    })

    let friendArray = listFriend.friends_list.split(',')
    for (let i = 0; i < friendArray.length; i++) {
        if (friendArray[i] === idFriend.toString()) {
            friendArray[i] = ':'
        }
    }

    friendArray = friendArray.toString().replace(':,', '').replace(',:', '').replace(':', '')

    await User.update({
        friends_list: friendArray
    }, {
        where: {
            id: idUser
        }
    })

    let users_in_room = [idFriend]
    users_in_room.push(idUser)
    let regex = /,/gi;
    let room = users_in_room.sort((a, b) => a - b).toString().replace(regex, ':')
    let room_name = room;
    Chat.findOne({
        where: {
            Participants: room,
            Room_name: room_name
        }
    }).then(async result => {
        if (result != null) {
            await Chat.destroy({
                where: {
                    Id: result.Id
                }
            })
            const filteredRoom = redis_messages.filter((item) => item.roomId !== result.Id)
            if (filteredRoom != 'undefined') {
                global.redisClient.set('messages', JSON.stringify(filteredRoom))
            }
        }

    }).catch(err => {
        console.log(err)
        res.json({ message: 'err' })
    })

    // update list friend of friend
    const listFriendOfFriend = await User.findOne({
        attributes: ['friends_list'],
        where: {
            id: idFriend
        }
    })
    let friendArrayOfFriend = listFriendOfFriend.friends_list.split(',')
    for (let i = 0; i < friendArrayOfFriend.length; i++) {
        if (friendArrayOfFriend[i] === idUser.toString()) {
            friendArrayOfFriend[i] = ':'
        }
    }
    friendArrayOfFriend = friendArrayOfFriend.toString().replace(':,', '').replace(',:', '').replace(':', '')
    await User.update({
        friends_list: friendArrayOfFriend
    }, {
        where: {
            id: idFriend
        }
    })

    // return current list friend of user
    if (friendArray) {
        User.findAll({
            attributes: ['id', 'first_name', 'last_name', 'status', 'avatars'],
            where: {
                id: { $in: friendArray.split(',') }
            }
        }).then(result => {
            res.json({ message: 'ok', newFriendList: result })
        })
    } else {
        res.json({ message: 'friends empty' })
    }
}
