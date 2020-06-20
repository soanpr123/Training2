import React from 'react'
import './Admin.css'
import NavMenu from '../menu/NavMenu'
import { Redirect } from 'react-router-dom'
import { Tabs, Tab } from 'react-bootstrap'

import Statistics from './Statistics'
import UserManagement from './UserManagement'

class Admin extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      isBack: false
    }
  }

  back = (event) => {
    this.setState({ isBack: true })
  }

  isBack = () => {
    if (this.state.isBack) {
      return (<Redirect to={{ pathname: '/menu' }} />)
    }
  }

  render() {
    return (
      <div>
        <NavMenu window='ADMIN' />
        <div className='admin-container'>
          <Tabs defaultActiveKey="statistics" className="admin-menu">
            <Tab eventKey="statistics" title="DashBoard">
              <Statistics />
            </Tab>
            <Tab eventKey="user-management" title="User Management">
              <UserManagement />
            </Tab>
          </Tabs>
          {this.isBack()}
          <div className="user-actions-container-right">
            <button className='admin-user-actions-btn admin-user-actions-back-btn' type='button' onClick={this.back.bind(this)}>← Back</button>
          </div>
        </div>
        <h3 className='color_text' id='response'> </h3>
        <meta className='response' id='redirect' httpEquiv='refresh'></meta>
      </div>
    )
  }
}
export default Admin;
