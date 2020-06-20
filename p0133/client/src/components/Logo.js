import React from 'react';
import voispy from './styles/images/uoi-logo-white.png';
import './styles/css/Logo.css';
import { Redirect } from 'react-router-dom'

class Logo extends React.Component {
    constructor(props) {
      super(props)
      this.state = {
        redirect: false
      }
    }

    componentDidMount() {
      this.id = setTimeout(() => this.setState({ redirect: true }), 2000)
    }
    render() {
      return(
        <div>
          <div className="back">
              <img className="logovoispy" src={voispy} alt=' ' />
          </div>
          { this.state.redirect ?
            <Redirect to="/login" />
            : ""
          }
        </div>
      );
    }
}

export default Logo
