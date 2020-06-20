const nodemailer = require('nodemailer')
const Setting = require('../config')
const Constant = require('../../constant')

exports.sendMail = async (to = [], subject = '', content = '') => {
    let transporter = await nodemailer.createTransport({
        service: 'gmail',
        auth: {
            user: Setting.defaultSettings.EMAIL_ADDRESS,
            pass: Setting.defaultSettings.MDP_EMAIL
        }
    })

    let mailOptions = {
        from: Setting.defaultSettings.EMAIL_ADDRESS,
        to: to,
        subject: subject,
        html: `
        <div style="margin: 5% 25% 5% 25%">
            <div style="display:flex; justify-content:space-between; align-items:center">
                <a href="${Setting.defaultSettings.FE_URL}">
                    <img class="header-logo" src="${Setting.defaultSettings.FE_URL + '/static/media/uoi-logo-white.8fc6d30d.png'}" style="width:40%"/>
                </a>
            </div>

            <div style="margin: 20px 0; width:auto; border: 1px solid #D8D8D8;">
                <div style ="color: #404040;font-family: 'Open Sans', Helvetica, sans-serif;font-weight: bold;padding: 5% 7% 5% 7%;text-align: left;line-height: 1.3;word-break: normal;font-size: 24px;">
                    ${subject}
                </div>

                ${content}

            </div>  

            <div style="text-align:center">
                <p style="${Constant.MAIL_STYLE.footer}">
                    123 Some St., Some Building
                </p>
                <p style="${Constant.MAIL_STYLE.footer}">
                    Hanoi, Vietnam
                </p>
                <a href="" style="${Constant.MAIL_STYLE.footer}">
                    Unsubscribe
                </a>
                <hr>
                <p style="margin-bottom: 10px;font-size: 11px !important;font-weight: normal;color: #404040;font-family: 'Open Sans', Helvetica, sans-serif;padding: 0;text-align: center;line-height: 15px;"">
                    Help | Facebook | Twitter | LinkedIn
                </p>
            </div>
        </div>`
    }

    transporter.sendMail(mailOptions)
}
