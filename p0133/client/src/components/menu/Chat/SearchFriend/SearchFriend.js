import React from 'react'
import settings from '../../../../config';
import '../../../styles/css/AutoCompleteText.css'
import search from '../../../styles/images/search.png'
import { toast } from 'react-toastify';

class SearchFriend extends React.Component {
  constructor(props) {
    super(props)
    this.state = { isAdd: false, search: '', isValue: false, searchTimeOut: '' }
  }

  componentDidMount = () => {
    let headers = new Headers({
      'Accept': 'application/json',
      'Content-type': 'application/json'
    })

    const search = document.getElementById('search');
    const matchList = document.getElementById('match-list');

    const searchUsers = async searchText => {
      const res = await fetch(settings.defaultSettings.REACT_APP_API_URL + '/friends/searchFriend', { headers, method: 'POST', body: JSON.stringify({ token: sessionStorage.getItem('token') }) })
      const users1 = await res.json();
      const users = users1.data;

      let matches = users.filter(user => {
        var regex = new RegExp(`^${searchText.replace(/[\-\[\]\/\{\}\(\)\*\+\?\.\\\^\$\|]/g, "\\$&")}`, 'i');
        return regex.test(user.email.trim()) || regex.test(user.display_name.trim())
      });

      let matches1
      if (this.props.friends_list && this.props.friends_list.length > 0) {
        matches1 = matches.filter((user) => {
          if (this.props.friends_list.map(friend => friend.email).indexOf(user.email) === -1)
            return user
        })
      } else {
        matches1 = matches
      }


      if (searchText.length === 0) {
        matches1 = [];
        matchList.innerHTML = '';
      }

      outputHtml(matches1);
    };

    const outputHtml = matches => {
      if (matches.length > 20) {
        matchList.innerHTML = `<div class="list-email-search">
          <div class='down'>
            <p class="low-character">Too many, one more character please</p>
          </div>
        </div>`;
      } else {
        const html = matches.map(
          match =>
            `<div class='down'>
              <div>
                <p class="name-profile">${decodeURI(match.display_name)}</p>
                <p class="email-profile">${match.email}</p>
              </div>
              <button class="add-btn" id="button${match.email}" type='button' value='${match.email}'>+</button>
            </div>`
        ).join('')
        matchList.innerHTML = `<div class="list-email-search">${html}</div>`;

        for (var x = 0; x < matches.length; x++) {
          var button = document.getElementById('button' + matches[x].email)
          button.addEventListener('click', () => this.addFriend(document.activeElement.value))
        }
      }
      if (matches.length !== 0 || document.getElementById('search').value === '') {
        this.setState({ isValue: false })
      } else {
        this.setState({ isValue: true })
      }
    }
    search.addEventListener('input', () => searchUsers(search.value));
  }

  addFriend = (email) => {
    var add = window.confirm('Are you sure to add this user ?');
    if (add) {
      let headers = new Headers({
        'Accept': 'application/json',
        'Content-type': 'application/json'
      });
      let send = { token: sessionStorage.getItem('token'), email: email }
      fetch(settings.defaultSettings.REACT_APP_API_URL + '/invitations/sendInvitations', { headers, method: 'POST', body: JSON.stringify(send) })
        .then(response => response.json())
        .then(responseJ => {
          if (responseJ.message === "already friend") {
            toast.error("Already friend!", {
              position: toast.POSITION.TOP_RIGHT
            });
          } else {
            toast.success("Invitation sent", {
              position: toast.POSITION.TOP_RIGHT
            });
            global.socket.emit('checkNewUser', { token: sessionStorage.getItem('token'), id: responseJ.id })
          }
          document.getElementById('match-list').innerHTML = '';
          document.getElementById('search').value = '';
        })
        .catch((e) => {
          toast.error('We have issues with the server. Please try again later', {
            position: toast.POSITION.TOP_RIGHT
          });
        });
    };
  };

  handleChange = async (e) => {
    await this.setState({ search: e.target.value })
    if (this.state.isValue) {
      var text = document.getElementById('search').value;
      document.getElementById('value2').value = text;
      var validemail = /^(([^<>()[\].,;:\s@"]+(\.[^<>()[\].,;:\s@"]+)*)|(".+"))@(([^<>()[\].,;:\s@"]+\.)+[^<>()[\].,;:\s@"]{2,})$/i;
      if (validemail.test(text)) {
        document.getElementById('MoreFriend').disabled = false;
        document.getElementById('responseNotUser').innerHTML = 'No user found!'
      } else {
        if (document.getElementById('MoreFriend')) {
          document.getElementById('MoreFriend').disabled = true;
        }
      }
    }
  }

  handleKeyDownSearch = e => {
    if (e.which === 27) {
      this.setState({ search: '', isValue: false })
    }
    if (document.getElementById('MoreFriend')) {
      document.getElementById('MoreFriend').disabled = true;
    }
  }

  isVisible = () => {
    if (this.state.isValue) {
      return (
        <div className="no-user-box">
          <textarea className='notUser' id='value2' readOnly={true}></textarea>
          <div className='No_account'>
            <span className='responseNotUser' id='responseNotUser' >Not found</span>
          </div>
        </div>
      )
    }
  }

  render() {
    return (
      <div className='full'>
        <div className='allinclude'>
          <img className='searchpic' src={search} alt='' />
          <input className='form-control search_zone' type='text' id='search' value={this.state.search} placeholder='Search and add users' onKeyDown={this.handleKeyDownSearch} onChange={this.handleChange} autoComplete='off' />
        </div>
        {this.isVisible()}
        <h3 id='match-list'></h3>
      </div>
    )
  }
}

export default SearchFriend;
