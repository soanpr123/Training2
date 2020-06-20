const idFunction = require('../public/javascripts/getId');
const fs = require('fs')
const md5 = require('md5')
const path = require('path')
const settings = require('../public/config')
const Chat = require('../models/Chat')
const User = require('../models/User')
const CallLog = require('../models/CallLog')
const ss = require('socket.io-stream')

/**
 * Config
 */
const uploadPath = path.join('public', settings.defaultSettings.uploadPath || 'files')

let redis_messages = []
let redis_sockets = []
let call_room = []

global.redisClient.on('connect', () => {
    global.redisClient.get('messages', (err, reply) => {
        if (reply) {
            redis_messages = JSON.parse(reply)
            global.redis_messages = redis_messages
        }
    })
    global.redisClient.get('sockets', (err, reply) => {
        if (reply) {
            redis_sockets = JSON.parse(reply)
        }
    })
})

function onlyUnique(value, index, self) {
    return self.indexOf(value) === index
}

exports.userChat = async (req, res) => {
    let id = await idFunction.getID(req.body.token)
    let display_name = req.body.display_name + ','
    Chat.findAll({
        where: {
            $or: [{
                Participants: { $like: `${id}:%` }
            }, {
                Participants: { $like: `%:${id}` }
            }, {
                Participants: { $like: `%:${id}:%` }
            }],
            Deactivated: { $ne: 1 }
        }
    }).then(result => {
        let response = { message: 'test', group: [], private: [] }
        for (let x = 0; x < result.length; x++) {
            if (result[x].Notif === '' || (result[x].Notif.match(new RegExp(display_name, "gi")) === null)) {
                if (result[x].Participants.match(new RegExp(':', "gi")).length >= 2) {
                    response.group.push({ name: result[x].Room_name })
                } else {
                    response.private.push({ name: result[x].Room_name })
                }
            }
        }
        res.json(response)
    }).catch(err => {
        console.log(err);
        res.json({ message: 'err', group: [], private: [] })
    })
}

exports.groupChat = async (req, res) => {
    var id = await idFunction.getID(req.body.token)
    Chat.findAll({
        where: {
            $or: [{
                Participants: { $like: `${id}:%` }
            }, {
                Participants: { $like: `%:${id}` }
            }, {
                Participants: { $like: `%:${id}:%` }
            }],
            Deactivated: { $ne: 1 }
        }
    }).then(result => {
        let _idlist = []
        for (let x = 0; x < result.length; x++) {
            if (result[x].Participants.match(new RegExp(':', "gi")).length >= 1) {
                const re = /^:*(.*?):*$/
                const reresult = result[x].Participants.trim().match(re);
                var conv1 = reresult[1].split(':')
                var conv = conv1.filter(onlyUnique)
                for (let i = 0; i < conv.length; i++) {
                    if (conv[i] !== '') {
                        _idlist.push(conv[i])
                    }
                }
            }
        }
        if (_idlist.length <= 0) {
            res.json({ message: 'nothing' })
        } else {
            _idlist = _idlist.filter(onlyUnique).toString()
            let response = { message: 'groupChat', envoi: [] }
            User.findAll({
                attributes: ['id', 'display_name', 'avatars', 'status'],
                where: {
                    id: { $in: _idlist.split(',') }
                }
            }).then(async resu => {
                let tableau = []
                for (let i = 0; i < resu.length; i++) {
                    tableau.push(resu[i].id)
                }
                for (let x = 0; x < result.length; x++) {
                    if (result[x].Type === 'Group') {
                        const re = /^:*(.*?):*$/;
                        const reresult = result[x].Participants.trim().match(re);
                        var conv1 = reresult[1].split(':')
                        var conv = conv1.filter(onlyUnique)
                        var bla = { name: result[x].Room_name, roomId: result[x].Id, part: [], callStatus: result[x].CallStatus, call_group_id: result[x].CallId }
                        if (call_room.findIndex(val => val.call_group_chat_room_id === result[x].Id) === -1) {
                            await Chat.update({
                                CallStatus: 'NoCall',
                                CallId: ''
                            }, {
                                where: {
                                    Id: result[x].Id
                                }
                            })
                            bla.callStatus = '';
                            bla.call_group_id = '';
                        }

                        for (var i = 0; i < conv.length; i++) {
                            if (resu[tableau.indexOf(parseInt(conv[i], 10))]) {
                                bla.part.push({ id: resu[tableau.indexOf(parseInt(conv[i], 10))].id, name: resu[tableau.indexOf(parseInt(conv[i], 10))].display_name, avatars: resu[tableau.indexOf(parseInt(conv[i], 10))].avatars, status: resu[tableau.indexOf(parseInt(conv[i], 10))].status })
                            } else {

                            }
                        }
                        response.envoi.push(bla)
                    }
                }
                res.json(response)
            }).catch(err => {
                console.log(err);
                res.json({ message: 'err' })
            })
        }
    }).catch(err => {
        console.log(err);
        res.json({ message: 'err' })
    })
}

exports.downloadFile = async (req, res) => {
    var id = await idFunction.getID(req.body.token)
    Chat.findOne({
        where: {
            Id: req.body.room,
            Deactivated: { $ne: 1 }
        }
    }).then(result => {
        const users = result.Participants.split(':')
        if (users.indexOf(id) != id) {
            const file_path = path.resolve(uploadPath + "/" + req.body.filename);
            res.download(file_path, req.body.name)
        } else {
            res.json({ download: 'You are not allowed to download' })
        }
    }).catch(err => {
        console.log(err)
        res.json({ download: 'nothing' })
    })
}

