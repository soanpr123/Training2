const jwt = require('jsonwebtoken')
const User = require('../models/User')
const Setting = require('../public/config')
const Constant = require('../constant')

exports.authorizedUser = async (req, res) => {
    req.checkBody('token', 'Token is required').notEmpty()
    const errors = req.validationErrors()
    if (errors) {
        return res.status(200).send(JSON.stringify({ state: false, msg: errors[0].msg }))
    } else {
        const token = await jwt.verify(req.body.token, Setting.defaultSettings.PRIVATE_KEY, Constant.JWT_OPTION)
        User.findOne({
            where: {
                id: token.id
            }
        }).then(result => {
          if (result.activated === 0) {
              res.json({ message: 'false' });
          } else {
              res.json({ message: 'true', role: result.role });
          }
        }).catch(err => {
          console.log(err);
          res.json({ message: 'false' });
        })
    }
}

exports.authorizedAdmin = async (req, res) => {
    req.checkBody('token', 'Token is required').notEmpty()
    const errors = req.validationErrors()
    if (errors) {
        return res.status(200).send(JSON.stringify({ state: false, msg: errors[0].msg }))
    } else {
        const token = jwt.verify(req.body.token, Setting.defaultSettings.PRIVATE_KEY, Constant.JWT_OPTION)
        User.findOne({
            where: {
                id: token.id
            }
        }).then(result => {
          if (result.role === 'admin') {
              res.json({ message: 'true' });
          } else {
              res.json({ message: 'false' });
          }
        }).catch(err =>{
          console.log(err);
          res.json({ message: 'false' });
        })
    }
}
