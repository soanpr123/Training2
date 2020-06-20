const express = require('@feathersjs/express');
const router = express.Router();

const chat = require('../controllers/chat')

module.exports = app => {
    app.use('/chat', router)

    /**
     * @route POST /chat/chat
     * @group Chat - Chat operation
     * @param {string} token.body.required 
     * @returns {object} 200 
     * @returns {Error}  default - Unexpected error
     */
    router.post('/chat', chat.userChat)

    /**
     * @route POST /chat/chat
     * @group Chat 
     * @param {string} token.body.required 
     * @returns {object} 200 
     * @returns {Error}  default - Unexpected error
     */
    router.post('/groupChat', chat.groupChat)

    /**
     * @route POST /chat/chat
     * @group Chat 
     * @param {string} token.body.required 
     * @returns {object} 200 
     * @returns {Error}  default - Unexpected error
     */
    router.post('/downloadFile', chat.downloadFile)
}