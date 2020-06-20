const express = require('@feathersjs/express')
const router = express.Router()
const authorization = require('../controllers/authorization')

module.exports = app => {
    app.use('/authorization', router)

    /**
     * Get user role
     * @route POST /authorization
     * @group Authorization - Authorization process
     * @param {string} token.body.required - Access token
     * @returns {object} 200 - User's role
     * @returns {Error}  default - Unexpected error
     */
    router.post('/', authorization.authorizedUser)

    /**
     * Check whether role is admin
     * @route POST /authorization/admin
     * @group Authorization
     * @param {string} token.body.required - Access token
     * @returns {object} 200 - True/False
     * @returns {Error}  default - Unexpected error
     */
    router.post('/admin', authorization.authorizedAdmin)
}