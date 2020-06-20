/*-------------------------------------------------MODULES-------------------------------------------------*/
const express = require('@feathersjs/express');
const router = express.Router();

const admin = require('../controllers/admin')

module.exports = app => {
    app.use('/admin', router)

    /**
     * Return list of user except the logged one
     * @route POST /admin/afficheUsers
     * @group Admin - Admin operation
     * @param {string} token.body.required 
     * @returns {object} 200 - Users information
     * @returns {Error}  default - Unexpected error
     */
    router.post('/afficheUsers', admin.afficheUsers)

    /**
     * Return list of user except the logged one
     * @route POST /admin/statistics
     * @group Admin - Admin operation
     * @param {string} token.body.required 
     * @returns {object} 200 - Users information
     * @returns {Error}  default - Unexpected error
     */
    router.post('/statistics', admin.statistics)

    /**
     * Deleting user then return list of user except the logged one
     * @route DELETE /admin/deleteUsers
     * @group Admin
     * @param {string} token.body.required 
     * @param {integer} id.body.required 
     * @returns {object} 200 - Users information
     * @returns {Error}  default - Unexpected error
     */
    router.delete('/deleteUsers', admin.deleteUsers)

    /**
     * Searching for user in database with params in First name - Last name or Email
     * @route POST /admin/searchUsers
     * @group Admin
     * @param {string} token.body.required 
     * @param {string} value.body.required 
     * @returns {object} 200 - Users information
     * @returns {Error}  default - Unexpected error
     */
    router.post('/searchUsers', admin.searchUser)

    /**
     * Editing user information
     * @route PUT /admin/editUsers
     * @group Admin
     * @param {string} token.body.required 
     * @param {string} first_name.body.required 
     * @param {string} last_name.body.required 
     * @param {string} display_name.body.required 
     * @param {string} email.body.required 
     * @param {string} role.body.required
     * @param {integer} activated.body.required 
     * @param {integer} verified.body.required 
     * @returns {object} 200 - Users information
     * @returns {Error}  default - Unexpected error
     */
    router.put('/editUsers', admin.editUsers)

    /**
     * Adding new user to database then return list of user except the logged one
     * @route POST /admin/addUser
     * @group Admin
     * @param {string} token.body.required 
     * @param {string} first_name.body.required 
     * @param {string} last_name.body.required 
     * @param {string} display_name.body.required 
     * @param {string} email.body.required 
     * @param {string} password.body.required 
     * @param {string} phone.body.required 
     * @param {string} role.body.required 
     * @param {integer} personalId.body.required 
     * @returns {object} 200 - Users information
     * @returns {Error}  default - Unexpected error
     */
    router.post('/addUser', admin.addUser)
}
