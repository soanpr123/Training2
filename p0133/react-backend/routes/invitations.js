const express = require('@feathersjs/express');
const router = express.Router();

const invitation = require('../controllers/invitation')

module.exports = app => {
    app.use('/invitations', router)

    /**
     * Return list of user except the logged one
     * @route POST /invitations/sendInvitations
     * @group Invitation
     * @param {string} token.body.required
     * @param {string} email.body.required
     * @returns {object} 200 - Message: 'invitation send' with id User
     * @returns {Error}  default - Unexpected error
     */
    router.post('/sendInvitations', invitation.sendInvitation)

    /**
     * Return list of user except the logged one
     * @route POST /invitations/refuseInvitation
     * @group Invitation
     * @param {string} token.body.required
     * @param {integer} idFriend.body.required
     * @returns {object} 200 - Message: 'invitation refused ok & I' with new Invitation Info
     * @returns {Error}  default - Unexpected error
     */
    router.post('/refuseInvitation', invitation.refuseInvitation)

    /**
     * Return list of user except the logged one
     * @route POST /invitations/acceptInvitation
     * @group Invitation
     * @param {string} token.body.required
     * @param {string} emailFriend.body.required
     * @param {integer} idFriend.body.required
     * @returns {object} 200 - Message: 'New Invitations', newFriendsInfo and new Invitations Info
     * @returns {Error}  default - Unexpected error
     */
    router.post('/acceptInvitation', invitation.acceptInvitation)
}
