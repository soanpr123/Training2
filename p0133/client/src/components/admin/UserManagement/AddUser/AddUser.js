import React, { Component } from 'react'
import { toast } from 'react-toastify';
import settings from '../../../../config'
import InputMask from 'react-input-mask';

export default class AddUser extends Component {
  constructor(props) {
    super(props)
    this.state = {
      display_name: '',
      email: '',
      password: '',
      phone: '',
      company: '',
      role: '',
    }
  }

  handleChange = (event) => {
    this.setState({ [event.target.id]: event.target.value })
  }

  sendAdd = (event) => {
    event.preventDefault()
    const { display_name, email, password, phone, role } = this.state;
    var enable = (display_name.trim().length > 0 && email.trim().length > 0 && password.trim().length > 0 && phone.length > 0 &&
      role.length > 0)
    if (enable) {
      let headers = new Headers({
        'Accept': 'application/json',
        'Content-type': 'application/json'
      })
      let send = {
        message: 'add user',
        token: sessionStorage.getItem('token'),
        first_name: 'default',
        last_name: 'default',
        display_name: encodeURI(display_name.trim()),
        email: email.trim(),
        password: password.trim(),
        phone: phone,
        personalId: '',
        role: role,
        activated: 1,
        verified: 1,
      }
      fetch(settings.defaultSettings.REACT_APP_API_URL + '/admin/addUser', { headers, method: 'POST', body: JSON.stringify(send) })
        .then(response => response.json())
        .then(responseJ => {
          if (responseJ.message === 'account') {
            toast.error("This email or username is already taken", {
              position: toast.POSITION.TOP_RIGHT,
              toastId: "taken-username"
            });
          } else if (responseJ.message === 'err add') {
            this.props.addUserModalSwitch()
            toast.error("Add user failed, server issue!", {
              position: toast.POSITION.TOP_RIGHT,
              toastId: "error-server"
            });
          } else {
            this.setState({ display_name: '', email: '', password: '', phone: '', personalId: '', role: ''})
            this.props.updateCurrentUsersList(responseJ.tab)
            this.props.addUserModalSwitch()
            toast.success("User added successfully", {
              position: toast.POSITION.TOP_RIGHT,
              toastId: "success-add"
            });
            global.socket.emit('fetch-total-statistics', { success: true })
          }
        })
        .catch(() => {
          this.setState({ display_name: '', email: '', password: '', phone: '', personalId: '', role: '' })
          this.props.addUserModalSwitch()
          toast.error("Add user failed, server issue!", {
            position: toast.POSITION.TOP_RIGHT,
            toastId: "error-server"
          });
        })
    } else {
      toast.error("Please fill all the fields", {
        position: toast.POSITION.TOP_RIGHT,
        toastId: "fill-all"
      });
    }
  }

  render() {
    return (
      <div className="admin-add-user-modal-container">
        <div className="admin-add-user-modal-wrapper">
          <div className="admin-add-user-modal-header">
            <h2 className="admin-add-user-modal-header-content"><i className="fa fa-user-plus" aria-hidden="true"></i> Add user</h2>
          </div>
          <div className="admin-add-user-modal-input-fields-container">
            
            <div className="form-group">
              <div className="relative-singup">
                <input className="form-control form-control-singup" type='text'
                  placeholder='Full name'
                  id='display_name' value={this.state.display_name} onChange={this.handleChange}
                  maxLength="50" required />
                <i className="fa fa-user-o" />
              </div>
            </div>

            <div className="form-group">
              <div className="relative-singup">
                <InputMask mask="(999) 999-9999" type='tel' name='phoneNumber' className="form-control form-control-singup" placeholder='(012) 345-6789'
                  maskChar={0}
                  id='phone' value={this.state.phone} onChange={this.handleChange}
                  required />
                <i className="fa fa-phone" />
              </div>
            </div>

            <div className="form-group">
              <div className="relative-singup">
                <input className="form-control form-control-singup" type='text'
                  placeholder='Email or Username'
                  id='email' value={this.state.email} onChange={this.handleChange}
                  required autoComplete="new-email" />
                <i className="fa fa-envelope" />
              </div>
            </div>

            <div className="form-group">
              <div className="relative-singup">
                <input type='password' name='password' className="form-control form-control-singup sign-up-password admin-password"
                  placeholder='Password'
                  id='password' value={this.state.password} onChange={this.handleChange}
                  required autoComplete="new-password" />
                <i className="fa fa-key" />
              </div>
            </div>

            <div className="form-group">
              <div className="relative-singup">
                <select id='role' value={this.state.role} className="admin-role-input" onChange={this.handleChange} required>
                  <option value='' >Select role</option>
                  <option value='users'>Users</option>
                  <option value='admin'>Admin</option>
                </select>
                <i className="fa fa-group" />
              </div>
            </div>
          </div>

          <div className="admin-add-user-modal-button">
            <div className="login-btn admin-submit">
              <button className="movebtn movebtnsu admin-submit-btn" onClick={this.sendAdd.bind(this)}><i className="fa fa-fw fa-paper-plane"></i> Submit
                </button>
            </div>
            <div className="login-btn admin-close">
              <button className="movebtn movebtnsu admin-close-btn" onClick={() => this.props.addUserModalSwitch()}><i className="fa fa-times" aria-hidden="true"></i> Cancel
                </button>
            </div>
          </div>

        </div>
      </div>  
    )
  }
}
