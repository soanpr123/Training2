import React, { Component } from 'react'
import { toast } from 'react-toastify';
import settings from '../../../config'
import moment from 'moment';
import AddUser from './AddUser';
import EditUser from './EditUser'

export default class UserManagement extends Component {
  constructor(props) {
    super(props)
    this.state = {
      users: [], isLoading: false,
      id: '',
      display_name: '',
      email: '',
      role: '',
      activated: '',
      verified: '',
      currentShowCount: 25,
      showSearch: false,
      searchInput: '',
      searchResult: [],
      selectedUsers: [],
      addModal: false,
      editModal: false,
      isBack: false,
      sortBy: 'id',
      isSortDown: false,
    }
  }

  fetchData = () => {
    let headers = new Headers({
      'Accept': 'application/json',
      'Content-type': 'application/json'
    })

    fetch(settings.defaultSettings.REACT_APP_API_URL + '/authorization/admin', { headers, method: 'POST', body: JSON.stringify({ token: sessionStorage.getItem('token') }) })
      .then(response => response.json())
      .then(responseJ => {
        if (responseJ.message === 'false') {
          document.getElementById('redirect').content = '0; URL=/menu'
        } else {
          fetch(settings.defaultSettings.REACT_APP_API_URL + '/admin/afficheUsers', { headers, method: 'POST', body: JSON.stringify({ token: sessionStorage.getItem("token"), message: 'all users' }) })
            .then(response => response.json())
            .then(responseJ => {
              this.setState({ users: responseJ.tab, isLoading: true })
            })
            .catch((e) => {
              console.log(e)
              toast.error("Cannot open admin console, server issue!", {
                position: toast.POSITION.TOP_RIGHT,
                toastId: "fail-server"
              });
            })
        }
      })
      .catch(() => document.getElementById('redirect').content = '0; URL=/menu')
  }

  updateCurrentUsersList = (users) => {
    this.setState({ users: users })
  }

  removeUser = (id, event) => {
    event.preventDefault();
    var sure = window.confirm('Are you sure to delete this user ?')
    if (sure) {
      let headers = new Headers({
        'Accept': 'application/json',
        'Content-type': 'application/json'
      })
      let send = { id: id, message: 'delete user', token: sessionStorage.getItem('token') }
      fetch(settings.defaultSettings.REACT_APP_API_URL + '/admin/deleteUsers', { headers, method: 'DELETE', body: JSON.stringify(send) })
        .then(response => response.json())
        .then(responseJ => {
          this.setState({ users: responseJ.tab, isLoading: true })
          toast.success("User deleted successfully", {
            position: toast.POSITION.TOP_RIGHT,
            toastId: "success-delete"
          });
          global.socket.emit('allCheckNewUser', { message: "check new user" })
          global.socket.emit('fetch-total-statistics', { success: true })
        })
        .catch(() => {
          this.setState({ isLoading: false })
          toast.error("User delete failed, server issue!", {
            position: toast.POSITION.TOP_RIGHT,
            toastId: "fail-delete"
          });
        })
    }
  }

  removeMultipleUser = (users, event) => {
    event.preventDefault();
    var sure = window.confirm('Are you sure to delete these users ?')
    if (sure) {
      for (let i = 0; i < users.length; i++) {
        let headers = new Headers({
          'Accept': 'application/json',
          'Content-type': 'application/json'
        })
        let send = { id: users[i], message: 'delete user', token: sessionStorage.getItem('token') }
        fetch(settings.defaultSettings.REACT_APP_API_URL + '/admin/deleteUsers', { headers, method: 'DELETE', body: JSON.stringify(send) })
          .then(response => response.json())
          .then(responseJ => {
            this.setState({ users: responseJ.tab, isLoading: true, selectedUsers: '' })
            toast.success("User deleted successfully", {
              position: toast.POSITION.TOP_RIGHT,
              toastId: "success-delete"
            });
            global.socket.emit('fetch-total-statistics', { success: true })
          })
          .catch(() => {
            this.setState({ isLoading: false })
            toast.error("User deleted failed, server issue!", {
              position: toast.POSITION.TOP_RIGHT,
              toastId: "fail-delete"
            });
          })
      }
      global.socket.emit('allCheckNewUser', { message: "check new user" })
    }
  }

