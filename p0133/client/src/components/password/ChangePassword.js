import React from 'react'
import '../styles/css/ChangePassword.css'
import Nav from '../Nav'
import saltHashPassword from './Crypto.js'
import settings from '../../config'

class ChangePassword extends React.Component {
  constructor(props) {
    super(props)
    this.state = { email: '', password: '', confirmPassword: '' }
    this.onKeySubmit = this.onKeySubmit.bind(this);
  }

  handleChange = (event) => {
    this.setState({ [event.target.name]: event.target.value })
  }

  onKeySubmit() {
    if (this.state.password && this.state.confirmPassword && this.state.email) {
      if (this.state.password !== this.state.confirmPassword) {
        document.getElementById('response').className = 'text_change_error'
        document.getElementById('response').innerHTML = 'Not the same password!'
      } else {
        document.getElementById('response').innerHTML = ''
      }
    }
  }

  submitNewPass = (e) => {
    e.preventDefault();
    document.getElementById('response').innerHTML = '';
    const { email, password, confirmPassword } = this.state;
    const enable = email !== '' &&
      password !== '' &&
      confirmPassword !== '';
    if (enable) {
      if (this.state.password === this.state.confirmPassword) {
        document.getElementById('overlay').classList.add('d-block');
        document.getElementById('loader').classList.add('d-block');
        let headers = new Headers({
          'Accept': 'application/json',
          'Content-type': 'application/json'
        })
        let passwordData = saltHashPassword(this.state.password)
        let hashed = { passwordHash: passwordData.passwordHash, salt: passwordData.salt }
        var urlSplit = window.location.href.split('/');
        var token = urlSplit[urlSplit.length - 1];
        let send = { token: token, email: this.state.email, hashed }
        fetch(settings.defaultSettings.REACT_APP_API_URL + '/password/changePasswrd', { headers, method: 'POST', body: JSON.stringify(send) })
          .then(function (response) {
            return response.json()
          })
          .then(function (responseJ) {
            if (responseJ.message === 'error' || responseJ.message === 'user not exist') {
              document.getElementById('overlay').classList.remove('d-block');
              document.getElementById('loader').classList.remove('d-block');
              document.getElementById('response').className = 'text_change_error'
              document.getElementById('response').innerHTML = 'This email address is not attached to an account.'
            } else {
              if (responseJ.nbConnect > 0) {
                document.getElementById('overlay').classList.remove('d-block');
                document.getElementById('loader').classList.remove('d-block');
                document.getElementById('response').className = 'text_change_good'
                document.getElementById('response').innerHTML = 'Your password has been changed. '
                  + 'We are redirecting you on the Login page.'
                setTimeout(() => {
                  document.getElementById('redirect').content = '2; URL=/login'
                  window.location.href = '/login'
                }, 5000)
              } else {
                setTimeout(() => {
                  document.getElementById('redirect').content = '0; URL=/menu/'
                  window.location.href = '/menu'
                }, 5000)
              }

            }
          })
          .catch(function (error) {
            document.getElementById('overlay').classList.remove('d-block');
            document.getElementById('loader').classList.remove('d-block');
            document.getElementById('response').className = 'text_change_error'
            document.getElementById('response').innerHTML = 'We have issues to connect to the server. Please try again later.'
          })

      } else {
        document.getElementById('overlay').classList.remove('d-block');
        document.getElementById('loader').classList.remove('d-block');
        document.getElementById('response').className = 'text_change_error'
        document.getElementById('response').innerHTML = 'Not the same password!'
      }
    } else {
      document.getElementById('response').className = 'text_change_error'
      document.getElementById('response').innerHTML = 'You must fill all the fields!'
    }
  }

  render() {
    return (
      <div>
        <Nav />
        <div className="form">
          <form className="form-horizontal signin" autoComplete="off">
            <div className="form-wrap" style={{ position: 'relative' }}>
              <h2>Change Password</h2>
              <div className="form-group">
                <div className="relative">
                  <input className="form-control form-control-login" type='email' name='email' id='email'
                    placeholder='Email@example.com'
                    value={this.state.email}
                    onChange={this.handleChange}
                    onKeyUp={this.onKeySubmit} required autoComplete="new-email" />
                  <i className="fa fa-user" />
                </div>
              </div>
              <div className="form-group">
                <div className="relative ">
                  <input id="myinput" className="form-control form-control-login" type='password' name='password'
                    placeholder='New password'
                    value={this.state.password}
                    onChange={this.handleChange}
                    onKeyUp={this.onKeySubmit} required autoComplete="new-password" aria-autocomplete="none" />
                  <i className="fa fa-key" />
                </div>
              </div>
              <div className="form-group">
                <div className="relative ">
                  <input id="myinput" className="form-control form-control-login" type='password' name='confirmPassword'
                    placeholder='Confirm new password'
                    value={this.state.confirmPassword}
                    onChange={this.handleChange}
                    onKeyUp={this.onKeySubmit} required autoComplete="new-password" />
                  <i className="fa fa-key" />
                </div>
              </div>
              <div className="login-btn">
                <button className="movebtn movebtnsu" type='submit' value='Submit' onClick={this.submitNewPass} >Change Password <i className="fa fa-fw fa-lock" /></button>
              </div>
              <p id='response'></p>
              <meta id='redirect' httpEquiv='refresh'></meta>
              <div className="sign-up">
                <a href="/menu/EditMyProfile" ><small className="go-back">← Go back </small></a>
              </div>
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

export default ChangePassword
