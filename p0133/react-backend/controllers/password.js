const idFunction = require('../public/javascripts/getId')
const Setting = require('../public/config')
const Constant = require('../constant')
const User = require('../models/User')
const jwt = require('jsonwebtoken')
const mailer = require('../public/javascripts/mailer')

exports.changePassword = async (req, res) => {
    const idUser = await idFunction.getID(req.body.token)
    const user = await User.findOne({
        where: {
            email: req.body.email,
            id: idUser
        }
    })
    if (user) {
        const updateData = {
            passwrd: req.body.hashed.passwordHash,
            saltKey: req.body.hashed.salt,
            nbConnect: user.nbConnect + 1
        }
        User.update(updateData, {
            where: {
                email: req.body.email
            }
        }).then(result => {
            res.json({ message: 'ok', nbConnect: updateData.nbConnect })
        }).catch(err => {
            res.json({ message: 'error' })
        })
    } else {
        res.json({ message: 'user not exist' })
    }
}

exports.forgotPassword = async (req, res) => {
    const user = await User.findOne({
        where: {
            email: req.body.email
        }
    })
    if (user) {
        console.log(Constant.JWT_OPTION)
        let token = jwt.sign({ 'id': user.id }, Setting.defaultSettings.PRIVATE_KEY, Constant.JWT_OPTION)
        let content = `
            <div style="padding: 20px; border-spacing: 0;vertical-align: top;text-align: left;background: black">
                <div style="font-size: 14px;font-weight: normal;color: white;font-family: 'Open Sans', Helvetica, sans-serif;padding: 0;text-align: left;line-height: 1.3;">
                    <strong>Account Name</strong>: ${decodeURI(user.display_name)}
                </div>

                <div style="font-size: 14px;font-weight: normal;color: white;font-family: 'Open Sans', Helvetica, sans-serif;padding: 0;text-align: left;line-height: 1.3;">
                    <strong>Email Address:</strong> <a style="color: #2D7ABF;text-decoration: underline;">${user.email}</a>
                </div>
            </div>

            <div style="padding: 20px;">
                <p style=${Constant.MAIL_STYLE.body}>
                    We have received your reset password request. Please click the button below to continue.
                </p>

                <p style=${Constant.MAIL_STYLE.body}>
                    If you did not initiate a request to reset the password, please ignore this email. No changes will be made.
                </p>

                <p style=${Constant.MAIL_STYLE.body}>
                    If you have any questions, please do not hesitate to email us at
                        <a href="mailto:webrtc.bhsoft@gmail.com" style="color: #2D7ABF;text-decoration: underline;">
                            webrtc.bhsoft@gmail.com
                        </a>
                </p>

                <a href="${Setting.defaultSettings.FE_URL + '/changePasswrd/' + token}" style="color: #ffffff;text-decoration: none;background-color: #2D7ABF;border-bottom: 2px solid #052D51;border-radius: 3px;display: block;font-size: 13px;font-weight: bold;line-height: 50px;text-align: center;min-width: 200px;width: auto;-webkit-text-size-adjust: none;max-width:50px;font-family: 'Helvetica', 'Arial', sans-serif;margin: 5px 0;">
                    Reset password
                </a>
            </div>
        `
        mailer.sendMail(req.body.email, 'UET Communication - Reset your password', content).then(r => {
            res.send({ message: 'true' })
        }).catch(err => {
            console.log(err);
            res.json({ message: 'err' })
        })
    } else {
        res.json({ message: 'user not exist' })
    }
}
