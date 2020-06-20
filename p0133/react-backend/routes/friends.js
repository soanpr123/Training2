const express = require('@feathersjs/express');
const router = express.Router();

const friend = require('../controllers/friend')

module.exports = app => {
    app.use('/friends', router)

    /**
     * @route POST /friends/friends
     * @group Friend - Friend operation
     * @param {string} token.body.required 
     * @returns {object} 200 - Friends information
     * @returns {Error}  default - Unexpected error
     */
    router.post('/friends', friend.userFriends)

    /**
     * @route POST /friends/searchFriend
     * @group Friends
     * @param {integer} idFriend.body.required 
     * @returns {object} 200 - Friends information
     * @returns {Error}  default - Unexpected error
     */
    router.post('/searchFriend', friend.searchFriend)

    /**
     * @route POST /friends/searchFriend
     * @group Friends
     * @param {string} token.body.required 
     * @returns {object} 200 - Friends information
     * @returns {Error}  default - Unexpected error
     */
    router.post('/friendInfo', friend.friendInfo)

    /**
     * @route POST /friends/searchFriend
     * @group Friends
     * @param {string} token.body.required 
     * @param {string} idFriend.body.required 
     * @returns {object} 200 - Friends information
     * @returns {Error}  default - Unexpected error
     */
    router.post('/deleteFriend', friend.deleteFriend)
}