const express = require('express');
const router = express.Router();

const connection = require('../controllers/connection')

module.exports = app => {
     /**
      * Signing up new account
      * @route POST /signup
      * @group Connection - Connecting to the system
      * @param {string} firstName.body.required
      * @param {string} lastName.body.required
      * @param {string} displayName.body.required
      * @param {string} email.body.required
      * @param {object} hashed.body.required - Including hash.salt and hash.passwordHash
      * @param {string} phoneNumber.body.required
      * @returns {object} 200 - success
      * @returns {Error}  default - Unexpected error
      */
     app.post('/signup', connection.signUp)

	/**
     * Signing up new account
     * @route POST /verifiedEmail
     * @group Connection - Connecting to the system
     * @param {string} token.body.required
     * @returns {object} 200 - verified
     * @returns {Error}  default - Unexpected error
     */
     app.post('/verifiedEmail', connection.verifiedEmail)

     /**
     * Signing up new account
     * @route POST /activiteEmail
     * @group Connection - Connecting to the system
     * @param {string} token.body.required
     * @returns {object} 200 - verified
     * @returns {Error}  default - Unexpected error
     */
     app.post('/activateAccount', connection.activiteAccount)

     /**
     * Signing up new account
     * @route POST /deleteEmail
     * @group Connection - Connecting to the system
     * @param {string} token.body.required
     * @returns {object} 200 - verified
     * @returns {Error}  default - Unexpected error
     */
     app.post('/deleteAccount', connection.deleteAccount)

     app.use('/login', router)

	/**
     * Signing up new account
     * @route POST /login
     * @group Connection - Connecting to the system
     * @param {string} email.body.required
     * @returns {object} 200 -  Message, Password and SaltKey
     * @returns {Error}  default - Unexpected error
     */
     router.post('/', connection.login)

	/**
     * Signing up new account
     * @route POST /login/ldap
     * @group Connection - Connecting to the system
     * @param {string} encryptedUser.body.required
     * @returns {object} 200 -  Message, Password, SaltKey, ID, nbConnect and webToken
     * @returns {Error}  default - Unexpected error
     */
     router.post('/ldap', connection.ldap)
}
