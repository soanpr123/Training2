const express = require('@feathersjs/express');
const router = express.Router();

const password = require('../controllers/password')

module.exports = app => {
    app.use('/password', router)

    /**
     * Changing current password
     * @route POST /password/changePasswrd
     * @group Password - Password operator
     * @param {string} token.body.required
     * @param {string} email.body.required
     * @param {object} hashed.body.required - Including hash.salt and hash.passwordHash
     * @returns {object} 200 - Ok and nbConnect
     * @returns {Error}  default - Unexpected error
     */
    router.post('/changePasswrd', password.changePassword)

    /**
     * Get verified email to change password
     * @route POST /password/frgtPasswrd
     * @group Password 
     * @param {string} email.body.required 
     * @returns {object} 200 - True
     * @returns {Error}  default - Unexpected error
     */
    router.post('/frgtPasswrd', password.forgotPassword)
}
