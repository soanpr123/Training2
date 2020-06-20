//Libiraries
import React from 'react';
import { connect } from 'react-redux';
import { toast } from 'react-toastify';

//Actions
import fetchInfoFriend from '../../../../actions/InfoFriendActions';
import fetchDeleteFriend from '../../../../actions/DeleteFriendActions';
import fetchUpdateFriendsList from '../../../../actions/UpdateFriendsActions';

//Components

//Others
import '../../../styles/css/InfoFriend.css';
import settings from '../../../../config';

class InfoFriend extends React.Component {
  constructor(props) {
    super(props)
    this.state = { show: false }
  }

  componentDidMount = () => {
    if (this.props.id === 0) {
      this.props.close()
    } else {
      this.props.dispatch(fetchInfoFriend(this.props.idFriend))
      this.setState({ show: true })
    }
  }

  close = () => {
    this.props.close()
  }

  delete = async () => {
    await this.props.dispatch(fetchDeleteFriend(sessionStorage.getItem('token'), this.props.idFriend))

    this.props.close()
    global.socket.emit("checkNewUser", { token: sessionStorage.getItem('token'), id: this.props.idFriend })
    toast.success("Friend deleted", {
      position: toast.POSITION.TOP_RIGHT,
      toastId: "delete friend"
    });
  }

  findFriendAvatar = () => {
    for (let j = 0; j < this.props.friends_list.length; j++) {
      if (this.props.idFriend === this.props.friends_list[j].id) {
        return this.props.friends_list[j].avatars
      }
    }
  }

  addDefaultSrc(ev) {
    ev.target.src = `${settings.defaultSettings.REACT_APP_API_URL}/avatars/Anonyme.jpeg`;
  }

  render() {
    const listAction = [
      { title: 'callVideoInfo', icon: "fa fa-video-camera video-call-icon", onClick: () => this.props.call(this.props.idFriend, this.props.status) },
      { title: 'mailInfo', icon: "fa fa-envelope envelope-icon", onClick: () => { window.location.href = `mailto:${this.props.email}` } },
    ];
    if (this.props.idFriend !== 0) {
      return (
        <div className='friend_container'>
          <div className="basic-info-friend">
            <div className="avatar-friend"><img className='imgUser' src={`${settings.defaultSettings.REACT_APP_API_URL}/avatars/${this.findFriendAvatar()}`} onError={this.addDefaultSrc} alt='' /></div>
            <div className="name-email-friend-wrap">
              <div className='name-friend'>{this.props.display_name}</div>
              <div className='email-friend'>{this.props.email}</div>
            </div>
          </div>
          <hr />
          <div className="action-info-friend">
            {listAction.map((action) => <i className={action.icon} onClick={action.onClick} key={action.title}></i>)}
          </div>
          <hr />
          <div className='info-friend-label'>Phone</div>
          <div className='info_friend_caracteristic'>{this.props.phone}</div>
          <div className='info-friend-label '>Bio</div>
          <div className='info_friend_caracteristic info-bio'>{this.props.bio !== 'null' ? decodeURI(this.props.bio) : ""}</div>
          <div className='info-friend-label'>Department</div>
          <div className='info_friend_caracteristic'>{this.props.company}</div>
          <div className='info-friend-button'>
            <button className='movebtn info-friend-delete' onClick={this.delete.bind(this)}><i className="fa fa-trash-o" aria-hidden="true"></i> Delete</button>
            <button className='movebtn info-friend-close' onClick={this.close.bind(this)}><i className="fa fa-times-circle-o" aria-hidden="true"></i> Close</button>
          </div>
        </div>
      )
    } else {
      return (<div className='friend_container'><p>Loading...</p></div>)
    }
  }
}

const mapStateToProps = (state) => {
  return {
    first_name: decodeURI(state.infoFriendReducer.first_name),
    last_name: decodeURI(state.infoFriendReducer.last_name),
    display_name: decodeURI(state.infoFriendReducer.display_name),
    avatar: state.infoFriendReducer.avatar,
    email: state.infoFriendReducer.email,
    bio: state.infoFriendReducer.bio,
    company: state.infoFriendReducer.company,
    phone: state.infoFriendReducer.phone,
    status: state.infoFriendReducer.status,
    friends_list: state.myProfileReducer.friends_list,
  }
}

export default connect(mapStateToProps)(InfoFriend)
