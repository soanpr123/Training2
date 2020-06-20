import React, { Component } from 'react'
import settings from '../../../../config';
import voispy from '../../../styles/images/uoi-logo-white.png';
import { Redirect } from 'react-router-dom';
import handlePage from '../../../../actions/handlePageActions';
import { connect } from 'react-redux';
import defaultAvatar from '../../../styles/images/avatar-icon.png';
import fetchEditMyStatus from '../../../../actions/EditStatusActions';

class NavTop extends Component {
  constructor(props) {
    super(props)
		this.dropdown = React.createRef()
    this.dropdownButton = React.createRef()
    this.state = { isUserProfile: false, isEditMyProfile: false, isMenu: false, isAdmin: false, status: '' }
    this.events = ["load", "mousemove", "click", "scroll", "keypress"];
    for (var i in this.events) {
      window.addEventListener(this.events[i], this.resetTimeout);
    }   
  }

  showStatus = () => {
    return (
      <div className='status_container'>
        <div className='user-status-info'>
          <div className='user-nav-name color_text'>{this.props.display_name}</div>
          {this.statusColor()}
        </div>
        <img src={this.props.avatar ? `${settings.defaultSettings.REACT_APP_API_URL}/avatars/${this.props.avatar}` : ''} onError={this.addDefaultSrc} alt='' />
      </div>
    )
	}

	userProfile = () => {
    if (this.state.isUserProfile) {
      const profileUser = [
          { title: 'Phone', value: this.props.phone },
          { title: 'Bio', value: this.props.bio !== 'null' ? this.props.bio : "" },
          { title: 'Department', value: this.props.company },
      ];
      return (
        <div id='Dropdown' className="dropdown-content" ref={this.dropdown}>
          <p className='userName'>{this.props.display_name}</p>
          <p className='userEmail'>{this.props.email}</p>
          <div className='horizontale-profile'></div>
          <div className='infos'>
            {
              profileUser.map((profile) => (
                <div className={`info-${profile.title.toLowerCase()}`} key={profile.title}>
                  <p>{profile.title}</p>
                  <p className="props">{profile.value}</p>
                </div>
              ))
            }
          </div>
          {this.editMyProfile()}
          <div className='infos-action-buttons'>
						{this.props.admin ? <button type="button" className='movebtn admin-button' onClick={this.showAdmin.bind(this)}>Admin</button> : ''}
            <button className='movebtn edit-button' type='button' onClick={this.showEditMyProfile.bind(this)}>Edit</button>
            <button className='movebtn logout-button' type='button' onClick={this.logout.bind(this)}>Log Out</button>
          </div>
        </div>
      )
    }
	}
	
	showMenu = () => {
    this.setState({ isMenu: true })
  }

  menu = () => {
    if (this.state.isMenu) {
      return (<Redirect to={{ pathname: '/menu' }} />)
    }
	}

	showAdmin = async (event) => {
    if (this.props.videoPage) {
      if (window.confirm("You are in a call. Leaving now will leave the call?")) {
        if (this.props.admin) {
          await this.props.endCallFunction();
          await this.props.dispatch(handlePage(this.props.callPage, false, true))
          await this.setState({ isAdmin: true })
        }
      }
    } else {
      if (this.props.admin) {
        await this.setState({ isAdmin: true })
      }
    }
  }

  admin = () => {
    if (this.state.isAdmin && this.props.admin) {
      return (<Redirect to={{ pathname: '/admin' }} />)
    }
  }

	showEditMyProfile = async () => {
    if (this.props.videoPage) {
      if (window.confirm("You are in a call. Leaving now will leave the call?")) {
        await this.props.endCallFunction();
        await this.props.dispatch(handlePage(this.props.callPage, false, true))
        await this.setState({ isEditMyProfile: true, isUserProfile: false })
      }
    } else {
      await this.setState({ isEditMyProfile: true, isUserProfile: false })
    }
  }

  editMyProfile = () => {
    if (this.state.isEditMyProfile) {
      return (<Redirect to={{ pathname: "/menu/EditMyProfile" }} />)
    }
	}

	showUserProfileDropdown = () => {
    this.setState(({ isUserProfile }) => ({ isUserProfile: !isUserProfile }));
  }

  notShowUserProfileDropdown = (event) => {
    if (this.dropdown.current && !this.dropdown.current.contains(event.target)) {
      if (!this.dropdownButton.current || !this.dropdownButton.current.contains(event.target)) {
        this.setState({ isUserProfile: false })
      }
    }
	}

	logout = async () => {
    await this.props.dispatch(fetchEditMyStatus(sessionStorage.getItem('token'), 'Offline'))
    sessionStorage.removeItem('token')
    global.socket.disconnect();
    window.location.href = '/login';
	}

	addDefaultSrc(ev) {
		ev.target.src = defaultAvatar
	}

	statusColor = () => {
    if (this.state.status === 'Offline') {
      return (<div id='status' className='user-status offline_status'>• {this.state.status}</div>)
    } else {
      return (<div id='status' className='user-status online_status'>• {this.state.status !== undefined ? "Online" : this.state.status}</div>)
    }
	}
	
  componentDidMount = () => {
		document.addEventListener("mousedown", this.notShowUserProfileDropdown.bind(this));
	}
	
  componentWillUnmount = () => {
		document.removeEventListener("mousedown", this.notShowUserProfileDropdown.bind(this));
	}
		
  render() {
    return (
		<nav className='nav_top'>
			<img className='img_menu' onClick={this.showMenu.bind(this)} src={voispy} alt='' />
			<p className='title_menu'>U-Oi Communication Tool</p>
				{this.showStatus()}
			<div className="dropdown">
				<button className="dropbtn" ref={this.dropdownButton} onClick={this.showUserProfileDropdown.bind(this)}><i className="fa fa-angle-down drop-icon" aria-hidden="true"></i></button>
				{this.userProfile()}
			</div>
			{this.editMyProfile()}
			{this.menu()}
			{this.admin()}
		</nav>
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
    avatar: state.myProfileReducer.avatar,
    admin: state.authorizationReducer.admin,
    callPage: state.pageReducer.callPage,
    videoPage: state.pageReducer.videoPage,
    friends_list: state.myProfileReducer.friends_list,
  }
}

export default connect(mapStateToProps)(NavTop)