/*======================[CHAT TEXT]====================*/
//listen on every connection
io.on('connection', (socket) => {
    console.log('A user connected with socket.id: ' + socket.id + "and: " + socket.ident);
    socket.on('disconnect', async () => {
        if (socket.ident != undefined) {
            console.log('Socket disconnected: ' + socket.ident + " socketid: " + socket.id)
            await User.update({
                status: 'Offline'
            }, {
                where: {
                    id: socket.ident
                }
            })
            setTimeout(() => {
                socket.broadcast.emit('disconnectOne', { message: 'socket disconnect', id: socket.ident })
            }, 750)
            // Remove user from redis_socket
            call_room = call_room.map(val => {
                let temp = val
                if (val.participants.indexOf(socket.ident) !== -1) {
                    temp.participants = val.participants.filter(v => v !== socket.ident)
                }
                return temp
            }).filter(val => val.participants.length > 1)
            redis_sockets = redis_sockets.filter(function (returnableObjects) {
                return returnableObjects.socketId !== socket.id;
            });
            await global.redisClient.set('sockets', JSON.stringify(redis_sockets))
        }
    })

    socket.on('user', async (data) => {
        console.log("redis_sockets: " + JSON.stringify(redis_sockets))
        socket.leaveAll()
        if (data.token) {
            socket.ident = await idFunction.getID(data.token);
            const user = redis_sockets.find(u => u.id == socket.ident)
            if (typeof user === 'undefined') {
                function timeout(ms) {
                    return new Promise(resolve => setTimeout(resolve, ms));
                }
                await timeout(1000)
                redis_sockets.push({ id: socket.ident, socketId: socket.id })
            } else {
                user.socketId = socket.id
            }
            await global.redisClient.set('sockets', JSON.stringify(redis_sockets))
            console.log("User: " + socket.ident + " joined socket id: " + socket.id)
            await User.findOne({
                attributes: ['display_name'],
                where: {
                    id: socket.ident
                }
            }).then(async result => {
                socket.username = result.display_name;
                await User.update({
                    status: 'Online'
                }, {
                    where: {
                        id: socket.ident
                    }
                })
                io.emit('connected', { message: 'connected', userid: socket.ident, socketid: socket.id })
                setTimeout(() => {
                    socket.broadcast.emit('connectOne', { message: 'socket connect', id: socket.ident })
                }, 250)
            })
            await Chat.findAll({
                where: {
                    $or: [{
                        Participants: { $like: `${socket.ident}:%` }
                    }, {
                        Participants: { $like: `%:${socket.ident}` }
                    }, {
                        Participants: { $like: `%:${socket.ident}:%` }
                    }],
                    Deactivated: { $ne: 1 }
                }
            }).then(async result => {
                let notif = []
                let notif_group = []
                for (let i = 0; i < result.length; i++) {
                    const users = result[i].Participants.split(':')
                    const numberParticipants = users.length
                    const room = redis_messages.find(mess => mess.roomId === result[i].Id)
                    const friend = users.find(u => u != socket.ident)
                    if (typeof room !== 'undefined') {
                        const lastSeen = room.lastSeen.find(last => last.id === socket.ident)
                        if (numberParticipants == 2) {
                            if (typeof lastSeen === 'undefined') {
                                if (room.messages.length > 0) {
                                    notif.push(friend)
                                }
                            } else {
                                if (lastSeen.index < room.messages.length) {
                                    notif.push(friend)
                                }
                            }
                        } else {
                            if (typeof lastSeen === 'undefined') {
                                if (room.messages.length > 0) {
                                    notif_group.push(result[i].Id)
                                }
                            }
                            else {
                                if (lastSeen.index < room.messages.length) {
                                    notif_group.push(result[i].Id)
                                }
                            }
                        }
                    } else {
                        redis_messages.push({ roomId: result[i].Id, messages: [], lastSeen: [] })
                    }
                }
                if (notif.length > 0 || notif_group.length > 0) {
                    socket.emit('notify_offline', { notif: notif, notif_group: notif_group })
                }
                await global.redisClient.set('messages', JSON.stringify(redis_messages))
                socket.emit('validation', { message: 'update on load', updateIds: "", roomId: "" })
            })
        }
    })

    socket.on('check_status', async (data) => {
        const idUser = await idFunction.getID(data.token)
        User.findOne({
            attributes: ['status'],
            where: {
                id: idUser
            }
        }).then(result => {
            socket.emit('check_status', { status: result })
        })
    })

    socket.on('checkNewUser', async (data) => {
        const _user = redis_sockets.find(u => u.id == data.id)
        const idUser = await idFunction.getID(data.token);
        if (_user) {
            socket.to(_user.socketId).emit('checkNewUser', { id: idUser })
        }
    });

    socket.on('allCheckNewUser', function (data) {
        socket.broadcast.emit('allCheckNewUser', { message: "check new user" })
    });

    socket.on('closeChatUserCbtv', async (data) => {
        const _user = redis_sockets.find(u => u.id == data.userId)
        const cbtvId = await idFunction.getID(data.token);
        console.log("close chat")
        if (_user) {
            socket.to(_user.socketId).emit('closeChatUserCbtv', { cbtvId: cbtvId, isCBTV: data.isCBTV })
        }
        socket.emit('closeChatUserCbtv', { cbtvId: cbtvId, isCBTV: data.isCBTV })
    })
    //listen on change_room (join room user to user)
    socket.on('change_room', async (data) => {
        // console.log("change_room data: " + JSON.stringify(data))
        let idUser = await idFunction.getID(data.token)
        socket.ident = idUser
        let idFriend = data.idFriend.slice(0)
        idFriend.push(idUser)
        let regex = /,/gi
        let room = idFriend.sort((a, b) => a - b).toString().replace(regex, ':')
        let room_name = room
        if (data.room_name) {
            room_name = encodeURI(data.room_name)
        }
        Chat.findAll({
            where: {
                Participants: room,
                Room_name: room_name,
                Deactivated: { $ne: 1 }
            }
        }).then(async result => {
            if (result.length <= 0) {
                if (data.isGroupChat) {
                    let chatInsert = {
                        Participants: room,
                        Room_name: room_name,
                        Notif: '',
                        Admin: idUser,
                        Type: 'Group'
                    }
                    console.log("createa")
                    await Chat.create(chatInsert).then().catch(e => console.log(e))
                } else {
                    let chatInsert = {
                        Participants: room,
                        Room_name: room_name,
                        Notif: '',
                        Admin: idUser,
                        Type: '1-1',
                        Deactivated: 0
                    }
                    await Chat.create(chatInsert).then().catch(e => console.log(e))
                }
                Chat.findAll({
                    attributes: ['Id'],
                    where: {
                        Participants: room,
                        Room_name: room_name,
                        Admin: idUser,
                        Deactivated: { $ne: 1 }
                    }
                }).then(async result => {
                    socket.room = result[0].Id;
                    socket.join(socket.room)
                    socket.emit('joinroom', { roomid: socket.room, idFriend: data.idFriend[0] });
                    // Init in Redis
                    redis_messages.push({ roomId: socket.room, messages: [], lastSeen: [] })
                    await global.redisClient.set('messages', JSON.stringify(redis_messages))
                    socket.broadcast.emit('validation', { message: 'create_group', updateIds: room, roomId: socket.room })
                    socket.emit('validation', { message: 'create_group', updateIds: room, roomId: socket.room })
                    socket.emit('groupExisted', { message: '' })
                }).catch(e => console.log(e))
            } else {
                if (result[0].Type === "Group") {
                    socket.emit('groupExisted', { message: 'groupExisted' })
                }
                // socket.emit('validation', { message: 'create group' })
                // socket.emit('groupExisted', { message: '' })
                socket.room = result[0].Id
                ////leave all room to avoid problem
                //socket.leaveAll()
                //join new room
                socket.join(socket.room)
                console.log("join room: " + socket.room)
                socket.emit('joinroom', { roomid: socket.room });
                const room = redis_messages.find(mess => mess.roomId === socket.room)
                if (typeof room === 'undefined') {
                    socket.emit('histo', { message: '' });
                } else {
                    let messages = room.messages
                    const lastSeen = room.lastSeen ? room.lastSeen.find(last => last.id === socket.ident) : undefined
                    // for case if user has change display name will update display_name history to new display name
                    if (messages) {
                        var filteredDisplay_name = messages.filter((item) => {
                            if (item.display_name && item.id) {
                                return item.id == idUser && item.display_name.trim() !== data.display_name
                            }
                        });
                    }
                    if (filteredDisplay_name.length > 0) {
                        let _messages = messages.map(obj =>
                            obj.id == idUser && obj.display_name !== data.display_name ? { ...obj, display_name: data.display_name } : obj
                        );
                        room.messages = _messages
                        await global.redisClient.set('messages', JSON.stringify(redis_messages))
                    }
                    if (messages.length > 50) {
                        var message = messages.slice(messages.length - 50, messages.length)
                        socket.emit('histo', { message: message });
                    } else {
                        if (typeof lastSeen === 'undefined') {
                            // room.lastSeen = []
                            if (messages.length > 50) {
                                var message = messages.slice(messages.length - 50, messages.length)
                                socket.emit('histo', { message: message });
                            } else {
                                socket.emit('histo', { message: messages });
                            }
                            room.lastSeen.push({ id: socket.ident, index: room.messages.length })
                        } else {
                            if (lastSeen.index < room.messages.length) {
                                lastSeen.index = room.messages.length
                            }
                            if (messages.length > 50) {
                                var message = messages.slice(messages.length - 50, messages.length)
                                socket.emit('histo', { message: message })
                            } else {
                                socket.emit('histo', { message: messages })
                            }
                        }
                    }
                }
                await global.redisClient.set('messages', JSON.stringify(redis_messages))
            }
        })
    })

    //listen on change_group_room (join room group)
    socket.on('change_group_room', async (data) => {
        socket.room = data.roomId;
        //socket.leaveAll()
        console.log("join group room: " + socket.room)
        //join new room
        socket.join(socket.room)

        const room = redis_messages.find(mess => mess.roomId === socket.room)
        if (typeof room === 'undefined') {
            redis_messages.push({ roomId: socket.room, messages: [], lastSeen: [] })
            socket.emit('histo', { message: '' });
        } else {
            const messages = room.messages
            const lastSeen = room.lastSeen.find(last => last.id === socket.ident)
            // check if messages empty
            if (messages.length === 0) {
                socket.emit('histo', { message: '' });
            } else {
                if (typeof lastSeen === 'undefined') {
                    if (messages.length > 50) {
                        var message = messages.slice(messages.length - 50, messages.length)
                        socket.emit('histo', { message: message });
                    } else {
                        socket.emit('histo', { message: messages });
                    }
                    room.lastSeen.push({ id: socket.ident, index: room.messages.length })
                } else {
                    if (lastSeen.index < room.messages.length) {
                        lastSeen.index = room.messages.length
                    }
                    if (messages.length > 50) {
                        var message = messages.slice(messages.length - 50, messages.length)
                        socket.emit('histo', { message: message })
                    } else {
                        socket.emit('histo', { message: messages })
                    }
                }
            }
        }
        await global.redisClient.set('messages', JSON.stringify(redis_messages))
    })

    //listen on new_message
    socket.on('new_message', async (data) => {
        socket.ident = await idFunction.getID(data.token)
        Chat.findOne({
            where: {
                Id: socket.room,
                Deactivated: { $ne: 1 }
            }
        }).then(async result => {
            var users = result.Participants.split(':')
console.log("resoult"+ result.Type);
            console.log("new_message users: " + users)
            if (result.Type === 'Group') { // for group > 2 user
                await Chat.update({ Notif: '' }, {
                    where: {
                        Id: socket.room
                    }
                })
                const room = redis_messages.find(mess => mess.roomId === socket.room)
console.log('Room là : ' + room);
                if (typeof room === 'undefined') {
                    try {
                        const room = redis_messages.find(mess => mess.roomId === socket.room)
                        room.messages.push({ id: socket.ident, display_name: socket.username, message: data.message, time: data.time, isReading: false })
                    } catch (err) {
                        console.log(err)
                    }
                } else {
                    room.messages.push({ id: socket.ident, display_name: socket.username, message: data.message, time: data.time, isReading: false })
                    const lastSeen = room.lastSeen.find(last => last.id === socket.ident)
                    console.log('lastSeen là : ' + lastSeen);
                    if (typeof lastSeen === 'undefined') {
                        room.lastSeen.push({ id: socket.ident, index: room.messages.length })
                    } else {
                        lastSeen.index = room.messages.length
                    }
                }
                await global.redisClient.set('messages', JSON.stringify(redis_messages))

                console.log("BE Group emit notify_msg to: " + socket.room)
                const socket_users = redis_sockets.filter(u => users.indexOf(u.id.toString()) !== -1)
                for (let i = 0; i < socket_users.length; i++) {
                    socket.to(socket_users[i].socketId).emit("notify_msg", { message: data.message, username: socket.username, verif: 0, room: socket.room, userid: socket.ident, isRoomMultiUsr: true, time: data.time })
                }
            } else { // for priate chat
                for (var x = 0; x < users.length; x++) {
                    if (users[x].trim() !== socket.ident.toString()) {
                        await Chat.update({ Notif: '' }, {
                            where: {
                                Id: socket.room
                            }
                        })
                        const room = redis_messages.find(mess => mess.roomId === socket.room)
                        if (typeof room === 'undefined') {
                            try {
                                redis_messages.push({ roomId: socket.room, messages: [{ id: socket.ident, display_name: socket.username, message: data.message, time: data.time, isReading: false }] })
                            } catch (err) {
                                console.log(err)
                            }
                        } else {
                            room.messages.push({ id: socket.ident, display_name: socket.username, message: data.message, time: data.time, isReading: false })
                            const lastSeen = room.lastSeen.find(last => last.id === socket.ident)

                            if (typeof lastSeen === 'undefined') {
                                room.lastSeen.push({ id: socket.ident, index: room.messages.length })
                            } else {
                                lastSeen.index = room.messages.length
                            }
                        }
                        await global.redisClient.set('messages', JSON.stringify(redis_messages))

                        const _user = redis_sockets.find(u => u.id == users[x])
                        if (typeof _user !== 'undefined') {
                            console.log("BE notify_msg emit to: uid: " + users[x] + " socketid: " + _user.socketId)
                            socket.to(_user.socketId).emit("notify_msg", { message: data.message, username: socket.username, verif: 0, room: socket.room, userid: socket.ident, isRoomMultiUsr: false, time: data.time });
                        }
                    }
                }
            }
        })
    })

    socket.on('validation', (data) => {
        socket.broadcast.emit('validation', { message: 'update_group', updateIds: '', roomId: data.roomId })
    })
    //Add new user in conversation
    socket.on('new_user', (data) => {
        Chat.findOne({
            where: {
                Id: data.roomId,
                Deactivated: { $ne: 1 }
            }
        }).then(async result => {
            console.log("BE socket on add new_user")
            let regex = /,/gi;
            let users = ((result.Participants + ':' + data.id).split(':')).sort((a, b) => a - b).toString().replace(regex, ':')
            await Chat.update({
                Participants: users
            }, {
                where: {
                    Id: data.roomId
                }
            })
            socket.broadcast.emit('validation', { message: 'add_new_user', updateIds: users, roomId: data.roomId })
            socket.emit('validation', { message: 'add_new_user', updateIds: users, roomId: data.roomId })
        })
    })

    //Remove user from conversation
    socket.on('remove_user', async (data) => {
        var idCurrentUser = await idFunction.getID(data.token)
        var roomId = data.roomId;
        var idRemovedUser = data.id;
        var token = data.token;
        socket.leave(socket.room);
        Chat.findOne({
            where: {
                Id: roomId,
                Deactivated: { $ne: 1 }
            }
        }).then(async result => {
            if (idCurrentUser != result.Admin) {
                if (idCurrentUser === idRemovedUser) {
                    console.log("BE socket on remove user")
                    var users = result.Participants.split(':')
                    for (var x = 0; x < users.length; x++) {
                        if (users[x].trim() === idRemovedUser.toString()) {
                            users[x] = ',';
                        }
                    }
                    var regex = /,/gi
                    users = users.toString().replace(regex, ':').replace('::', '')
                    await Chat.update({
                        Participants: users
                    }, {
                        where: {
                            Id: roomId
                        }
                    })
                    socket.emit('removeUserGroupMsg', { message: '', removedUserId: idRemovedUser })
                    socket.broadcast.emit('validation', { message: 'remove_user_group', updateIds: users, roomId: roomId })
                    socket.emit('validation', { message: 'add_new_user', updateIds: users, roomId: roomId })
                } else {
                    socket.emit('errRemoveUserGroupMsg', { message: 'this user is not allowed to do that', token: token })
                }
            } else {
                console.log("BE socket on remove admin")
                var users = result.Participants.split(':')
                for (var x = 0; x < users.length; x++) {
                    if (users[x].trim() === idRemovedUser.toString()) {
                        users[x] = ',';
                    }
                }
                var regex = /,/gi
                users = users.toString().replace(regex, ':').replace('::', '')
                await Chat.update({
                    Participants: users
                }, {
                    where: {
                        Id: roomId
                    }
                })
                socket.emit('removeUserGroupMsg', { message: '', removedUserId: idRemovedUser })
                socket.broadcast.emit('validation', { message: 'remove_user_group', updateIds: users, roomId: roomId })
                socket.emit('validation', { message: 'remove_user_group', updateIds: users, roomId: roomId })
            }
        })
    })

    //Rename room
    socket.on('rename_room', async (data) => {
        await Chat.update({
            Room_name: encodeURI(data.roomName)
        }, {
            where: {
                Id: data.roomId
            }
        })
        socket.broadcast.emit('validation', { message: 'rename_room', updateIds: "", roomId: data.roomId })
        socket.emit('validation', { message: 'rename_room', updateIds: "", roomId: data.roomId })
    })

    //Delete room
    socket.on('delete_room', async (data) => {
        const idUser = await idFunction.getID(data.token)
        var roomId = data.roomId
        Chat.findOne({
            attributes: ['Admin'],
            where: {
                Id: roomId
            }
        }).then(async result => {
            if (idUser != result.Admin) {
                socket.emit('errorMsg', { message: 'this user is not allowed to do that', token: data.token }, console.log("send err"))
            } else {
                await Chat.destroy({
                    where: {
                        Id: data.roomId
                    }
                })
                const indexRemove = redis_messages.map(mess => mess.roomId).indexOf(roomId)
                redis_messages.splice(indexRemove, 1)
                await global.redisClient.set('messages', JSON.stringify(redis_messages))
                socket.broadcast.emit('validation', { message: 'delete_room', updateIds: "", roomId: roomId })
                socket.emit('validation', { message: 'delete_room', updateIds: "", roomId: roomId })
                // socket.emit('roomDeleted', { message: 'update' })
            }
        })
    })

    ss(socket).on('upload', (stream, data) => {
        // const filename = socket.ident + '_' + Date.now().toString() + '_' + data.name
        const filePath = path.resolve(uploadPath + "/" + data.name)
        stream.pipe(fs.createWriteStream(filePath))
    })

    socket.on('file_upload_success', async (data) => {
        console.log("file_upload_success", data)
        const filePath = path.resolve(uploadPath + "/" + data.filename)
        await fs.readFile(filePath, async function (err, buf) {
            if (err) {
                console.log(err)
            } else {
                const hashFile = md5(buf)
                const filename = hashFile + '_' + Date.now().toString() + '_' + data.name
                const new_file_path = path.resolve(uploadPath + "/" + filename);
                await fs.rename(filePath, new_file_path, async function (err) {
                    console.log("rename")
                    if (err) {
                        console.log(err)
                    } else {
                        socket.emit('upload_success', { filename: filename, roomId: data.roomId, size: data.size, name: data.name, friendId: data.friendId })
                    }
                });
            }
        })
    })

    //Send file
    socket.on('send_file', async (data) => {
        Chat.findOne({
            where: {
                Id: data.room,
                Deactivated: { $ne: 1 }
            }
        }).then(async result => {
            var users = result.Participants.split(':')
            if (result.Type === 'Group') { // for chat group > 2 user
                const message = "LIEN" + data.name
                const room = redis_messages.find(mess => mess.roomId === data.room)
                room.messages.push({ id: socket.ident, display_name: socket.username, file_name: data.name, message: message, filename: data.filename, time: data.time, isReading: false, size: data.size })
                const lastSeen = room.lastSeen.find(last => last.id === socket.ident)
                if (typeof lastSeen === 'undefined') {
                    room.lastSeen.push({ id: socket.ident, index: room.messages.length })
                } else {
                    lastSeen.index = room.messages.length
                }
                await global.redisClient.set('messages', JSON.stringify(redis_messages))

                await Chat.update({ Notif: '' }, {
                    where: {
                        Id: data.room
                    }
                })

                //broadcast the new message on the room
                console.log("BE notify_msg send_file emit to: room: " + data.room)
                socket.broadcast.emit("notify_msg", { message: message, username: socket.username, verif: 0, room: data.room, file_name: data.name, filename: data.filename, userid: socket.ident, isRoomMultiUsr: true, size: data.size, time: data.time });
            } else { // for chat 1 vs 1
                for (var x = 0; x < users.length; x++) {
                    if (users[x].trim() != socket.ident.toString()) {
                        const message = "LIEN" + data.name
                        const room = redis_messages.find(mess => mess.roomId === data.room)
                        room.messages.push({ id: socket.ident, display_name: socket.username, file_name: data.name, message: message, filename: data.filename, time: data.time, isReading: false, size: data.size })
                        const lastSeen = room.lastSeen.find(last => last.id === socket.ident)
                        if (typeof lastSeen === 'undefined') {
                            room.lastSeen.push({ id: socket.ident, index: room.messages.length })
                        } else {
                            lastSeen.index = room.messages.length
                        }
                        await global.redisClient.set('messages', JSON.stringify(redis_messages))

                        await Chat.update({ Notif: '' }, {
                            where: {
                                Id: data.room
                            }
                        })

                        //broadcast the new message on the room
                        const _user = redis_sockets.find(u => u.id == users[x])
                        if (typeof _user !== 'undefined') {
                            console.log("BE notify_msg send_file emit to: uid: " + users[x] + " socketid: " + _user.socketId)
                            socket.to(_user.socketId).emit("notify_msg", { message: message, username: socket.username, verif: 0, room: data.room, file_name: data.name, filename: data.filename, userid: socket.ident, isRoomMultiUsr: false, size: data.size, time: data.time });
                        }
                    }
                }
            }
        })
    })

    //Download
    socket.on('download', (data) => {
        Chat.findOne({
            where: {
                Id: socket.room,
                Deactivated: { $ne: 1 }
            }
        }).then(result => {
            const participants = result.Participants.toString()
            if (participants.search(`${socket.ident}`) !== -1) {
                socket.emit('download_file', { name: data.name, filename: data.filename, room: socket.room })
            } else {
                res.json({ download: 'You are not allowed to download!' })
            }
        })
    })

    socket.on('verif', (data) => {
        if (data.verif == 1) {
            Chat.findOne({
                attributes: ['Notif'],
                where: {
                    Id: data.roomId
                }
            }).then(async result => {
                await Chat.update({
                    Notif: result.Notif + socket.username + ','
                }, {
                    where: {
                        Id: data.roomId
                    }
                })
            })
        }
    })

    //listen on typing
    socket.on('typing', async (data) => {
        await socket.emit('readed_message', { token: data.token })
        socket.to(socket.room).emit('typing', { room: socket.room, username: socket.username, isfocus: data.isfocus, id: socket.id })
    })

    socket.on('readed_message', (data) => {
        return new Promise(async (resolve, reject) => {
            socket.emit('readed_message')
            const id = await idFunction.getID(data.token)
            const room = redis_messages.find(mess => mess.roomId === socket.room)
            if (typeof room !== 'undefined') {
                if (room.messages.length > 0) {
                    const lastSeen = room.lastSeen.find(last => last.id === id)
                    if (typeof lastSeen !== 'undefined') {
                        if (lastSeen.index < room.messages.length) {
                            lastSeen.index = room.messages.length
                        }
                    }
                }
            }
            await global.redisClient.set('messages', JSON.stringify(redis_messages))
            resolve()
        })
    })

    //listen on leave room (leave room)
    socket.on('leaveRoom', (data) => {
        if (data.roomId !== undefined) {
            console.log("leaveRoom: " + data.roomId)
            socket.room = data.roomId;
            socket.leave(socket.room);
        }
    })

    socket.on('show_chat_history', data => {
        const room = redis_messages.find(mess => mess.roomId == data.room_id)
        // console.log(room)
        if (!!room) {
            let messages = room.messages
            if (messages.length > 0) {
                if (messages.length > 50) {
                    var message = messages.slice(messages.length - 50, messages.length)
                    socket.emit('history', { message: message });
                } else {
                    socket.emit('history', { message: messages });
                }
            } else {
                socket.emit('history', { message: '' });
            }
        }
    })

    socket.on('delete_message', async data => {
        Chat.findOne({
            where: {
                Id: socket.room,
                Deactivated: { $ne: 1 }
            }
        }).then(async result => {
            if (socket.ident === data.id) {
                if (data.isFile) {
                    const filePath = path.resolve(uploadPath + "/" + data.filename)
                    fs.unlink(filePath, err => {
                        if (err)
                            console.log(err)
                    })
                }

                const users = result.Participants.split(':')
                const friends = users.filter(u => u != socket.ident)

                const room = redis_messages.find(mess => mess.roomId == socket.room)
                const indexRemove = room.messages.findIndex(mess => {
                    return mess.time == data.time && mess.id == data.id
                })
                room.messages.splice(indexRemove, 1)
                await global.redisClient.set('messages', JSON.stringify(redis_messages))

                let isNoti = true
                socket.emit('delete_message', { indexRemove, roomId: socket.room, time: data.time, isNoti })

                let isRoomMultiUsr = true
                if (result.Type === '1-1') {
                    isRoomMultiUsr = false
                }

                for (var x = 0; x < friends.length; x++) {
                    const _user = redis_sockets.find(u => u.id == friends[x])
                    if (_user) {
                        const lastSeen = room.lastSeen.find(last => last.id === _user.id)
                        if (typeof lastSeen !== 'undefined') {
                            if ((indexRemove + 1) > lastSeen.index) {
                                if (lastSeen.index == room.messages.length) {
                                    isNoti = false
                                }
                            } else {
                                --lastSeen.index
                            }
                        }
                        await global.redisClient.set('messages', JSON.stringify(redis_messages))
                        io.to(_user.socketId).emit('delete_message', { indexRemove, roomId: socket.room, time: data.time, isNoti, isRoomMultiUsr, idUser: socket.ident })
                    }
                }
            }
        })
    })

    /*===================[VIDEO CHAT]==================*/
    //1//'refuseCall' is when a user decide to refuse a P2P call
    socket.on('refuseCall', async (data) => {
        // console.log(data)
        const idUser = await idFunction.getID(data.token)
        User.findOne({
            attributes: ['display_name'],
            where: {
                id: idUser
            }
        }).then(result => {
            const _user = redis_sockets.find(u => u.id == data.idTo)
            if (typeof _user !== 'undefined') {
                console.log("BE emit refuseCall to: " + data.idTo)
                socket.to(_user.socketId).emit('refuseCall', { idFrom: idUser, message: data.message, displayName: result.display_name })
            }
        })
    })

    socket.on('refuseGroupDialing', async (data) => {
        const idUser = await idFunction.getID(data.token)
        User.findOne({
            attributes: ['display_name'],
            where: {
                id: idUser
            }
        }).then(result => {
            const _user = redis_sockets.find(u => u.id == data.idTo)
            if (typeof _user !== 'undefined') {
                console.log("BE emit refuseCall to: " + data.idTo)
                socket.to(_user.socketId).emit('refuseGroupDialing', { idFrom: idUser, message: data.message, displayName: result.display_name })
            }
        })
    })

    //2//'refuseGroupCall' when a user added in the conversation refuse to come in
    socket.on('refuseGroupCall', async (data) => {
        const idUser = await idFunction.getID(data.token)
        User.findOne({
            attributes: ['display_name'],
            where: {
                id: idUser
            }
        }).then(result => {
            for (var x = 0; x < data.idFriendsTo.length; x++) {
                const _user = redis_sockets.find(u => u.id == data.idFriendsTo[x])
                if (typeof _user !== 'undefined') {
                    console.log("BE emit refuseGroupCall to: " + data.idFriendsTo[x])
                    socket.to(_user.socketId).emit('refuseGroupCall', result.display_name)
                }
            }
        })
    })

    //3//'user' is to put all new user come on 'VIDEO CALL' page in a room with the name 'V+id of the user
    // socket.on('user', (data) => {
    //     console.log("BE userVideo join: " + idFunction.getID(data.token))
    //     socket.leaveAll()
    //     socket.join('V' + idFunction.getID(data.token))
    // })

    //4//'sharing' is to block screen sharing from other participants when one is already in screen share
    socket.on('sharing', (data) => {
        const _user = redis_sockets.find(u => u.id == data.idTo)
        if (typeof _user !== 'undefined') {
            console.log("BE emit sharing: " + data.idTo)
            socket.to(_user.socketId).emit('sharing', data.sharing)
        }
    })

    //5//'endCall' is for broadcast to every client of the room that the call is over
    socket.on('endCall', async (data) => {
        const currentUserId = await idFunction.getID(data.token);
        const now = Date.now()
        if (data.call_group_id) {
            call_room.find(async (val, idx) => {
                if (val.call_group_id === data.call_group_id) {
                    call_room[idx].participants = call_room[idx].participants.filter(val => val !== currentUserId)
                    call_room[idx].participants.map(val => {
                        const _user = redis_sockets.find(u => u.id == val)
                        if (typeof _user !== 'undefined') {
                            console.log("BE emit endCall to: " + val)
                            socket.to(_user.socketId).emit('endCall', currentUserId)
                        }
                    })

                    if (call_room[idx].participants.length < 2) {
                        await Chat.update({
                            CallStatus: 'NoCall',
                            CallId: ''
                        }, {
                            where: {
                                Id: call_room[idx].call_group_chat_room_id
                            }
                        })

                        CallLog.findOne({
                            where: {
                                groupName: call_room[idx].call_group_chat_room_id.toString(),
                                status: 'OnGoing'
                            }
                        }).then(async result => {
                            if (result) {
                                await CallLog.update({
                                    endDate: Date.now(),
                                    status: 'Ended'
                                }, {
                                    where: {
                                        groupName: socket.callRoom.toString(),
                                        status: 'OnGoing'
                                    }
                                }).then().catch(err => console.log(err))

                                const room = redis_messages.find(mess => mess.roomId === socket.callRoom)
                                if (room) {
                                    room.messages.push({ id: 0, display_name: 'VIDEO_CHAT_ENDED', message: result.participants, time: now, isReading: false })
                                    await global.redisClient.set('messages', JSON.stringify(redis_messages))
                                }
                                await global.redisClient.set('messages', JSON.stringify(redis_messages))

                                Chat.findOne({
                                    where: {
                                        Id: socket.callRoom.toString()
                                    }
                                }).then(async r => {
                                    const participants = r.Participants.split(':').filter(e => !!e && e != socket.ident)

                                    await Chat.update({
                                        CallStatus: 'NoCall',
                                        CallId: ''
                                    }, {
                                        where: {
                                            Id: socket.callRoom.toString()
                                        }
                                    })

                                    const socket_users = redis_sockets.filter(u => participants.indexOf(u.id.toString()) !== -1)
                                    socket.emit("notify_msg", { username: 'VIDEO_CHAT_ENDED', message: result.participants, time: now, isReading: false, room: socket.callRoom, isRoomMultiUsr: true })
                                    for (let i = 0; i < socket_users.length; i++) {
                                        socket.to(socket_users[i].socketId).emit("notify_msg", { username: 'VIDEO_CHAT_ENDED', message: result.participants, time: now, isReading: false, room: socket.callRoom, isRoomMultiUsr: true })
                                    }
                                })
                            }
                        }).catch(err => console.log(err))

                        call_room = call_room.filter(val => val.call_group_id !== call_room[idx].call_group_id)
                        console.log("afterfilter end call", call_room)
                    }
                }
            })
        } else {
            const _user = redis_sockets.find(u => u.id == data.idTo)
            let participants = []
            participants.push(socket.ident)
            participants.push(_user.id)
            participants.sort()

            const room = redis_messages.find(mess => mess.roomId === socket.callRoom)
            if (room) {
                room.messages.push({ id: 0, display_name: 'VIDEO_CHAT_ENDED', message: participants.join(':'), time: now, isReading: false })
                await global.redisClient.set('messages', JSON.stringify(redis_messages))
            }

            let parts = participants.join(":")
            if (parts) {
                await CallLog.update({
                    endDate: now,
                    status: 'Ended'
                }, {
                    where: {
                        groupName: socket.callRoom.toString(),
                        status: 'OnGoing'
                    }
                }).then().catch(err => console.log(err))
            }

            if (typeof _user !== 'undefined') {
                console.log("BE emit endCall to: " + data.idTo)
                await socket.to(_user.socketId).emit('endCall', currentUserId)

                await socket.emit("notify_msg", { username: 'VIDEO_CHAT_ENDED', message: participants.join(':'), time: now, isReading: false, room: socket.callRoom, userid: _user.id, isRoomMultiUsr: false });
                await socket.to(_user.socketId).emit("notify_msg", { username: 'VIDEO_CHAT_ENDED', message: participants.join(':'), time: now, isReading: false, room: socket.callRoom, userid: socket.ident, isRoomMultiUsr: false });
            }
        }
    })

    //6//'add' is to broadcast the invitation call to the user who is called
    socket.on('add', async (data) => {
        const idUser = await idFunction.getID(data.token)
        if (data.idFriends) {
            var tabFriends = data.idFriends
            console.log(tabFriends)
            var displayNameCaller
            User.findOne({
                attributes: ['display_name'],
                where: {
                    id: idUser
                }
            }).then(result => {
                displayNameCaller = result.display_name
                User.findAll({
                    attributes: ['display_name'],
                    where: {
                        id: { $in: tabFriends }
                    }
                }).then(result => {
                    tabFriends.push(idUser)
                    var tabDisplayName = []
                    for (var i = 0; i < result.length; i++) {
                        tabDisplayName.push(result[i].display_name)
                    }

                    const _user = redis_sockets.find(u => u.id == data.idTo)
                    if (typeof _user !== 'undefined') {
                        console.log("BE emit join to: " + data.idTo)
                        socket.to(_user.socketId).emit('join', { idFriends: tabFriends, displayNameCaller: displayNameCaller, displayNameOthers: tabDisplayName, call_group_id: data.call_group_id, call_group_chat_room_id: data.call_group_chat_room_id })
                    }
                })
            })
        }
    })

    //7//'invitCall' is to send an invitation call to one user
    socket.on('invitCall', async (data) => {
        const idUser = await idFunction.getID(data.token)
        User.findOne({
            attributes: ['display_name'],
            where: {
                id: idUser
            }
        }).then(result => {
            const _user = redis_sockets.find(u => u.id == data.idFriend)
            if (typeof _user !== 'undefined') {
                // console.log("BE emit invitCall to: " + data.idFriend)
                socket.to(_user.socketId).emit('invitCall', { idFrom: idUser, displayName: result.display_name })
            }
        })
    })
    socket.on('invitGroupDialing', async (data) => {
        console.log("group call: ", data.idFriend)
        const currentUserId = await idFunction.getID(data.token);
        call_room.push({ call_group_id: data.call_group_id, call_group_chat_room_id: data.call_group_chat_room_id, participants: [currentUserId] })
        await Chat.update({
            CallStatus: 'OnCall',
            CallId: data.call_group_id
        }, {
            where: {
                Id: data.call_group_chat_room_id
            }
        })
        for (let i = 0; i < data.idFriend.length; i++) {
            const _user = redis_sockets.find(u => u.id == data.idFriend[i])
            if (_user) {
                socket.to(_user.socketId).emit('invitGroupDialing', { idFrom: currentUserId, groupName: data.groupName, groupMembers: data.groupMembers, call_group_id: data.call_group_id, call_group_chat_room_id: data.call_group_chat_room_id })
            }
        }
    })

    //8//---Functions that just broadcast to other users to initialize peerConnection---
    socket.on('ready', async (data) => {
        const idUser = await idFunction.getID(data.token)
        const _user = redis_sockets.find(u => u.id == data.idTo)
        let participants = []
        participants.push(data.idTo)
        participants.push(idUser)
        participants.sort()
        const parts = participants.join(':')

        Chat.findAll({
            where: {
                Participants: parts,
                Room_name: parts,
                Deactivated: 0
            }
        }).then(async result => {
            if (result.length <= 0) {
                const chatInsert = {
                    Participants: parts,
                    Room_name: parts,
                    Notif: '',
                    Admin: idUser,
                    Type: '1-1',
                    Deactivated: 0
                }
                await Chat.create(chatInsert).then(async r => {
                    socket.callRoom = r.Id
                    redis_messages.push({ roomId: r.Id, messages: [], lastSeen: [] })
                    await global.redisClient.set('messages', JSON.stringify(redis_messages))
                    await CallLog.create({
                        participants: parts,
                        startDate: Date.now(),
                        groupName: r.Id,
                    }).then().catch(err => console.log(err))
                }
                ).catch(e => console.log(e))
            } else {
                console.log(result[0].Id)
                socket.callRoom = result[0].Id
                await CallLog.create({
                    participants: parts,
                    startDate: Date.now(),
                    groupName: result[0].Id,
                }).then().catch(err => console.log(err))
            }
        })


        if (typeof _user !== 'undefined') {
            console.log("BE emit ready to: " + data.idTo)
            socket.to(_user.socketId).emit('ready', { idFrom: idUser, display_name: data.display_name })
        }
    })

    socket.on('readyGroupDialing', async (data) => {
        const currentUserId = await idFunction.getID(data.token);
        call_room.find(async (val, idx) => {
            if (val.call_group_id === data.call_group_id) {
                call_room[idx].participants.push(currentUserId)
                let membersInRoom = call_room[idx].participants.filter(val => val !== currentUserId)

                socket.callRoom = call_room[idx].call_group_chat_room_id
                let participants = []
                participants.push(currentUserId)
                participants.push(membersInRoom)
                participants.sort()
                // console.log(participants)
                await CallLog.findOne({
                    where: {
                        groupName: call_room[idx].call_group_chat_room_id.toString(),
                        status: 'OnGoing'
                    }
                }).then(async result => {
                    if (!result) {
                        await CallLog.create({
                            participants: participants.join(':'),
                            startDate: Date.now(),
                            groupName: call_room[idx].call_group_chat_room_id.toString()
                        }).then().catch(err => console.log(err))
                    }
                }).catch(err => console.log9err)

                for (var i = 0; i < membersInRoom.length; i++) {
                    const _user = redis_sockets.find(u => u.id == membersInRoom[i])
                    if (typeof _user !== 'undefined') {
                        console.log("BE emit ready to: " + membersInRoom[i])
                        socket.to(_user.socketId).emit('ready', { idFrom: currentUserId, display_name: data.display_name })
                    }
                }
            }
        })
    })
    //9
    socket.on('candidate', async (data) => {
        const idUser = await idFunction.getID(data.token)
        const _user = redis_sockets.find(u => u.id == data.idTo)
        if (typeof _user !== 'undefined') {
            // console.log("BE emit candidate to: " + data.idTo)
            socket.to(_user.socketId).emit('candidate', { label: data.label, candidate: data.candidate, idFrom: idUser })
        }
    })

    socket.on('join_call_room', data => {
        socket.callRoom = data.callRoom
    })

    //10
    socket.on('offer', async (data) => {
        const idUser = await idFunction.getID(data.token)
        const _user = redis_sockets.find(u => u.id == data.idTo)
        if (typeof _user !== 'undefined') {
            console.log("BE emit offer to: " + data.idTo)
            socket.to(_user.socketId).emit('offer', { idFrom: idUser, sdp: data.sdp, display_name: data.display_name })
        }
    })

    //11
    socket.on('offerRenegotiate', async (data) => {
        const idUser = await idFunction.getID(data.token)
        const _user = redis_sockets.find(u => u.id == data.idTo)
        if (typeof _user !== 'undefined') {
            console.log("BE emit offerRenegotiate to: " + data.idTo)
            socket.to(_user.socketId).emit('offerRenegotiate', { idFrom: idUser, sdp: data.sdp, display_name: data.display_name })
        }
    })

    //12
    socket.on('answer', async (data) => {
        const idUser = await idFunction.getID(data.token)
        const _user = redis_sockets.find(u => u.id == data.idTo)

        if (socket.callRoom) {
            await CallLog.findOne({
                where: {
                    groupName: socket.callRoom.toString(),
                    status: 'OnGoing'
                }
            }).then(async result => {
                if (result) {
                    const parts = result.participants.split(':')
                    if (parts.indexOf(idUser.toString()) === -1) {
                        parts.push(idUser)
                        parts.sort()
                        console.log(parts.join(':').toString())
                        await CallLog.update({
                            participants: parts.join(':')
                        }, {
                            where: {
                                groupName: socket.callRoom.toString(),
                                status: 'OnGoing'
                            }
                        })
                    }
                }
            }).catch(err => console.log(err))
        }

        if (typeof _user !== 'undefined') {
            console.log("BE emit answer to: " + data.idTo)
            socket.to(_user.socketId).emit('answer', { sdp: data.sdp, idFrom: idUser, callRoom: socket.callRoom })
        }
    })
    // --------------BOOKING CALL---------------
    socket.on('checkNewRequest', () => {
        socket.broadcast.emit('checkNewRequest', { message: 'checkNew' })
        // socket.emit('checkAllRequest', { message: 'checkNew' })
    })

    socket.on('clear_chat_history', async data => {
        try {
            let users_in_room = [data.idFrom, data.idTo]
            let regex = /,/gi;
            let room = users_in_room.sort((a, b) => a - b).toString().replace(regex, ':');
            let room_name = room;
            await Chat.update({
                Deactivated: 1
            }, {
                where: {
                    Participants: room,
                    Room_name: room_name,
                    Deactivated: 0
                }
            })
        } catch (error) {
            console.log(error)
        }
    })

    socket.on('fetch-total-statistics', data => {
        if (data.success) {
            socket.emit('fetch-total-statistics', { success: true })
        }
    })
})
