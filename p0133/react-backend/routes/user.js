const express = require('@feathersjs/express')
const router = express.Router()

const user = require('../controllers/user')

module.exports = app => {
    app.use('/user', router)
    // app.use('/profile', router)

    /**
     * Profile
     */

    /**
     * Editing profile
     * @route POST /user/editProfile
     * @group User - User operation
     * @param {string} token.body.required 
     * @param {string} first_name.body.required 
     * @param {string} last_name.body.required 
     * @param {string} phone.body.required 
     * @param {string} company.body.required 
     * @param {string} bio.body.required 
     * @returns {object} 200 - Successful editing
     * @returns {Error}  default - Unexpected error
     */
    router.post('/editProfile', user.editProfile)

    /**
     * Changing avatar
     * @route POST /user/changeAvatar
     * @group User
     * @param {string} token.body.required 
     * @param {file} file.body.required 
     * @returns {object} 200 - req.file.filename
     * @returns {Error}  default - Unexpected error
     */
    router.post('/changeAvatar', user.changeAvatar)

    /**
     * Deleting avatar
     * @route POST /user/deleteAvatar
     * @group User
     * @param {string} token.body.required 
     * @returns {object} 200 - req.file.filename
     * @returns {Error}  default - Unexpected error
     */
    router.post('/deleteAvatar', user.deleteAvatar)

    /**
     * Changing the email
     * @route POST /user/changeEmail
     * @group User
     * @param {string} token.body.required 
     * @param {string} email.body.required
     * @param {string} newEmail.body.required
     * @returns {object} 200 - Mail send
     * @returns {Error}  default - Unexpected error
     */
    router.post('/changeEmail', user.changeEmail)

    /**
     * Get user profiles including friend and invitations
     * @route POST /user/profile
     * @group User
     * @param {string} token.body.required 
     * @returns {object} 200 - User's information
     * @returns {Error}  default - Unexpected error
     */
    router.post('/profile', user.userProfile)

    /**
    * Get user single profile
    * @route POST /user/single-user
    * @group User
    * @param {string} token.body.required 
    * @returns {object} 200 - User's information
    * @returns {Error}  default - Unexpected error
    */
    router.post('/single-user', user.singleUserProfile)

    /**
     * Status
     */

    /**
    * Changing user's status
    * @route POST /user/status
    * @group User
    * @param {string} token.body.required 
    * @param {string} status.body.required 
    * @returns {object} 200 - update status
    * @returns {Error}  default - Unexpected error
    */
    router.post('/status', user.userStatus)

    /**
    * Updating user's status frequently
    * @route POST /user/updateStatus
    * @group User
    * @param {string} token.body.required 
    * @returns {object} 200 - update status
    * @returns {Error}  default - Unexpected error
    */
    router.post('/updateStatus', user.updateStatus)
}
