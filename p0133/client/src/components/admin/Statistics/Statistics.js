import React, { Component } from 'react'
import { toast } from 'react-toastify';
import settings from '../../../config'

export default class Statistics extends Component {
  constructor(props) {
    super(props)
    this.state = {
      totalUsers: 0,
      totalGroups: 0,
      totalCalls: 0,
      totalMessages: 0,
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
          fetch(settings.defaultSettings.REACT_APP_API_URL + '/admin/statistics', { headers, method: 'POST', body: JSON.stringify({ token: sessionStorage.getItem("token"), message: 'statistics' }) })
            .then(response => response.json())
            .then(responseJ => {
              this.setState({
                totalUsers: responseJ.totalUsers ? responseJ.totalUsers : 0,
                totalGroups: responseJ.totalGroups ? responseJ.totalGroups : 0,
                totalCalls: responseJ.totalCalls ? responseJ.totalCalls : 0,
                totalMessages: responseJ.totalMessages ? responseJ.totalMessages : 0,
              })
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

  componentDidMount() {
    this.fetchData()

    setInterval(() => {
      this.fetchData()
    }, 30000);

    global.socket.on('fetch-total-statistics', data => {
      if (data.success) {
        this.fetchData()
      }
    })
  }

  render() {
    const cards = [
      {title:"Total Users", count:this.state.totalUsers},
      {title:"Total Groups", count:this.state.totalGroups},
      {title:"Total Calls", count:this.state.totalCalls},
      {title:"Total Messages", count:this.state.totalMessages}
    ]
    return (
      <>
        {cards.map(card => (
        <div className="tile wide invoice">
          <div className="header">
            <div className="right">
              <div className="count">{card.count}</div>
            </div>
          </div>
          <div className="body">
            <div className="title">{card.title}</div>
          </div>
        </div>          
        ))}
      </>
    )
  }
}