  addUserModalSwitch = () => {
    this.setState({
      addModal: !this.state.addModal,
    });
  }

  editUserModalSwitch = async (id, display_name, email, role, activated, verified) => {
    await this.setState({
      editModal: true,
      id: id,
      display_name: decodeURI(display_name),
      email: email,
      role: role,
      activated: activated,
      verified: verified,
    });
  }

  editUserModalOff = () => {
    this.setState({
      editModal: false,
      id: '',
      display_name: '',
      email: '',
      role: '',
      activated: '',
      verified: ''
    })
  }

  selectUser = async (id) => {
    let selectedUsers = this.state.selectedUsers;
    console.log(selectedUsers.indexOf(id))
    if (selectedUsers.indexOf(id) === -1) {
      selectedUsers.push(id);
    } else {
      selectedUsers = selectedUsers.filter((val) => val !== id)
    }
    await this.setState({ selectedUsers: selectedUsers });
  }

  handleSearch = async (e) => {
    let searchInput = e.target.value.trim().toString();
    await this.setState({ searchInput })
    if (searchInput !== "") {
      await this.setState({ showSearch: true, currentShowCount: 25, selectedUsers: [] })
    } else {
      await this.setState({ showSearch: false, currentShowCount: 25, selectedUsers: [] })
    }
    let searchResult = []
    for (var i = 0; i < this.state.users.length; i++) {
      if (this.state.users[i].id.toString().indexOf(searchInput) !== -1 || decodeURI(this.state.users[i].display_name).indexOf(searchInput) !== -1 || this.state.users[i].email.indexOf(searchInput) !== -1) {
        searchResult.push((this.state.users[i]));
      }
    }
    await this.setState({ searchResult: searchResult })
  }

  searchUser = () => {
    return (
      <div className="admin-search-container">
        <div className="admin-search-icon-wrapper">
          <span className="admin-search-icon"><i className="fa fa-search"></i></span>
        </div>
        <input
          onChange={this.handleSearch}
          onKeyDown={this.handleKeyDownSearch}
          value={this.state.searchInput}
          name="searchterm"
          id="search-input"
          className="form-control admin-search-input"
          placeholder="Search id, displayname, or username..."
          autoComplete='new-input'
          type="text" />
      </div>
    )
  }

  userActions = (currentShowingUsers) => {
    return (
      <div className="user-actions-container">
        <div className="user-actions-container-left">
          <button className="admin-user-actions-btn admin-user-actions-add-btn" onClick={this.addUserModalSwitch}><i className="fa fa-user-plus" aria-hidden="true"></i> Add user</button>
          <button className="admin-user-actions-btn admin-user-actions-select-all-btn" onClick={this.selectAllHandler.bind(this, currentShowingUsers)}>
            {this.state.selectedUsers.length > 0
              ? <i className="fa fa-check-square-o" aria-hidden="true"></i>
              : <i className="fa fa-square-o" aria-hidden="true"></i>
            }
            <span> </span>Select all (<strong>{this.state.selectedUsers.length}</strong>)
            </button>
          {
            this.state.selectedUsers.length > 0
              ? <button className="admin-user-actions-btn admin-user-actions-remove-btn" onClick={this.removeMultipleUser.bind(this, this.state.selectedUsers)} ><i className="fa fa-user-times" aria-hidden="true"></i> Delete</button>
              : <button className="admin-user-actions-btn admin-user-actions-remove-btn deactivated"><i className="fa fa-user-times" aria-hidden="true"></i> Delete</button>
          }
          <div className="admin-total-users">Total users: {this.state.users.length}</div>
        </div>
      </div>
    )
  }

  selectAllHandler = (currentShowingUsers) => {
    if (currentShowingUsers.length > this.state.selectedUsers.length) {
      this.setState({ selectedUsers: currentShowingUsers.map((val) => val.id) })
    } else {
      this.setState({ selectedUsers: [] })
    }
  }

  loadMoreUserHandler = () => {
    this.setState({ currentShowCount: this.state.currentShowCount + 25 })
  }

