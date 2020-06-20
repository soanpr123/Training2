import React from 'react'
import '../styles/css/VerifiedEmail.css'
import settings from '../../config'


class VerifiedEmail extends React.Component {

  componentDidMount = () => {
    let headers = new Headers({
      'Accept': 'application/json',
      'Content-type': 'application/json'
    })
    var urlSplit = window.location.href.split('/');
    var token = urlSplit[urlSplit.length - 1]
    fetch(settings.defaultSettings.REACT_APP_API_URL + '/verifiedEmail', { headers, method: 'POST', body: JSON.stringify({ token: token }) })
      .then(function (response) {
          return response.json()
      })
      .then(function (responseJ) {
          if (responseJ.message === 'verified') {
              document.getElementById('response').className = 'response_good_verified'
              document.getElementById('response').innerHTML = 'Your account is verified. Please wait for an admin to activate your account.'
              document.getElementById('redirect').innerHTML = '<a href="/login"><button type="button" class="movebtn movebtnsu save-btn login-verified">Login</button></a>'
          }
      })
      .catch(function (error) {
          document.getElementById('response').className = 'response_wrong_verified'
          document.getElementById('response').innerHTML = 'We have issues to connect to the server. Please try again later.'
      })
  }
  render() {
    return (
      <div className='main_container_verified'>
        <p id='response'></p>
        <p className='response_good_verified' id='redirect'> Loading ...</p>
      </div>
    )
  }
}
export default VerifiedEmail;
