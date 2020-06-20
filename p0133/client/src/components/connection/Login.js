import React from 'react'
import '../styles/css/App.css'
import '../styles/css/Login.css'
import Nav from '../Nav.js'
import saltHashPasswordSalt from '../password/CryptoSalt';
import encryptRSA from '../password/CryptoRSA';
import settings from '../../config'

class Login extends React.Component {
  constructor(props) {
    super(props)
    this.state = { email: '', password: '' }
  }

  handleChange = (event) => {
    document.getElementById('response').innerHTML = ''
    this.setState({
      [event.target.id]: event.target.value
    })
  }

  keyPressed(event) {
    if (event.key === "Enter") {
      this.handleSubmit.bind(this)
    }
  }

  handleSubmit = (event) => {
    event.preventDefault()
    const usernameIsValid = (username) => {
      return /^[0-9a-zA-Z_.-_@+-]+$/.test(username);
    }

    if (this.state.password && this.state.email && usernameIsValid(this.state.email)) {
      document.getElementById('response').innerHTML = '';
      document.getElementById('overlay').classList.add('d-block');
      sessionStorage.setItem("email_tried", this.state.email);
      let pass = this.state.password;
      let encryptedUser = encryptRSA(this.state.email, this.state.password)
      let headers = new Headers({
        'Accept': 'application/json',
        'Content-type': 'application/json'
      });

      fetch(settings.defaultSettings.REACT_APP_API_URL + '/login', { headers, method: 'POST', body: JSON.stringify({ email: this.state.email }) })
        .then(function (response) {
          return response.json();
        })
        .then(async function (responseJ) {
          var passwordHash = saltHashPasswordSalt(pass, responseJ.saltKey)
          if (responseJ.password === passwordHash) {
            if (responseJ.message === 'not verified') {
              document.getElementById('overlay').classList.remove('d-block');
              document.getElementById('response').innerHTML = 'Your email address has not been verified.';
            } else if (responseJ.message === 'not activated') {
              document.getElementById('overlay').classList.remove('d-block');
              document.getElementById('response').innerHTML = 'Your account has been not activated, please contact the admin';
            } else {
              sessionStorage.removeItem('email_tried')
              sessionStorage.setItem("token", responseJ.webToken)
              window.location.href = '/menu';
            }
          } else if (responseJ.message === 'no account') {
            document.getElementById('overlay').classList.remove('d-block');
            document.getElementById('response').innerHTML = "Username or password is incorrect";
          } else if (responseJ.message === 'ldapuser') {
            await fetch(settings.defaultSettings.REACT_APP_API_URL + '/login/ldap', { headers, method: 'POST', body: JSON.stringify({ encryptedUser: encryptedUser }) })
              .then(function (response) {
                return response.json();
              })
              .then(function (responseJ) {
                if (responseJ.message === 'no account') {
                  document.getElementById('overlay').classList.remove('d-block');
                  document.getElementById('response').innerHTML = "Username or password is incorrect"
                } else if (responseJ.message === 'logged') {
                  document.getElementById('overlay').classList.remove('d-block');
                  sessionStorage.removeItem('email_tried')
                  sessionStorage.setItem("token", responseJ.webToken)
                  window.location.href = '/menu';
                } else {
                  document.getElementById('overlay').classList.remove('d-block');
                  document.getElementById('response').innerHTML = 'We have issues connecting to the server. Please try again later.'
                }
              })
          } else {
            document.getElementById('overlay').classList.remove('d-block');
            document.getElementById('response').innerHTML = "Username or password is incorrect"
          }
        })
        .catch(() => {
          document.getElementById('overlay').classList.remove('d-block');
          document.getElementById('response').innerHTML = 'We have issues connecting to the server. Please try again later.'
        })
    } else {
      document.getElementById('overlay').classList.remove('d-block');
      document.getElementById('response').innerHTML = 'Please enter valid username and password'
    }
  }

  render() {
    return (
      <div className="login-page-container">
        <Nav />
        {sessionStorage.setItem("email_tried", '')}
        <div className="form">
          <form className="form-horizontal signin" onSubmit={this.handleSubmit.bind(this)} method='post' autoComplete="off">
            <div className="form-wrap" style={{ position: 'relative' }}>
              <h2>Login</h2>
              <div className="form-group">
                <div className="relative">
                  <input type="text" name='email' id='email' className='form-control-login form-control' autoComplete="off"
                    required autoFocus placeholder="Email or username"
                    value={this.state.email}
                    onChange={this.handleChange} />
                  <i className="fa fa-user" />
                </div>
              </div>
              <div className="form-group">
                <div className="relative">
                  <input className="form-control form-control-login" type="password" required name='password' id='password' autoComplete="off"
                    placeholder='Password'
                    value={this.state.password}
                    onChange={this.handleChange} />
                  <i className="fa fa-key" />
                </div>
                <span className="pull-right"><small><a href="frgtPasswrd" onChange={this.handleChange}>Forgot Password?</a></small></span>
              </div>
              <div className="login-btn">
                <button className="movebtn movebtnsu" type="Submit">Login <i className="fa fa-fw fa-lock" /></button>
                {/*}
                <div className="relative"><hr className="login-hr" /><span className="login-text">or login with</span></div>
                <div className="clearfix" />
                <div className="social-btn clearfix">
                  <button className="movebtn google" type="button" >Google <i className="fa fa-fw fa-google" /></button>
                  <button className="movebtn facebook" type="button">Facebook <i className="fa fa-fw fa-facebook" /></button>
                </div>
                */}
              </div>
            </div>
            <p className='response' id='response'></p>
            <meta className='response' id='redirect' httpEquiv='refresh'></meta>
            <div className="sign-up">
              <a href="signup" className="signbtn"><small>Not a member? Sign Up</small></a>
            </div>
          </form>
        </div>

        <div className="overlay" id="overlay">
          <div className="overlay__inner" id="loader">
            <div className="overlay__content"><span className="spinner"></span></div>
          </div>
        </div>

      </div>
    )
  }
}
export default Login;
