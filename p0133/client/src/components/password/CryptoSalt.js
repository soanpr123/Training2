var crypto = require('crypto')

var sha512 = function(password, salt){
    var hash = crypto.createHmac('sha512', salt); /** Hashing algorithm sha512 */
    hash.update(password);
    var value = hash.digest('hex')
    return value
}

function saltHashPasswordSalt(userpassword, salt) {
    var passwordData = sha512(userpassword, salt)
    return passwordData
}

export default saltHashPasswordSalt