import React from 'react'
import '../styles/css/VerifiedEmail.css'
import settings from '../../config'


class ActivateAccount extends React.Component {
  componentDidMount = () => {
    let headers = new Headers({
      'Accept': 'application/json',
      'Content-type': 'application/json'
    })
    var urlSplit = window.location.href.split('/');
    var token = urlSplit[urlSplit.length - 1]
    fetch(settings.defaultSettings.REACT_APP_API_URL + '/activateAccount', { headers, method: 'POST', body: JSON.stringify({ token: token }) })
      .then(function (response) {
        return response.json()
      })
      .then(function (responseJ) {
        if (responseJ.message === 'activated') {
          document.getElementById('response').className = 'response_good_verified'
          document.getElementById('response').innerHTML = 'This account is activated.'
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
        <p className='response_good_verified' id='redirect'> </p>
      </div>
    )
  }
}
export default ActivateAccount;
