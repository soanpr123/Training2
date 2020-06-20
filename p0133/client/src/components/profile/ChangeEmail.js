import React from 'react'
import '../styles/css/ChangeEmail.css'
import Nav from '../Nav'
import settings from '../../config'

class ChangeEmail extends React.Component {
    constructor(props) {
        super(props)
        this.state = { email: '', newEmail: '', confirmNewEmail: '', isLogin: false }
    }

    handleChange = (event) => {
        this.setState({ [event.target.id]: event.target.value })
    }

    submitNewEmail = (e) => {
        e.preventDefault();
        document.getElementById('response').innerHTML = '';
        document.getElementById('overlay').classList.add('d-block');
        document.getElementById('loader').classList.add('d-block');
        let headers = new Headers({
            'Accept': 'application/json',
            'Content-type': 'application/json'
        })
        const { email, newEmail, confirmNewEmail } = this.state
        var emailSynthaxEmail = (settings.APP_CONFIG.RegexEmail).test(email)
        var emailSynthaxNewEmail = (settings.APP_CONFIG.RegexEmail).test(newEmail)
        let send = { token: sessionStorage.getItem('token'), email, newEmail }
        if (!!email && !!newEmail & !!confirmNewEmail) {
            if (emailSynthaxEmail && emailSynthaxNewEmail) {
                if (email !== newEmail) {
                    if (newEmail === confirmNewEmail) {
                        fetch(settings.defaultSettings.REACT_APP_API_URL + '/user/changeEmail', { headers, method: 'POST', body: JSON.stringify(send) })
                            .then(response => response.json())
                            .then(data => {
                                if (data.message === 'Wrong email address') {
                                    document.getElementById('overlay').classList.remove('d-block');
                                    document.getElementById('loader').classList.remove('d-block');
                                    document.getElementById('response').className = 'text_change_error'
                                    document.getElementById('response').innerHTML = 'This is not your actual email address.'
                                } else if (data.message === 'already used') {
                                    document.getElementById('overlay').classList.remove('d-block');
                                    document.getElementById('loader').classList.remove('d-block');
                                    document.getElementById('response').className = 'text_change_error'
                                    document.getElementById('response').innerHTML = 'Your new email address is already used.'
                                } else {
                                    sessionStorage.removeItem('token')
                                    document.getElementById('overlay').classList.remove('d-block');
                                    document.getElementById('loader').classList.remove('d-block');
                                    document.getElementById('response').className = 'text_change_good'
                                    document.getElementById('response').innerHTML = 'An email has been send to you on your new email address.'
                                    setTimeout(() => {
                                        this.setState({ isLogin: true })
                                        this.going()
                                    }, 3000)
                                }
                            })
                            .catch(error => {
                                document.getElementById('overlay').classList.remove('d-block');
                                document.getElementById('loader').classList.remove('d-block');
                                document.getElementById('response').className = 'text_change_error'
                                document.getElementById('response').innerHTML = 'We have issues to connect to the server. Please try again later.'
                            })
                    } else {
                        document.getElementById('overlay').classList.remove('d-block');
                        document.getElementById('loader').classList.remove('d-block');
                        document.getElementById('response').className = 'text_change_error'
                        document.getElementById('response').innerHTML = 'You do not enter the same new email address.'
                    }
                } else {
                    document.getElementById('overlay').classList.remove('d-block');
                    document.getElementById('loader').classList.remove('d-block');
                    document.getElementById('response').className = 'text_change_error'
                    document.getElementById('response').innerHTML = 'Your new email address can not be the same as your old one.'
                }

            } else {
                document.getElementById('overlay').classList.remove('d-block');
                document.getElementById('loader').classList.remove('d-block');
                document.getElementById('response').className = 'text_change_error'
                document.getElementById('response').innerHTML = 'Please enter a valid email address'
            }
        } else {
            document.getElementById('overlay').classList.remove('d-block');
            document.getElementById('loader').classList.remove('d-block');
            document.getElementById('response').className = 'text_change_error'
            document.getElementById('response').innerHTML = 'You must fill all the fields!'
        }
    }

    going = () => {
        if (this.state.isLogin) {
            window.location.href = '/login'
        } else {
            window.location.href = '/menu'
        }
    }

    render() {
        return (
            <div>
                <Nav />
                <div className="form">
                    <form className="form-horizontal signup">
                        <div className="form-wrap" style={{ position: 'relative' }}>
                            <h2>Change Email Address</h2>
                            <div className="form-group">
                                <div className="relative-singup">
                                    <input className="form-control form-control-singup" type='email' name='email' id='email' required autofocus
                                        placeholder='Current email address'
                                        value={this.state.email}
                                        onChange={this.handleChange} />
                                    <i className="fa fa-envelope" />
                                </div>
                            </div>
                            <div className="form-group">
                                <div className="relative-singup">
                                    <input className="form-control form-control-singup" type='email' name='email' id='newEmail' required autofocus
                                        placeholder='New email address'
                                        value={this.state.newEmail}
                                        onChange={this.handleChange} />
                                    <i className="fa fa-envelope-o" />
                                </div>
                            </div>
                            <div className="form-group">
                                <div className="relative-singup">
                                    <input className="form-control form-control-singup" type='email' name='email' id='confirmNewEmail' required autofocus
                                        placeholder='Confirm new email address'
                                        value={this.state.confirmNewEmail}
                                        onChange={this.handleChange} />
                                    <i className="fa fa-envelope-o" />
                                </div>
                            </div>
                            <div className="login-btn">
                                <button className="movebtn movebtnsu" type="Submit" value='Submit' onClick={this.submitNewEmail}>Submit <i className="fa fa-fw fa-paper-plane" /></button>
                            </div>
                        </div>
                        <p id='response'></p>
                        <div className="sign-up">
                            <a href="/menu/EditMyProfile" className="signbtn"><small className="go-back">← Go back</small></a>
                        </div>
                    </form>
                </div>

                <div class="overlay" id="overlay">
                    <div class="overlay__inner" id="loader">
                        <div class="overlay__content"><span class="spinner"></span></div>
                    </div>
                </div>

            </div>
        )
    }
}

export default ChangeEmail
