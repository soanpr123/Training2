import React from 'react'
import InputMask from 'react-input-mask';
import { connect } from 'react-redux'
import fetchEditMyProfile from '../../actions/EditProfileActions'
import '../styles/css/EditMyProfile.css'
import axiosUploadAvatar from '../../actions/UploadAvatarActions'
import { Redirect } from 'react-router-dom'
import NavMenu from '../menu/NavMenu'
import defaultAvatar from '../styles/images/avatar-icon.png';
import { toast } from 'react-toastify';
import settings from '../../config';
import AvatarEditor from 'react-avatar-editor';
import { Button, Modal, ModalBody, ModalFooter } from 'reactstrap'
class EditMyProfile extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      first_name: this.props.first_name, last_name: this.props.last_name, display_name: this.props.display_name,
      phone: this.props.phone, company: this.props.company, bio: this.props.bio, selectedFile: null, image: null, isBack: false, avatar: null, editor: null, scaleValue: 1
    }
    this.el_response = React.createRef();
  }

  handleChange = (event) => {
    this.el_response.current.innerHTML = '';
    this.setState({ [event.target.id]: event.target.value })
  }

  handleSubmit = (event) => {
    event.preventDefault()
    this.el_response.current.innerHTML = '';
    const { first_name, last_name, phone, company, display_name, bio } = this.state
    const enable = phone.length > 0 && display_name.length > 0
    var myProfile = {
      first_name: encodeURI(first_name), last_name: encodeURI(last_name), phone, company,
      display_name: encodeURI(display_name), bio: encodeURI(bio)
    }
    if (enable) {
      this.props.dispatch(fetchEditMyProfile(myProfile, sessionStorage.getItem('token')))
    } else {
      this.el_response.current.innerHTML = 'Please, fill out fields!';
    }
  }

  showErrorFetchEditMyProfile = () => {
    if (this.props.error_edit !== '' && this.el_response.current.innerHTML === '') {
      this.el_response.current.innerHTML = this.props.error_edit;
    }
  }

  changePassword = () => {
    window.location.href = '/changePasswrd/' + sessionStorage.getItem('token');
  }

  changeEmail = () => {
    window.location.href = '/menu/changeEmail'
  }

  checkType = (event) => {
    let files = event.target.files
    var answer = true;
    const types = ['image/jpeg', 'image/png', 'image/jpg']
    for (let x = 0; x < files.length; x++) {
      if (types.every(type => files[x].type !== type)) {
        answer = false;
      }
    }
    return answer;
  }

  checkFileSize = (event) => {
    let files = event.target.files
    let size = 1500000
    var answer = true
    for (var x = 0; x < files.length; x++) {
      if (files[x].size > size) {
        answer = false;
      }
    }
    return answer;
  }

  onChangeHandler = (event) => {
    if (this.checkFileSize(event)) {
      if (this.checkType(event)) {
        this.setState({ selectedFile: event.target.files[0], avatar: event.target.files[0], loaded: 0 }, () => {
        })
      } else {
        toast.error("Unsupported extension ! Please use jpeg, jpg or png files", {
          position: toast.POSITION.TOP_RIGHT
        });
      }
    } else {
      toast.error("This image is too big!", {
        position: toast.POSITION.TOP_RIGHT
      });
    }
  }

  handleUpload = () => {
    const file = this.DataURLtoFile(this.state.selectedFile.name)
    if (this.state.selectedFile !== null) {
      const data = new FormData()
      data.append('file', file)
      data.append('token', sessionStorage.getItem('token'))
      this.props.dispatch(axiosUploadAvatar(data))
      this.setState({ selectedFile: null, editor: null, scaleValue: 1 })
    }
  }

  printError = (event) => {
    const { first_name, last_name, phone, display_name } = this.state
    const enable = display_name !== '' && phone !== '';
    if (!enable) {
      this.el_response.current.innerHTML = 'You must fill all the fields!';
    }
  }

  addDefaultSrc = (ev) => {
    ev.target.src = defaultAvatar;
  }

  componentWillReceiveProps(props) {
    this.setState({ first_name: props.first_name, last_name: props.last_name, phone: props.phone, company: props.company, display_name: props.display_name, bio: props.bio })
  }

  // crop avatar
  setEditorRef = editor => this.setState({ editor })

  onScaleChange = (scaleChangeEvent) => {
    const scaleValue = scaleChangeEvent.target.value
    this.setState({ scaleValue })
  }

  DataURLtoFile = (filename) => {
    const { editor } = this.state
    let arr, mime, bstr, n, u8arr
    if (editor !== null) {
      const url = editor.getImageScaledToCanvas().toDataURL()
      arr = url.split(',')
      mime = arr[0].match(/:(.*?);/)[1]
      bstr = atob(arr[1])
      n = bstr.length
      u8arr = new Uint8Array(n)
      while (n--) {
        u8arr[n] = bstr.charCodeAt(n)
      }
    }
    return new File([u8arr], filename, { type: mime });
  }

  onCancelClick = () => {
    this.setState({ selectedFile: null })
  }

  back = () => {
    this.setState({ isBack: true })
  }

  isBack = () => {
    if (this.state.isBack) {
      return (<Redirect to={{ pathname: '/menu' }} />)
    }
  }

  render() {
    return (
      <div className='flex'>
        {this.isBack()}
        <NavMenu window='EDIT MY PROFILE' />
        <div className="form-profile">
          <form className="form-horizontal signup" onSubmit={this.handleSubmit.bind(this)} method='post'>
            <div className="form-wrap" style={{ position: 'relative' }}>
              <h2>Edit my profile</h2>
              <div className="profile-container">
                <div className="profile-left">
                  <div className="avatar-container">
                    <img className="avatar-img" id='image' src={`${settings.defaultSettings.REACT_APP_API_URL}/avatars/${this.props.avatar}`} onError={this.addDefaultSrc} alt='' />
                  </div>
                  <div>Change image:</div>
                  <div className="change-img-container">
                    <div className="img-upload-container">
                      <div className="img-upload-file-display">
                        <div className="img-upload-file-name">{this.state.selectedFile ? this.state.selectedFile.name : "No file chosen"}</div>
                        <p className="img-upload-btn">Upload</p>
                      </div>
                      <input className="upload-input" type="file" name="file" accept='.jpg,.png,.jpeg' onChange={this.onChangeHandler.bind(this)} />
                      <Modal isOpen={this.state.selectedFile != null} centered={true}>
                        <ModalBody>
                          <AvatarEditor image={this.state.avatar} border={50} scale={this.state.scaleValue} rotate={0} ref={this.setEditorRef} className="crop-avatar" />
                          <input style={{ width: '100%' }} type="range" value={this.state.scaleValue} name="points" min="1" max="2" step=".01" onChange={this.onScaleChange} />
                        </ModalBody>
                        <ModalFooter>
                          <div className="d-flex">
                            <div className="ml-auto">
                              <Button color="danger btnfont mr-2" onClick={this.handleUpload}>Ok</Button>
                              <Button color="secondary btnwhite btnfont" onClick={this.onCancelClick}>Cancel</Button>
                            </div>
                          </div>
                        </ModalFooter>
                      </Modal>
                    </div>
                  </div>
                  <div className="account-action-container">
                    <div className="account-action" onClick={this.changeEmail.bind(this)}>
                      <span className="account-action-label" >Account:</span>
                      <span className="account-action-content account-action-content-email">{this.props.email}</span>
                      <i className="fa fa-angle-right account-action-icon" />
                    </div>
                    <div className="account-action" onClick={this.changePassword.bind(this)}>
                      <span className="account-action-label">Password:</span>
                      <span className="account-action-content">••••••••••••••</span>
                      <i className="fa fa-angle-right account-action-icon" />
                    </div>
                  </div>
                </div>
                <div className="profile-right">
                  <div className="form-group-profile">
                    <div className="relative">
                      <div className="profile-field-label">Display Name:</div>
                      <input className="form-control form-control-profile" type="text" id='display_name' value={this.state.display_name} onChange={this.handleChange.bind(this)} maxLength="50" required />
                    </div>
                  </div>
                  <div className="form-group-profile">
                    <div className="relative">
                      <div className="profile-field-label">Phone:</div>
                      <InputMask mask="(999) 999-9999" maskChar={0} type='tel' className="form-control form-control-profile" id='phone' value={this.state.phone} onChange={this.handleChange.bind(this)} required />
                    </div>
                  </div>
                  <div className="form-group-profile">
                    <div className="relative">
                      <div className="profile-field-label">Department:</div>
                      <input className="form-control form-control-profile" type='text' id='company' value={this.state.company || ''} onChange={this.handleChange.bind(this)} maxLength="50" />
                    </div>
                  </div>
                  <div className="form-group-profile">
                    <div className="relative">
                      <div className="profile-field-label">Bio:</div>
                      <textarea className="form-control form-control-profile" rows={4} style={{ resize: 'none' }} id='bio' value={this.state.bio} onChange={this.handleChange.bind(this)} />
                    </div>
                  </div>
                  <div className="form-group-profile action-btn-container">
                    <button className="movebtn movebtnsu save-btn" type="Submit" onClick={this.printError.bind(this)}>Save</button>
                    <button className="movebtn movebtnsu back-btn" type="button" onClick={this.back.bind(this)}>← Back</button>
                  </div>
                  <p className='white_text_edit' ref={this.el_response}></p>
                  {this.showErrorFetchEditMyProfile()}
                </div>
              </div>
            </div>
          </form>
        </div>
      </div>
    )
  }
}

const mapStateToProps = (state) => {
  return {
    first_name: decodeURI(state.myProfileReducer.first_name),
    last_name: decodeURI(state.myProfileReducer.last_name),
    display_name: decodeURI(state.myProfileReducer.display_name),
    phone: state.myProfileReducer.phone,
    email: state.myProfileReducer.email,
    company: state.myProfileReducer.company,
    bio: decodeURI(state.myProfileReducer.bio),
    error_edit: state.myProfileReducer.error_edit,
    avatar: state.myProfileReducer.avatar,
    status: state.myProfileReducer.status
  }
}

export default connect(mapStateToProps)(EditMyProfile)
