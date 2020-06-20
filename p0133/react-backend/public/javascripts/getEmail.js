const jwt = require('jsonwebtoken');
const settings = require('../config')

function getEmail(token){
    this.email = 0
    if (token !== "undefined"){
        var privateKey = settings.defaultSettings.PRIVATE_KEY;
        jwt.verify(token, privateKey, {algorithm: "HS256"},(err,user)=>{
            if(err){
                throw err;
            }else{
                this.email = user.email
            }
        });
    }
    return this.email

}

module.exports = {getEmail : getEmail};
