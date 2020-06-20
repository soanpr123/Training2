import React, { Component } from 'react'
import { toast } from 'react-toastify';
import settings from '../../../../config'

export default class EditUser extends Component {
  constructor(props) {
    super(props)
    this.state = {
      id: '',
      display_name: '',
      email: '',
      role: '',
      activated: '',
      verified: ''
    }
  }

  handleChange = (event) => {
    this.setState({ [event.target.id]: event.target.value })
  }

  sendModifications = (id, event) => {
    event.preventDefault()

    var { display_name, email, role, activated, verified } = this.state;

    var enable = (display_name.trim().length > 0 && email.trim().length > 0)
    if (enable) {
      let headers = new Headers({
        'Accept': 'application/json',
        'Content-type': 'application/json'
      })
      let send = {
        id, message: 'edit user',
        token: sessionStorage.getItem('token'),
        first_name: 'default',
        last_name: 'default',
        display_name: encodeURI(display_name),
        email: email,
        role: role,
        activated: activated,
        verified: verified
      }
      fetch(settings.defaultSettings.REACT_APP_API_URL + '/admin/editUsers', { headers, method: 'PUT', body: JSON.stringify(send) })
        .then(response => response.json())
        .then(responseJ => {
          this.setState({ id: '', display_name: '', email: '', role: '', activated: '', verified: '' })
          if (responseJ.message === "err edit") {
            this.props.editUserModalOff()
            toast.error("User edited failed, server issue", {
              position: toast.POSITION.TOP_RIGHT,
              toastId: "failed-edit"
            });
          } else {
            this.props.editUserModalOff()
            this.props.updateCurrentUsersList(responseJ.tab)
            toast.success("User edited successfully", {
              position: toast.POSITION.TOP_RIGHT,
              toastId: "success-edit"
            });
          }
        })
        .catch(() => {
          this.setState({ id: '', display_name: '', email: '', role: '', activated: '', verified: '' })
          this.props.editUserModalOff()
          toast.error("User edited failed, server issue", {
            position: toast.POSITION.TOP_RIGHT,
            toastId: "failed-edit"
          });
        })
    } else {
      toast.error("Please fill all the fields", {
        position: toast.POSITION.TOP_RIGHT,
        toastId: "fill-all"
      });
    }
  }

  componentDidMount = () => {
    this.setState({...this.props})
  }

  render() {
    return (
      <div className="admin-add-user-modal-container">
        <div className="admin-add-user-modal-wrapper">
          <div className="admin-add-user-modal-header">
            <h2 className="admin-add-user-modal-header-content"><i className="fa fa-pencil-square-o" aria-hidden="true"></i> Edit user</h2>
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
                <input className="form-control form-control-singup" type='text'
                  placeholder='Email or Username'
                  id='email' value={this.state.email} onChange={this.handleChange}
                  required autoComplete="off" />
                <i className="fa fa-envelope" />
              </div>
            </div>

            <div className="form-group">
              <div className="relative-singup">
                <select id='role' value={this.state.role} className="admin-role-input" onChange={this.handleChange} required>
                  <option value='users'>Users</option>
                  <option value='admin'>Admin</option>
                </select>
                <i className="fa fa-group" />
              </div>
            </div>

            <div className="form-group">
              <div className="relative-singup">
                <select id='activated' value={this.state.activated} className="admin-role-input" onChange={this.handleChange} required>
                  <option value={0}>0 (Dectivated)</option>
                  <option value={1}>1 (Activated)</option>
                </select>
                <i className="fa fa-check-circle-o" />
              </div>
            </div>
            
            <div className="form-group">
              <div className="relative-singup">
                <select id='verified' value={this.state.verified} className="admin-role-input" onChange={this.handleChange} required>
                  <option value={0}>0 (Not Verified)</option>
                  <option value={1}>1 (Verified)</option>
                </select>
                <i className="fa fa-check-square" />
              </div>
            </div>
          </div>

          <div className="admin-add-user-modal-button">
            <div className="login-btn admin-submit">
              <button className="movebtn movebtnsu admin-submit-btn" onClick={this.sendModifications.bind(this, this.state.id)}><i className="fa fa-fw fa-paper-plane"></i> Submit
                </button>
            </div>
            <div className="login-btn admin-close">
              <button className="movebtn movebtnsu admin-close-btn" onClick={() => this.props.editUserModalOff()}><i className="fa fa-times" aria-hidden="true"></i> Cancel
                </button>
            </div>
          </div>

        </div>
      </div>
    )
  }
}
