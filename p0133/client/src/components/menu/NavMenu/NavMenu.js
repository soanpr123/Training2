//Libiraries
import React from 'react';
import { connect } from 'react-redux';
import 'socket.io-client';

//Actions
import fetchUpdateFriendsList from '../../../actions/UpdateFriendsActions';
import fetchEditMyStatus from '../../../actions/EditStatusActions';
import fetchMyProfile from '../../../actions/MyProfileActions';

//Components
import DeviceWarning  from './DeviceWarning';
import NavTop from './NavTop';
//Others
import '../../styles/css/NavMenu.css';

class NavMenu extends React.Component {
  constructor(props) {
    super(props)
    this.state = { isShowMobileWarning: false, isMobileDevice: false }

  }

  switchDeviceWarning = (state) => {
    this.setState({ isShowMobileWarning: state })
  }


  componentDidMount = () => {

    global.socket.emit('user', { token: sessionStorage.getItem('token') })

    global.socket.on('connected', (data) => {
      document.getElementById('overlay').classList.remove('d-block');
      //console.log("connected: " + data.userid + " socket id: " + data.socketid)
      this.props.dispatch(fetchUpdateFriendsList(sessionStorage.getItem('token')))
      this.props.dispatch(fetchEditMyStatus(sessionStorage.getItem('token'), 'Online'))
    })

    global.socket.on('disconnect', (data) => {
      document.getElementById('overlay').classList.add('d-block');
      global.socket.connect();
      global.socket.emit('user', { token: sessionStorage.getItem('token') })
      //console.log("disconnect: " + data.userid + " socket id: " + data.socketid)
      this.props.dispatch(fetchMyProfile(sessionStorage.getItem('token')))
    })

    window.addEventListener('online', () => {
      document.getElementById('overlay').classList.remove('d-block');
      global.socket.connect();
      global.socket.emit('user', { token: sessionStorage.getItem('token') })
    });

    window.addEventListener('offline', () => {
        document.getElementById('overlay').classList.add('d-block');
    });

    global.socket.on('connectOne', (data) => {
      if (this.props.friends_list.length > 0) {
        this.props.friends_list.map((friend) => {
          if (friend.id === data.id) {
            this.updateStatusFriends()
          }
          return null
        })
      }
    })

    global.socket.on('disconnectOne', (data) => {
      if (this.props.friends_list.length > 0) {
        this.props.friends_list.map((friend) => {
          if (friend.id === data.id) {
            this.updateStatusFriends()
          }
          return null
        })
      }
    })

    global.socket.on('checkNewUser', (data) => {
      this.updateStatusFriends()
    })

    global.socket.on('allCheckNewUser', (data) => {
      this.updateStatusFriends()
    })

    this.props.dispatch(fetchMyProfile(sessionStorage.getItem('token')))
    this.intervalFetch = setInterval(() => this.updateStatusFriends(), 30 * 1000)

    global.socket.on('check_status', (data) => {
      this.setState({ status: data.status })
    })
  }

  componentWillUnmount = () => {
      clearInterval(this.intervalFetch)
      global.socket.emit('check_status', { token: sessionStorage.getItem('token') })
    }

  updateStatusFriends = () => {
    this.props.dispatch(fetchUpdateFriendsList(sessionStorage.getItem('token')))
  }


  render() {
    return (
      <>
        <DeviceWarning
          isShowMobileWarning = {this.state.isShowMobileWarning}
          switchDeviceWarning = {this.switchDeviceWarning.bind(this)}
        />
        <NavTop endCallFunction = {this.props.endCallFunction}/>
        <div className="overlay" id="overlay">
          <div className="overlay__inner" id="loader">
            <div className="overlay__content">
              <span className="spinner"></span>
              <div className="reconnect-title">Reconnecting...</div>
            </div>
          </div>
        </div>
      </>
    )
  }
}

const mapStateToProps = (state) => {
  return {
    email: state.myProfileReducer.email,
    phone: state.myProfileReducer.phone,
    company: state.myProfileReducer.company,
    display_name: decodeURI(state.myProfileReducer.display_name),
    bio: decodeURI(state.myProfileReducer.bio),
    status: state.myProfileReducer.status,
    loading_profile: state.myProfileReducer.loading,
    error_status: state.myProfileReducer.error_status,
    avatar: state.myProfileReducer.avatar,
    admin: state.authorizationReducer.admin,
    callPage: state.pageReducer.callPage,
    videoPage: state.pageReducer.videoPage,
    chatPage: state.pageReducer.chatPage,
    friends_list: state.myProfileReducer.friends_list,
  }
}

export default connect(mapStateToProps)(NavMenu)
