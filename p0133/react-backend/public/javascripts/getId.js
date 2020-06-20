const jwt = require('jsonwebtoken');
const settings = require('../config')

async function getID(token){
    this.id = 0
    if (token !== "undefined"){
        var privateKey = settings.defaultSettings.PRIVATE_KEY;
        await jwt.verify(token, privateKey, {algorithm: "HS256"},(err,user)=>{
            if(err){
                console.log(err)
            }else{
                this.id = user.id
            }
        });
    }
    return this.id

}

module.exports = {getID : getID};