  showDataBase = () => {
    let currentShowingUsers, allUserList;
    if (!this.state.showSearch) {
      allUserList = this.state.users;
      currentShowingUsers = allUserList.slice(0, this.state.currentShowCount)
    } else {
      allUserList = this.state.searchResult;
      currentShowingUsers = allUserList.slice(0, this.state.currentShowCount)
    }
    const tableHead =  [
      { title:"Id", style: { width: '60px', maxWidth: '60px' }, onClick:() => this.sortBy('id'), sortBy: "id" },
      { title:"Display Name", style: { width: '150px', maxWidth: '150px', textAlign: 'left' }, onClick:() => this.sortBy('display_name'), sortBy: "display_name" },
      { title:"Email or Username", style: { width: '230px', maxWidth: '200px', textAlign: 'left' }},
      { title:"Phone", style: { width: '125px', maxWidth: '125px' }},
      { title:"Role", style: { width: '67px', maxWidth: '67px' }, onClick:() => this.sortBy('role'), sortBy: "role" },
      { title:"Activated", style: { width: '90px', maxWidth: '90px' }, onClick:() => this.sortBy('activated'), sortBy: "activated" },
      { title:"Email Verified", style: { width: '120px', maxWidth: '120px' }, onClick:() => this.sortBy('email_verified'), sortBy: "email_verified" },
      { title:"Connections", style: { width: '110px', maxWidth: '110px' }, onClick:() => this.sortBy('connections'), sortBy: "connections" },
      { title:"LDAP User", style: { width: '100px', maxWidth: '100px' }, onClick:() => this.sortBy('ldap_user'), sortBy: "ldap_user" },
      { title:"Created Date", style: { width: '110px', maxWidth: '110px' }, onClick:() => this.sortBy('created_date'), sortBy: "created_date" },
      { title:"Actions", style: { width: '180px', maxWidth: '180px', textAlign: 'left' }},
    ]
    if (this.state.isLoading) {
      return (
        <div className="user-table-container">
          {this.userActions(currentShowingUsers)}
          {this.searchUser()}
          <table className='table user-table' id="user-table">
            <thead className='table-header'>
              <tr>
                {tableHead.map(th => (
                  <th style={th.style} key={th.title}>
                    <span>{th.title}</span>
                    <span className='sort-icon' onClick={th.onClick}>
                      {th.sortBy ?
                        (this.state.sortBy !== th.sortBy ? <i className="fa fa-sort"></i> :
                          this.state.isSortDown ? <i className="fa fa-sort-down"></i> :
                            <i className="fa fa-sort-up"></i>) : ''
                      }
                    </span>
                  </th>
                ))}
              </tr>
            </thead>
            <tbody className='table-body'>
              {
                currentShowingUsers.map((user) => {
                  return (
                    <tr className={this.state.selectedUsers.indexOf(user.id) !== -1 ? 'tr admin-user-selected' : 'tr'} key={user.id}>
                      <td style={{ width: '60px', maxWidth: '60px' }}>{user.id}</td>
                      <td style={{ width: '150px', maxWidth: '150px', textAlign: 'left' }}>{decodeURI(user.display_name)}</td>
                      <td style={{ width: '230px', maxWidth: '200px', textAlign: 'left' }}>{user.email}</td>
                      <td style={{ width: '125px', maxWidth: '125px' }}>{user.phone}</td>
                      <td style={{ width: '67px', maxWidth: '67px' }}>{user.role}</td>
                      <td style={{ width: '75px', maxWidth: '75px' }}>{user.activated === 1 ? "Yes" : "No"}</td>
                      <td style={{ width: '100px', maxWidth: '100px' }}>{user.verified === 1 ? "Yes" : "No"}</td>
                      <td style={{ width: '95px', maxWidth: '95px' }}>{user.nbConnect}</td>
                      <td style={{ width: '80px', maxWidth: '80px' }}>{user.ldapuser === 1 ? "Yes" : "No"}</td>
                      <td style={{ width: '110px', maxWidth: '110px' }}>{user.createdDate != null ? moment(new Date(parseInt(user.createdDate))).format("DD/MM/YYYY") : ''}</td>
                      <td style={{ width: '180px', maxWidth: '180px', textAlign: 'left' }}>
                        <button className="admin-btn admin-edit-btn" onClick={
                          this.editUserModalSwitch.bind(this,
                            user.id,
                            user.display_name,
                            user.email,
                            user.role,
                            user.activated,
                            user.verified
                          )}><i className="fa fa-pencil-square-o" aria-hidden="true"></i></button>
                        <button className="admin-btn admin-remove-btn" onClick={this.removeUser.bind(this, user.id)}><i className="fa fa-trash-o" aria-hidden="true"></i></button>
                        <button className={this.state.selectedUsers.indexOf(user.id) !== -1 ? "admin-btn admin-select-btn admin-selected-btn" : "admin-btn admin-select-btn"} onClick={this.selectUser.bind(this, user.id)}><i className="fa fa-check" aria-hidden="true"></i></button>
                      </td>
                    </tr>
                  )
                })
              }
            </tbody >
          </table>
          {this.state.currentShowCount < allUserList.length ? <button onClick={this.loadMoreUserHandler} className="admin-load-more-btn">Load More...</button> : ""}
        </div>
      )

    } else {
      return (<h1 className='color_text'>Loading ...</h1>)
    }
  }

