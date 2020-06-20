/* eslint-disable jsx-a11y/alt-text */
import React from 'react';
import '../styles/css/ForgotPassword.css';
import Nav from '../Nav.js';
import settings from '../../config';



class ForgotPassword extends React.Component {
  constructor(props) {
    super(props)
    this.state = { email: sessionStorage.getItem('email_tried') }
  }

  async emailPreset(event) {
    if (sessionStorage.getItem("email_tried")) {
      return sessionStorage.getItem("email_tried");
    } else {
      return 'Email@example.com'
    }
  }

  handleEmail = (event) => {
    this.setState({ email: event.target.value })
  }

  back = (event) => {
    document.getElementById('redirect').content = '0; URL=/login'
    window.location.href = '/login'
  }

  sendEmail = (e) => {
    e.preventDefault();
    document.getElementById('response').innerHTML = '';
    document.getElementById('overlay').classList.add('d-block');
    document.getElementById('loader').classList.add('d-block');
    if (this.state.email.length > 0) {
      let headers = new Headers({
        'Accept': 'application/json',
        'Content-type': 'application/json'
      })

      fetch(settings.defaultSettings.REACT_APP_API_URL + '/password/frgtPasswrd', { headers, method: 'POST', body: JSON.stringify(this.state) })
        .then(function (response) {
          return response.json()
        })
        .then(function (responseJ) {
          console.log(responseJ.message)
          if (responseJ.message === 'true') {
            document.getElementById('overlay').classList.remove('d-block');
            document.getElementById('loader').classList.remove('d-block');
            document.getElementById('response').className = 'text_response_good'
            document.getElementById('response').innerHTML = 'An email has been send to you ! '
              + 'We are redirecting you on the Login page.'
            setTimeout(() => {
              document.getElementById('redirect').content = '2; URL=/login'
              window.location.href = '/login'
            }, 5000)
          } else {
            document.getElementById('overlay').classList.remove('d-block');
            document.getElementById('loader').classList.remove('d-block');
            document.getElementById('response').className = 'text_response_error'
            document.getElementById('response').innerHTML = 'This email address is not attached to an account.'
          }
        })
        .catch(function (error) {
          document.getElementById('overlay').classList.remove('d-block');
          document.getElementById('loader').classList.remove('d-block');
          document.getElementById('response').className = 'text_response_error'
          document.getElementById('response').innerHTML = 'We have issues to connect to the server. Please try again later.'
        })
    } else {
      document.getElementById('overlay').classList.remove('d-block');
      document.getElementById('loader').classList.remove('d-block');
      document.getElementById('response').className = 'text_response_error'
      document.getElementById('response').innerHTML = 'Enter your email address before submitting'
    }
  }

  render() {
    return (
      <div className="forgot-password-container">
        <Nav />
        <div className="form">
          <form className="form-horizontal signin" autoComplete="off">
            <div className="form-wrap" style={{ position: 'relative' }}>
              <h2>Forgot Password</h2>
              <div className="form-group">
                <div className="relative">
                  <input className="form-control form-control-singup" type='email' name='email' id='email'
                    placeholder='Email@example.com'
                    value={this.state.email}
                    onChange={this.handleEmail} required />
                  <i className="fa fa-user" />
                </div>
              </div>
              <div className="login-btn">
                <button className="movebtn movebtnsu" type='submit' value='Submit' onClick={this.sendEmail}>Reset Password <i className="fa fa-fw fa-lock" /></button>
              </div>
              <div className="sign-up">
                <meta className='response' id='redirect' httpEquiv='refresh'></meta>
                <p id='response' className='response-forgot-password'></p>
                <meta id='redirect' httpEquiv='refresh'></meta>
                <a href="login" className="signbtn"><small>Have an account? Log in</small></a>
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
export default ForgotPassword
