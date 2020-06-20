import React, { Component } from 'react'
import { Modal, Button } from 'react-bootstrap'

export default class DeviceWarning extends Component {
  constructor(props) {
    super(props)
    this.state = {
    }
  }

  checkiOS = () => {
   let iDevices = [
     'iPad Simulator',
     'iPhone Simulator',
     'iPod Simulator',
     'iPad',
     'iPhone',
     'iPod',
     'Mac'
   ];
   if (!!navigator.platform) {
     while (iDevices.length) {
       if (navigator.platform === iDevices.pop()){ return true; }
     }
   }
   return false;
  }

  componentDidMount = () => {
    if (this.checkiOS()) {
			this.props.switchDeviceWarning(true)
		}
		
  }

  render() {
    return (
        <Modal show={this.props.isShowMobileWarning} onHide={()=>this.props.switchDeviceWarning(false)}>
        <Modal.Header closeButton>
          <Modal.Title>Device compatibility</Modal.Title>
        </Modal.Header>
        <Modal.Body>
          <p>Video calling is not supported by these browsers: Chrome on iOS, Opera on iOS, Firefox on iOS, Safari version lower than v12.0.</p>
          <p>Please consider using an Android OS or Windows OS device for better experience.</p>
        </Modal.Body>
        <Modal.Footer>
          <Button variant="secondary" onClick={() =>this.props.switchDeviceWarning(false)}>
            Close
          </Button>
        </Modal.Footer>
      </Modal>
    )
  }
}