  sortBy = async (key) => {
    if (this.state.sortBy !== key) {
      await this.setState({ sortBy: key, isSortDown: true })
    } else {
      await this.setState({ isSortDown: !this.state.isSortDown })
    }
    await this.sortUsers()
  }

  sortUsers = async () => {
    const { isSortDown, sortBy } = this.state
    let users
    if (this.state.searchInput) {
      users = this.state.searchResult
    } else {
      users = this.state.users
    }

    switch (sortBy) {
      case 'id':
        users.sort((a, b) => (isSortDown ? b.id - a.id : a.id - b.id))
        break;
      case 'display_name':
        users.sort((a, b) => (isSortDown ? (a.display_name.toUpperCase() > b.display_name.toUpperCase() ? -1 : 1) : (a.display_name.toUpperCase() > b.display_name.toUpperCase() ? 1 : -1)))
        break;
      case 'role':
        users.sort((a, b) => (isSortDown ? (a.role.toUpperCase() > b.role.toUpperCase() ? -1 : 1) : (a.role.toUpperCase() > b.role.toUpperCase() ? 1 : -1)))
        break;
      case 'activated':
        users.sort((a, b) => (isSortDown ? b.activated - a.activated : a.activated - b.activated))
        break;
      case 'email_verified':
        users.sort((a, b) => (isSortDown ? b.verified - a.verified : a.verified - b.verified))
        break;
      case 'connections':
        users.sort((a, b) => (isSortDown ? b.nbConnect - a.nbConnect : a.nbConnect - b.nbConnect))
        break;
      case 'ldap_user':
        users.sort((a, b) => (isSortDown ? b.ldapuser - a.ldapuser : a.ldapuser - b.ldapuser))
        break;
      case 'created_date':
        users.sort((a, b) => (isSortDown ? b.createdDate - a.createdDate : a.createdDate - b.createdDate))
        break;
      default:
        users.sort((a, b) => (isSortDown ? b.id - a.id : a.id - b.id))
        break;
    }

    if (this.state.searchInput) {
      await this.setState({ searchResult: users })
    } else {
      await this.setState({ users })
    }
  }

  handleKeyDownSearch = e => {
    if (e.which === 27) {
      this.setState({ searchInput: '', showSearch: false, currentShowCount: 25, selectedUsers: [] })
    }
  }

  handleChange = (event) => {
    this.setState({ [event.target.id]: event.target.value })
  }

  componentDidMount() {
    this.fetchData()
  }

  render() {
    return (
      <div>
        {this.showDataBase()}

        {this.state.addModal ?
        <AddUser
        addUserModalSwitch = {this.addUserModalSwitch.bind(this)}
        updateCurrentUsersList = {this.updateCurrentUsersList.bind(this)}
        /> : ""}

        {this.state.editModal ?
        <EditUser
        id = {this.state.id}
        display_name = {decodeURI(this.state.display_name)}
        email = {this.state.email}
        role= {this.state.role}
        activated = {this.state.activated}
        verified = {this.state.verified}
        editUserModalOff = {this.editUserModalOff.bind(this)}
        updateCurrentUsersList = {this.updateCurrentUsersList.bind(this)}
        />
        :""}
      </div>
    )
  }
}
