import React, { Component } from 'react';
import InputMask from 'react-input-mask';
import '../styles/css/App.css';
import '../styles/css/Signup.css';
import Nav from '../Nav.js';
import saltHashPassword from '../password/Crypto.js'
import settings from '../../config'

class Signup extends Component {
  constructor(props) {
    super(props)
    this.state = { email: '', password: '', confirmPassword: '', firstName: 'default', lastName: 'default', displayName: '', phoneNumber: '' }
  }
  handleChange = (event) => {
    this.setState({
      [event.target.id]: event.target.value
    })
  }

  back = () => {
    document.getElementById('redirect').content = '0; URL=/login'
    window.location.href = '/login';
  }

  handleSubmit = (event) => {
    event.preventDefault()
    document.getElementById('response').innerHTML = '';
    document.getElementById('overlay').classList.add('d-block');
    document.getElementById('loader').classList.add('d-block');
    const { email, password, confirmPassword, firstName, lastName, displayName, phoneNumber } = this.state;
    if (password === confirmPassword) {
      let headers = new Headers({
        'Accept': 'application/json',
        'Content-type': 'application/json'
      })
      let send;
      var urlSplit = window.location.href.split('/');
      var urlVal = urlSplit[urlSplit.length - 1]
      if (urlVal === 'signup') {
        let passwordData = saltHashPassword(password);
        let hashed = { passwordHash: passwordData.passwordHash, salt: passwordData.salt }
        send = { token: "null", email: email, firstName: encodeURI(firstName), lastName: encodeURI(lastName), phoneNumber: phoneNumber, displayName: encodeURI(displayName), hashed: hashed, personalId: '' }
      } else {
        let passwordData = saltHashPassword(password);
        let hashed = { passwordHash: passwordData.passwordHash, salt: passwordData.salt }
        send = { token: urlVal, email: email, firstName: encodeURI(firstName), lastName: encodeURI(lastName), phoneNumber: phoneNumber, displayName: encodeURI(displayName), hashed: hashed, personalId: '' }
      }
      fetch(settings.defaultSettings.REACT_APP_API_URL + '/signup', {
        headers, method: 'POST', body: JSON.stringify(send)
      })
        .then(function (response) {
          return response.json()
        })
        .then(function (responseJ) {
          if (responseJ.message === 'mail') {
            document.getElementById('overlay').classList.remove('d-block');
            document.getElementById('loader').classList.remove('d-block');
            document.getElementById('response').innerHTML = 'This email address has already been used'
          }
          else {
            document.getElementById('loader').classList.remove('d-block');
            document.getElementById('success-container').classList.add('d-block');
            document.getElementById('response').innerHTML = '';
          }
        })
        .catch(function (error) {
          document.getElementById('overlay').classList.remove('d-block');
          document.getElementById('loader').classList.remove('d-block');
          document.getElementById('response').innerHTML = 'We have issues connecting to the server. Please try again later'
        })
    } else {
      document.getElementById('overlay').classList.remove('d-block');
      document.getElementById('loader').classList.remove('d-block');
      document.getElementById('response').innerHTML = 'Not the same password !'
    }
  }

  printError = (event) => {
    const { email, password, confirmPassword, displayName, phoneNumber } = this.state;
    const enable = email !== '' &&
      password !== '' &&
      confirmPassword !== '' &&
      displayName !== '' &&
      phoneNumber !== '';
    if (!enable) {
      document.getElementById('response').innerHTML = 'You must fill all the fields!'
    }
  }


  render() {
    return (
      <div>
        <Nav />
        <div className="form">
          <form className="form-horizontal signup" onSubmit={this.handleSubmit.bind(this)} method='post' autoComplete="off">
            <div className="form-wrap" style={{ position: 'relative' }}>
              <h2>Sign Up</h2>
              <div className="form-group">
                <div className="relative-singup">
                  <input className="form-control form-control-singup" type='text' name='displayName' id='displayName'
                    placeholder='Full Name'
                    value={this.state.displayName}
                    onChange={this.handleChange} maxLength="50" required />
                  <i className="fa fa-user-o" />
                </div>
              </div>
              <div className="form-group">
                <div className="relative-singup">
                  <InputMask mask="(999) 999-9999" type='tel' name='phoneNumber' id='phoneNumber' className="form-control form-control-singup" placeholder='(012) 345-6789'
                    maskChar={0}
                    value={this.state.phoneNumber}
                    onChange={this.handleChange}
                    required />
                  <i className="fa fa-phone" />
                </div>
              </div>
              <div className="form-group">
                <div className="relative-singup">
                  <input className="form-control form-control-singup" type='email' title="expected @" name='email' id='email'
                    placeholder='Email@example.com'
                    value={this.state.email}
                    onChange={this.handleChange} required autoComplete="new-email" />
                  <i className="fa fa-envelope" />
                </div>
              </div>
              <div className="form-group">
                <div className="relative-singup">
                  <input type='password' name='password' id='password' className="form-control form-control-singup sign-up-password"
                    placeholder='Password'
                    value={this.state.password}
                    onChange={this.handleChange} required autoComplete="new-password" />
                  <i className="fa fa-key" />
                </div>
              </div>
              <div className="form-group">
                <div className="relative-singup">
                  <input type='password' name='confirmPassword' id='confirmPassword' className="form-control form-control-singup sign-up-confirmpassword"
                    placeholder='Confirm Password'
                    value={this.state.confirmPassword}
                    onChange={this.handleChange} required autoComplete="new-password" />
                  <i className="fa fa-key" />
                </div>
              </div>
              <div className="login-btn">
                <button className="movebtn movebtnsu" type='submit' onClick={this.printError.bind(this)}>Submit <i className="fa fa-fw fa-paper-plane" /></button>
                {/*}
                <div className="relative-hr"><hr className="login-hr" /><span className="login-text">or signup with</span></div>
                <div className="clearfix" />
                <div className="social-btn clearfix">
                  <button className="movebtn google" type="button">Google <i className="fa fa-fw fa-google" /></button>
                  <button className="movebtn facebook" type="button">Facebook <i className="fa fa-fw fa-facebook" /></button>
                </div>
                {*/}
              </div>
            </div>
            <meta className='response' id='redirect' httpEquiv='refresh'></meta>
            <p className='response' id='response'></p>
            <div className="sign-up">
              <a href="login" className="signbtn"><small>Already member? Sign in</small></a>
            </div>
          </form>
        </div>

        <div class="overlay" id="overlay">
          <div class="overlay__inner" id="loader">
            <div class="overlay__content"><span class="spinner"></span></div>
          </div>
          <div className="success-container" id="success-container">
            <div className="row">
              <div className="modalbox success center animate">
                <div className="icon">
                  <i class="fa fa-check success-icon" aria-hidden="true"></i>
                </div>
                <h1>Success!</h1>
                <p>We've sent a confirmation to your email,
                <br />please verify it and wait for admin to activate your account.</p>
                <a href="/login"><div className="movebtn movebtnsu save-btn">Login</div></a>
              </div>
            </div>
          </div>
        </div>

      </div>
    )
  }
}

export default Signup;
