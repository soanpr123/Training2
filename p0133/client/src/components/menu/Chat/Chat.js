//Libiraries
import React, { Fragment } from 'react';
import moment from 'moment';
import Notification from 'react-web-notification';
import { toast } from 'react-toastify';
import ss from 'socket.io-stream'
import { connect } from 'react-redux';
import { Link } from 'react-router-dom';
import { Picker } from 'emoji-mart'
import { Modal, Button } from 'react-bootstrap'
//Actions
import fetchAcceptInvitation from '../../../actions/AcceptInvitationActions';
import fetchRefuseInvitation from '../../../actions/RefuseInvitationActions';
import fetchUpdateFriendsList from '../../../actions/UpdateFriendsActions';
import handlePage from '../../../actions/handlePageActions'

//Components
import SearchFriend from './SearchFriend';
import InfoFriend from './InfoFriend'

//Others
import settings from '../../../config';
import '../../styles/css/Chat.css';
import defaultGroupAvatar from '../../styles/images/group-default-avatar.png'
import 'emoji-mart/css/emoji-mart.css'
import search from '../../styles/images/search.png'
import send from '../../styles/images/send.png'
import cancel from '../../styles/images/cancel.svg'

class Chat extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      selectedFile: null, vueHisto: true, historic: [], room_Id: '', nameConv: '', nothing: '', nameConvGroup: '', name: '', GroupNameAfter: '',
      GroupNameAfterId: '', NameGroup: [], NotificationGroup: [], NotificationPrivate: [], GroupListId: [], tempMsg: [], maxRenderMsg: 10, currentMsgRender: 0,
      GroupList: [], socket: null, id: 0, idFriend: 0, isFullHeight: false, groupNameNotEmpty: false, uploadFinished: false, isEmoji: false,
      GroupConv: false, member: true, change_group_name: false, isOption: false, isConvOne: false, infoPress: false, isShowConv: false, isNext: false,
      isAdd: true, isFriendListGroup: false, isInfos: false, isSearch: false, isFriendTab: true, isChat: false, isFriendListGroupChat: false,
      isGroupChat: false, isInvitationTab: false, isGroupTab: false, countMsg: false, isShowNotifyBrowser: true, title: "U-Oi Communication", options: {}, notify_offline: '', notify_group_offline: '',
      msg_input_focused: false, clearTypingTimeoutId: "", processing_upload: [], searchInput: '', searchInputRegex: '', showImg: false
    }
    this.renderChatMessage = this.renderChatMessage.bind(this);
    this.onBlurHandler = this.onBlurHandler.bind(this);
    this.onFocusHandler = this.onFocusHandler.bind(this);

    this.input_send_m = React.createRef();
    this.input_file = React.createRef();
  }

  showFriend = () => {
    this.setState({ isFriendTab: true, isInvitationTab: false, isGroupTab: false, isSearch: false })
  }

  showGroup = () => {
    this.setState({ isFriendTab: false, isInvitationTab: false, isGroupTab: true, isSearch: false })
  }

  showImg = () => {
    this.setState({ showImg: true })
  }

  handleShowImg = () => {
    this.setState({ showImg: false })
  }
  isInfoFriend = (id) => { //change information friend state
    if (this.state.isInfoFriend) {
      this.setState({ isInfoFriend: false, idFriend: 0 })
    } else {
      this.setState({ isInfoFriend: true, idFriend: id })
    }
  }

  infoFriend = () => { //render information friend component
    if (this.state.isInfoFriend) {
      return (
        <InfoFriend
          idFriend={this.state.idFriend}
          close={this.isInfoFriend.bind(this, 0)}
          call={this.props.call}
        />
      )
    }
  }

  addDefaultSrc(ev) { //default avatar src
    ev.target.src = `${settings.defaultSettings.REACT_APP_API_URL}/avatars/Anonyme.jpeg`;
  }

  friends_List = () => { //render friend list
    if (this.state.isFriendTab) {
      if (this.props.friends_list.length > 0) {
        if (this.state.isSearch !== true) {
          return (
            <div className='zone'>
              {
                !this.state.searchInputRegex ?
                  this.props.friends_list.map((friend, index) => {
                    return (
                      <Fragment key={index}>
                        <div className={this.state.id === friend.id ? 'friends row selectedChat' : 'friends row'} key={friend.id}>
                          <div className="status-name-friend" onClick={this.showChat.bind(this, friend)}>
                            <img className='imgUser' src={`${settings.defaultSettings.REACT_APP_API_URL}/avatars/${friend.avatars}`} onError={this.addDefaultSrc} alt="" />
                            <div className="friend-details-container">
                              <div className="friend-details-name-status">
                                {this.showStatusFriends(friend)}
                                <p className="friend-name">{decodeURI(friend.display_name)}</p>
                                {this.state.notify_offline.search(friend.id) !== -1 ? (<i className='fa fa-exclamation-circle c-r' id={"u_" + friend.id}></i>) : ""}
                              </div>
                            </div>
                          </div>
                          <div className={this.state.id === friend.id ? "friends-icons d-block" : "friends-icons"}>
                            <i className="fa fa-video-camera video-call-icon" onClick={() => this.props.call(friend.id, friend.status, false)}></i>
                            <i className="fa fa-info-circle info-circle-icon" onClick={this.isInfoFriend.bind(this, friend.id)}></i>
                          </div>
                        </div>
                      </Fragment>
                    )
                  }) : this.props.friends_list.filter(friend => new RegExp(this.state.searchInputRegex, 'i').test(decodeURI(friend.display_name).trim())).map((friend, index) => {
                    return (
                      <Fragment key={index}>
                        <div className={this.state.id === friend.id ? 'friends row selectedChat' : 'friends row'} key={friend.id}>
                          <div className="status-name-friend" onClick={this.showChat.bind(this, friend)}>
                            <img className='imgUser' src={`${settings.defaultSettings.REACT_APP_API_URL}/avatars/${friend.avatars}`} onError={this.addDefaultSrc} alt="" />
                            <div className="friend-details-container">
                              <div className="friend-details-name-status">
                                {this.showStatusFriends(friend)}
                                <p className="friend-name" >{decodeURI(friend.display_name)}</p>
                                {this.state.notify_offline.search(friend.id) !== -1 ? (<i className='fa fa-exclamation-circle c-r' id={"u_" + friend.id}></i>) : ""}
                              </div>
                            </div>
                          </div>
                          <div className={this.state.id === friend.id ? "friends-icons d-block" : "friends-icons"}>
                            <i className="fa fa-video-camera video-call-icon" onClick={() => this.props.call(friend.id, friend.status, false)}></i>
                            <i className="fa fa-info-circle info-circle-icon" onClick={this.isInfoFriend.bind(this, friend.id)}></i>
                          </div>
                        </div>
                      </Fragment>
                    )
                  })
              }
            </div>
          )
        } else {
          return null
        }
      } else {
        return null
      }
    } else {
      return null
    }
  }

  showStatusFriends = (friend) => { //handle display status friend
    if (friend.status === 'Busy') {
      return (
        <input className='red_point' attribut='true' readOnly="readonly"></input>
      )
    } else if (friend.status === 'Online') {
      return (
        <input className='green_point' attribut='true' readOnly="readonly"></input>
      )
    } else if (friend.status === 'Away') {
      return (
        <input className='orange_point' attribut='true' readOnly="readonly"></input>
      )
    } else if (friend.status === 'Offline') {
      return (
        <input className='white_point' attribut='true' readOnly="readonly"></input>
      )
    }
  }

  showStatusGroup = (groupMembers) => { //handle display status group
    let filterOnline = groupMembers.filter(val => val[1] === "Online").map(val => val[0])
    if (filterOnline.length > 0) {
      return (
        <input className='green_point' attribut='true' readOnly="readonly"></input>
      )
    } else {
      return (
        <input className='white_point' attribut='true' readOnly="readonly"></input>
      )
    }
  }
  //----------------------------

  showChat = (data) => { //open chat box 1-1
    this.setState({ isChat: true, isChatWithUserRole: false, id: data.id, isConvOne: false, isInfoConvGroup: false, infoPress: false, historic: [], vueHisto: true, maxRenderMsg: 10, currentMsgRender: 0, tempMsg: [], isGroupChat: false, isAdd: false, isOption: false, selectedFile: null, isEmoji: false },
      () => {
        let typing = document.getElementById('msg_typing')
        if (typing) {
          typing.innerHTML = ''
        }
        let removeNotifyOffline = "";
        let currentNotifyOffline = "";
        if (this.state.notify_offline) {
          currentNotifyOffline = this.state.notify_offline.split(":");
          removeNotifyOffline = currentNotifyOffline.filter((val) => (val !== this.state.id.toString())).join(":");
          this.setState({ notify_offline: removeNotifyOffline, isShowNotifyBrowser: true, options: {}, countMsg: false })
        }
        console.log("change")
        global.socket.emit('change_room', { token: sessionStorage.getItem('token'), idFriend: [data.id], display_name: this.props.display_name });
        if (document.getElementById('message')) {
          document.getElementById('message').innerHTML = "";
        }
        if (this.input_send_m && this.input_send_m.current) {
          this.input_send_m.current.value = '';
        }
      }
    )
  }

  scrollToBottom = () => { //scroll to bottom chatbox
    let scroll = document.getElementById("size_message");
    if (scroll) {
      scroll.scrollTop = scroll.scrollHeight;
    }
  };

  bytesToSize = (bytes, decimals = 2) => { //display file size (send file)
    if (bytes === 0) return '0 Bytes';
    const k = 1024;
    const dm = decimals < 0 ? 0 : decimals;
    const sizes = ['Bytes', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'];
    const i = Math.floor(Math.log(bytes) / Math.log(k));
    return parseFloat((bytes / Math.pow(k, i)).toFixed(dm)) + ' ' + sizes[i];
  }

  toggleEmoji = () => { //toggle emoji picker
    this.setState({ isEmoji: !this.state.isEmoji })
  }

  chatFriends = () => { //render chatbox
    const { friends_list } = this.props;
    if (this.state.isChat && friends_list.length > 0) {
      if (JSON.stringify(friends_list[friends_list.map(index => index.id).indexOf(this.state.id)]) !== undefined) {
        const heightBody = window.innerHeight - 60 - 50;
        const display_name = friends_list[friends_list.map(index => index.id).indexOf(this.state.id)].display_name;
        const avatars = friends_list[friends_list.map(index => index.id).indexOf(this.state.id)].avatars;
        const friendId = friends_list[friends_list.map(index => index.id).indexOf(this.state.id)].id;
        const status = friends_list[friends_list.map(index => index.id).indexOf(this.state.id)].status;
        const email = friends_list[friends_list.map(index => index.id).indexOf(this.state.id)].email;
        let chatHeight;
        let size_messageHeight;
        chatHeight = 500;
        if (this.state.selectedFile) {
          size_messageHeight = chatHeight - 135 - 60;
        } else {
          size_messageHeight = chatHeight - 85 - 60;
        }
        if (this.state.room_Id) {
          var roomIndex = this.state.processing_upload.map(e => e.roomId).indexOf(this.state.room_Id);
          var processing_upload = this.state.processing_upload[roomIndex];
        }
        return (
          <div className={
            this.props.videoPage ? 'chat chat-on-call'
              : this.state.isFullHeight ? 'chat chat-full-height'
                : 'chat chat-no-call'
          } style={{ minHeight: chatHeight }}>
            <div className='info row'>
              <div className=" live-chat">
                <img className='imgUserChat mr-3' src={`${settings.defaultSettings.REACT_APP_API_URL}/avatars/${avatars}`} onError={this.addDefaultSrc} onClick={this.showImg.bind(this)} alt="" />
                <Modal show={this.state.showImg} size="sm" onHide={this.handleShowImg.bind(this)}>
                  <Modal.Header closeButton>
                  </Modal.Header>
                  <Modal.Body>
                    <img className='imgUserChatFull' src={`${settings.defaultSettings.REACT_APP_API_URL}/avatars/${avatars}`} onError={this.addDefaultSrc} alt="" />
                  </Modal.Body>
                </Modal>
                <div className="display-user">
                  <p className="display-name-chat" onClick={this.isInfoFriend.bind(this, friendId)}>{decodeURI(display_name)}</p>
                </div>
              </div>
              <div className=" list-actions-chat">
                <i className="fa fa-video-camera video-call-icon" onClick={() => this.props.call(friendId, status, false)}></i>
                {!this.props.videoPage
                  ? <i className={this.state.isFullHeight ? "fa  fa-window-restore resize-icon" : "fa fa-window-maximize resize-icon"} onClick={() => this.setFullHeight()}></i>
                  : ""}
                <img className="cancel-icon" src={cancel} onClick={this.closeChat.bind(this, "", this.state.room_Id)} />
              </div>
            </div>
            <div className={
              this.state.isFullHeight && !this.state.selectedFile ? 'size_message size_message-full-height' :
                this.state.isFullHeight && this.state.selectedFile ? 'size_message size_message-full-height size_message-full-height-attach-file'
                  : 'size_message'
            } id="size_message" style={{ height: size_messageHeight, minHeight: size_messageHeight, maxHeight: size_messageHeight }}>
              <div className='scroll'>
                {
                  (this.state.currentMsgRender < this.state.tempMsg.length) ?
                    <button className="older-messages" onClick={this.getOlderMessages} type="button">↑ Get older messages</button>
                    : ''
                }
                {this.historic()}
                <ul className='message' id='message' ></ul>
                <ul className='typing' id='msg_typing'></ul>
                {processing_upload ?
                  <div className='sending-file-container' id={processing_upload.roomId}>
                    <div className='file-loader-container'>
                      <div className="file-loader">
                      </div>
                      <div className="file-loader-details">
                        <div className="file-loader-title">Sending file...</div>
                        <div className="file-loader-filename">{processing_upload.filename}</div>
                        <div className="progress-wrap progress" >
                          <div className="progress-bar" style={{ width: `${processing_upload.loaded}%` }}></div>
                        </div>
                      </div>
                      {this.scrollToBottom()}
                    </div>
                  </div>
                  : ""
                }

              </div>
            </div>
            <div className='convArea'>
              {this.chargeFile()}
            </div>
          </div>
        )
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  handleDragOver = e => {
    e.stopPropagation();
    e.preventDefault();
    e.dataTransfer.dropEffect = 'copy';
  }

  handleDrop = async e => {
    e.stopPropagation();
    e.preventDefault();
    // var files = e.dataTransfer.files; // Array of all files
    await this.setState({ selectedFile: e.dataTransfer.files[0] })
  }

  chargeFile = () => { //chatbox area of text input, file input
    if (this.state.selectedFile) {
      var fileExtension = this.state.selectedFile.name.split('.').pop()
    }
    const chatForm = this.state.selectedFile ? (
      <Fragment>
        <div className='text-box-area'>
          <div className="upload-file-container">
            <div className="upload-file">
              <i className="upload-file-icon fa fa-file-text-o"></i>
              <div className="upload-file-details">
                <div className="upload-file-name">{this.state.selectedFile.name}</div>
                <div className="upload-file-status">{`.${fileExtension}`} {`(${this.bytesToSize(this.state.selectedFile.size)})`}</div>
              </div>
              <i className="cancel-upload-icon fa fa-times-circle" onClick={this.cancelSendFile.bind(this)}></i>
            </div>
          </div>
          <div className="textarea-container"
            onDragOver={this.handleDragOver} onDrop={this.handleDrop}>
            <textarea ref={this.input_send_m}
              id='send_m'
              className='txt_to_chat'
              onFocus={this.onFocusHandler}
              onBlur={this.onBlurHandler}
              onKeyPress={(event) => this.handleKeyPress(event)}
              onKeyDown={(event) => this.handleKeyDownCloseChat(event)}
              placeholder='Enter chat message here...'
              defaultValue={document.getElementById('send_m').value}></textarea>
          </div>
        </div>
        {this.scrollToBottom()}
      </Fragment>
    ) : (
        <div className='text-box-area'>
          <div className="textarea-container"
            onDragOver={this.handleDragOver}
            onDrop={this.handleDrop}>
            <textarea ref={this.input_send_m}
              id='send_m'
              className='txt_to_chat'
              onFocus={this.onFocusHandler}
              onBlur={this.onBlurHandler}
              onKeyPress={(event) => this.handleKeyPress(event)}
              onKeyDown={(event) => this.handleKeyDownCloseChat(event)}
              placeholder='Enter chat message here...' ></textarea>
          </div>
        </div>
      );
    return (
      <div className="form-chat-bottom">
        {chatForm}
        <div className="form-action-bottom">
          <div className="form-action-bottom-left">
            <i className="action-icon fa fa-smile-o" onClick={this.toggleEmoji}></i>
            {/* <i className="action-icon fa fa-location-arrow"></i> */}
            <i className="action-icon fa fa-paperclip" >
              <input ref={this.input_file} className="file-input" type="file" name="file" accept='.xlsx,.xls,.doc,.docx,.ppt,.pptx,.txt,.pdf,.zip,.csv,image/*, video/*, audio/*' onClick={this.state.showChargeFile} onChange={this.onChangeHandler.bind(this)} />
            </i>
          </div>
          <div className="form-action-bottom-right">
            <img className="action-icon send-icon" src={send} onClick={(event) => this.send_message(event)} />
          </div>
        </div>
      </div>
    )
  }

  cancelSendFile = () => { //cancel attaching file
    if (this.input_file && this.input_file.current) {
      this.input_file.current.value = "";
    }

    this.setState({ selectedFile: null }, () => {
      if (this.input_send_m && this.input_send_m.current) {
        this.input_send_m.current.value = this.input_send_m.current.value;
      }
    });
  }

  onChangeHandler = async (event) => { //handler for changing file input
    if (this.state.room_Id) {
      var roomIndex = this.state.processing_upload.map(e => e.roomId).indexOf(this.state.room_Id);
      var processing_upload = this.state.processing_upload[roomIndex];
    }
    if (!processing_upload) {
      if (this.checkFileSize(event)) {
        await this.setState({
          selectedFile: event.target.files[0],
          file: event.target.files[0]
        })
        if (this.input_send_m && this.input_send_m.current) {
          this.input_send_m.current.focus();
        }
      } else {
        if (this.input_send_m && this.input_send_m.current) {
          this.input_send_m.current.focus();
        }
      }
    } else {
      toast.warn("Another file is uploading! Please wait", {
        position: toast.POSITION.TOP_RIGHT,
        toastId: "uploadingFile"
      });
    }
  }

  sendFile = async (data) => { //render sendFile message
    const time = Date.now()
    const id = this.props.id
    await global.socket.emit('send_file', {
      room: data.roomId,
      name: data.name,
      size: data.size,
      filename: data.filename,
      time: time
    });
    const indexRemove = this.state.processing_upload.map(e => e.roomId).indexOf(data.roomId);
    let processing_upload = this.state.processing_upload;
    processing_upload[indexRemove] = { filename: "", loaded: null, roomId: -1, fileToSend: "", size: 0 }
    await this.setState({
      processing_upload: processing_upload
    })
    //console.log(data)
    if (this.state.isChat) {
      if (this.state.id === data.friendId) {
        //console.log(this.state.room_Id)
        //console.log( data.roomId)
        var msg_send = document.createElement('li');
        const file = `<p class='send_msg'><span class="msg-download-file" ><i class="fa fa-download" aria-hidden="true"></i> ${data.name} (${this.bytesToSize(data.size)}) </span></p>`;
        msg_send.id = time
        const result = this.renderChatMessage({ name: this.props.display_name, avatar: this.props.avatar, file, id: id, time: time });
        msg_send.innerHTML = result;
        let download = msg_send.getElementsByTagName("span")[0];
        const fileDisplayName = data.name;
        download.addEventListener('click', function (e) {
          global.socket.emit('download', { name: fileDisplayName, filename: data.filename });
        });

        let deleteMess = msg_send.getElementsByClassName("delete-message")[0];
        deleteMess.addEventListener('click', (e) => {
          global.socket.emit('delete_message', { time, id, filename: data.filename, isFile: true });
        })

        document.getElementById('message').appendChild(msg_send);
        this.scrollToBottom();
        if (this.input_file && this.input_file.current) {
          this.input_file.current.value = "";
        }
      }
    } else {
      if (this.state.room_Id === data.roomId) {
        //console.log(this.state.room_Id)
        //console.log( data.roomId)
        var msg_send = document.createElement('li');
        const file = `<p class='send_msg'><span class="msg-download-file" ><i class="fa fa-download" aria-hidden="true"></i> ${data.name} (${this.bytesToSize(data.size)}) </span></p>`;
        msg_send.id = time;
        const result = this.renderChatMessage({ name: this.props.display_name, avatar: this.props.avatar, file, id: this.props.id, time: time });
        msg_send.innerHTML = result;
        let download = msg_send.getElementsByTagName("span")[0];
        const fileDisplayName = data.name;
        download.addEventListener('click', function (e) {
          global.socket.emit('download', { name: fileDisplayName, filename: data.filename });
        });

        let deleteMess = msg_send.getElementsByClassName("delete-message")[0];
        deleteMess.addEventListener('click', (e) => {
          global.socket.emit('delete_message', { time, id, filename: data.filename, isFile: true });
        })

        document.getElementById('message').appendChild(msg_send);
        this.scrollToBottom();
        if (this.input_file && this.input_file.current) {
          this.input_file.current.value = "";
        }
      }
    }
  }

  processSendFile = async () => { //upload and send file
    //console.log("send me")
    if (this.state.room_Id) {
      var roomIndex = this.state.processing_upload.map(e => e.roomId).indexOf(this.state.room_Id)
    }
    const date = Date.now()
    const file = this.state.selectedFile
    const roomId = this.state.processing_upload[roomIndex].roomId
    const filename = this.props.id + '_' + date.toString() + '_' + file.name
    await this.setState({ selectedFile: null })
    const stream = ss.createStream()
    const blobStream = ss.createBlobReadStream(file)
    let size = 0
    blobStream.on('data', function (chunk) {
      size += chunk.length;
      // //console.log('Upload : ' + Math.floor(size / file.size * 100))
      if (roomId) {
        if (roomIndex >= 0) {
          let processing_upload = this.state.processing_upload;
          processing_upload[roomIndex].loaded = Math.floor(size / file.size * 100);
          processing_upload[roomIndex].fileToSend = filename;
          this.setState({
            processing_upload: processing_upload,
          });
        }
      }
    }.bind(this));
    await ss(global.socket).emit('upload', stream, { name: filename });
    await blobStream.pipe(stream);
    blobStream.on('end', (d) => {
      // if (this.state.processing_upload[roomIndex].fileToSend) {
      global.socket.emit('file_upload_success', {
        friendId: this.state.id,
        roomId: roomId,
        filename: filename,
        name: file.name,
        size: file.size,
      })
      // }
      // if (this.state.room_Id !== roomId) {
      // global.socket.emit('save_file_upload_success', {
      //   roomId: roomId,
      //   filename: filename,
      //   name: file.name,
      //   size: file.size,
      //   message: '',
      //   time: date
      // })
      // }
    });
  }

  maFonction = (name) => { //download file
    global.socket.emit('download', { name: name });
  }

  checkFileSize = (event) => { //check file size before attaching
    let files = event.target.files
    let size = settings.commonConfig.FileUploadSizeLimit
    let err = "";
    for (var x = 0; x < files.length; x++) {
      if (files[x].size > size) {
        err += files[x].type + ' is too large, please pick a smaller file\n';
      }
    }
    if (err !== '') {
      event.target.value = null
      //console.log(err)
      toast.error(err, {
        position: toast.POSITION.TOP_RIGHT
      });
      return false
    }
    return true;
  }

  closeChat = (name, roomId) => { //close chatbox 1-1
    this.setState({ isOption: false, isAdd: false, isChat: false, id: 0, isNext: false, isConvOne: false, infoPress: false, vueHisto: true, room_Id: '', maxRenderMsg: 10, currentMsgRender: 0, tempMsg: '', isEmoji: false, isChatWithUserRole: false });
    this.cancelSendFile();
    global.socket.emit('leaveRoom', { roomId: roomId });
    if (this.props.videoPage) {
      if (document.getElementsByClassName("video")[0]) {
        document.getElementsByClassName("video")[0].classList.remove('video-open-chat')
      }
      if (document.getElementsByClassName("nav_bottom")[0]) {
        document.getElementsByClassName("nav_bottom")[0].classList.remove('nav_bottom-on-chat')
      }
    }
  }

  //-----------------------

  refuseInvitation = async (id, email) => { //refuse friend request
    await this.props.dispatch(fetchRefuseInvitation(sessionStorage.getItem('token'), id, email))
    this.props.dispatch(fetchUpdateFriendsList(sessionStorage.getItem('token')))
    global.socket.emit("checkNewUser", { token: sessionStorage.getItem('token'), id: id })
  }

  acceptInvitation = async (id, email) => { //accept friend request
    await this.props.dispatch(fetchAcceptInvitation(sessionStorage.getItem('token'), id, email))
    this.props.dispatch(fetchUpdateFriendsList(sessionStorage.getItem('token')))
    global.socket.emit("checkNewUser", { token: sessionStorage.getItem('token'), id: id })
    if (this.state.isChat) {
      await this.setState({ isChat: false })
    }
  }

  showInvitations = () => { //change invitation tab state
    this.setState({ isInvitationTab: true, isFriendTab: false, isGroupTab: false, isSearch: false, searchInputRegex: '' })
  }

  invitations = () => { //show inivitation tab
    if (this.state.isInvitationTab) {
      if (this.props.invitations_list.length > 0) {
        // console.log(this.props.invitations_list)
        return this.props.invitations_list.map((invitation) => (
          <div className='all_invit ' key={invitation.id}>
            <p className="name-friend-invite">{decodeURI(invitation.display_name)}</p>
            <div className="invit-button-area">
              <button className='invit_accept' onClick={this.acceptInvitation.bind(this, invitation.id, invitation.email)}>Accept</button>
              <button className='invit_refuse' onClick={this.refuseInvitation.bind(this, invitation.id, invitation.email)}>Refuse</button>
            </div>
          </div>
        ));
      } else {
        return <p className='white_text'>No invitations</p>
      }
    } else {
      return null
    }
  }

  onFocusHandler = () => { //focus handler for chatbox text input
    this.setState({ msg_input_focused: true, isEmoji: false })
    if (this.state.id) {
      let removeNotifyOffline = "";
      let currentNotifyOffline = "";
      if (this.state.notify_offline) {
        currentNotifyOffline = this.state.notify_offline.split(":");
        removeNotifyOffline = currentNotifyOffline.filter((val) => (val !== this.state.id.toString())).join(":");
        this.setState({ notify_offline: removeNotifyOffline, isShowNotifyBrowser: true, options: {}, countMsg: false })
      }
    }
    if (this.state.room_Id) {
      let removeNotifyGroupsOffline = "";
      let currentNotifyGroupsOffline = "";
      if (this.state.notify_group_offline) {
        currentNotifyGroupsOffline = this.state.notify_group_offline.split(":");
        removeNotifyGroupsOffline = currentNotifyGroupsOffline.filter((val) => (val !== this.state.room_Id.toString())).join(":");
        this.setState({ notify_group_offline: removeNotifyGroupsOffline, isShowNotifyBrowser: true, options: {}, countMsg: false })
      }
    }
    global.socket.emit('readed_message', { token: sessionStorage.getItem('token') })
    if (this.input_send_m.current.value.trim() !== '') {
      global.socket.emit('typing', { isfocus: true, token: sessionStorage.getItem('token') })
    }
  }

  onBlurHandler = () => { //blur handler for chatbox input
    this.setState({ msg_input_focused: false })
    global.socket.emit('typing', { isfocus: false, token: sessionStorage.getItem('token') })
  }

  handleKeyPress = async (event) => { //keypress handler for chatbox input
    global.socket.emit('typing', { isfocus: true, token: sessionStorage.getItem('token') })
    if (this.input_send_m.current.value.trim() === '') {
      if (event.key === 'Enter' && this.state.selectedFile) {
        if (this.input_file && this.input_file.current) {
          this.input_file.current.value = "";
        };
        await this.setState({
          processing_upload: [...this.state.processing_upload, {
            roomId: this.state.room_Id,
            filename: this.state.selectedFile.name,
            loaded: 0,
            fileToSend: "",
            size: this.state.selectedFile.size
          }]
        });
        this.processSendFile();
      };
      return null;
    } else {
      if (event.key === 'Enter') {
        var text = this.input_send_m.current.value.trim();
        const time = Date.now()
        const id = this.props.id
        const result = this.renderChatMessage({ message: text, name: this.props.display_name, avatar: this.props.avatar, id: id, time: time });
        var msg_send = document.createElement('li');
        msg_send.id = time;
        msg_send.innerHTML = result;
        document.getElementById('message').appendChild(msg_send);
        this.scrollToBottom();

        let deleteMess = msg_send.getElementsByTagName("i")[0];
        deleteMess.addEventListener('click', (e) => {
          global.socket.emit('delete_message', { time, id });
        })

        global.socket.emit('new_message', { message: text, time: time, token: sessionStorage.getItem('token') });
        this.input_send_m.current.value = '';
        if (this.state.selectedFile) {
          if (this.input_file && this.input_file.current) {
            this.input_file.current.value = "";
          };
          await this.setState({
            processing_upload: [...this.state.processing_upload, {
              roomId: this.state.room_Id,
              filename: this.state.selectedFile.name,
              loaded: 0,
              fileToSend: "",
              size: this.state.selectedFile.size
            }]
          });
          this.processSendFile();
        }
        if (event.preventDefault) event.preventDefault();
      }
    }
  }

  handleKeyDownCloseChat = (e) => {
    if (e.which === 27) {
      this.closeChat(this, "", this.state.room_Id)
    }
  }

  send_message = async (event) => {
    if (this.input_send_m.current.value.trim() === '') {
      if (this.state.selectedFile) {
        if (this.input_file && this.input_file.current) {
          this.input_file.current.value = "";
        };
        await this.setState({
          processing_upload: [...this.state.processing_upload, {
            roomId: this.state.room_Id,
            filename: this.state.selectedFile.name,
            loaded: 0,
            fileToSend: "",
            size: this.state.selectedFile.size
          }]
        });
        this.processSendFile();
      }
    } else {
      var text = this.input_send_m.current.value.trim();
      const time = Date.now()
      const id = this.props.id
      const result = this.renderChatMessage({ message: text, name: this.props.display_name, avatar: this.props.avatar, id: id, time: time });
      var msg_send = document.createElement('li');
      msg_send.id = time
      msg_send.innerHTML = result;
      document.getElementById('message').appendChild(msg_send);
      this.scrollToBottom();

      let deleteMess = msg_send.getElementsByTagName("i")[0];
      deleteMess.addEventListener('click', (e) => {
        global.socket.emit('delete_message', { time, id });
      })

      global.socket.emit('new_message', { message: text, time: time, token: sessionStorage.getItem('token') });
      this.input_send_m.current.value = '';
      if (this.state.selectedFile) {
        if (this.input_file && this.input_file.current) {
          this.input_file.current.value = "";
        };
        await this.setState({
          processing_upload: [...this.state.processing_upload, {
            roomId: this.state.room_Id,
            filename: this.state.selectedFile.name,
            loaded: 0,
            fileToSend: "",
            size: this.state.selectedFile.size
          }]
        });
        this.processSendFile();
      }
      if (event.preventDefault) event.preventDefault();
    }
  }

  receive_message = (data) => { //handle incomining message and render message
    //console.log("receive_message: " + this.state.room_Id)
    if (this.state.room_Id === data.room) {
      var regex = /LIEN/gi;
      var message = data.message;
      if (regex.test(data.message)) {
        let msg_typing = document.getElementById('msg_typing');
        msg_typing.innerHTML = '';
        var msg_send = document.createElement('li');
        var fileDisplayName = data.message.replace(regex, '');
        let fileSize = "";
        if (data.size) {
          fileSize = this.bytesToSize(data.size);
        };
        const file = `<p class='msg'><span class="msg-download-file" ><i class="fa fa-download" aria-hidden="true"></i> ${data.file_name} (${fileSize})</span></p>`;
        msg_send.id = data.time
        const result = this.renderChatMessage({ typeUser: 'sendUser', message, name: data.username, file, id: data.userid, time: data.time });
        msg_send.innerHTML = result;
        let download = msg_send.getElementsByTagName("span")[0];
        download.addEventListener('click', function (e) {
          global.socket.emit('download', { name: fileDisplayName, filename: data.filename });
        })
        if (document.getElementById('message')) {
          document.getElementById('message').appendChild(msg_send);
          this.scrollToBottom();
        }
      } else {
        let msg_typing = document.getElementById('msg_typing')
        if (msg_typing) {
          msg_typing.innerHTML = ''
          var msg = document.createElement('li');
          msg.id = data.time
          const result = this.renderChatMessage({ typeUser: 'sendUser', message, name: data.username, id: data.userid, time: data.time });
          msg.innerHTML = result;
          if (document.getElementById('message')) {
            document.getElementById('message').appendChild(msg);
            this.scrollToBottom();
          }
        }
      }
      if (this.state.msg_input_focused) {
        if (this.state.id) {
          let removeNotifyOffline = "";
          let currentNotifyOffline = "";
          if (this.state.notify_offline) {
            currentNotifyOffline = this.state.notify_offline.split(":");
            removeNotifyOffline = currentNotifyOffline.filter((val) => (val !== this.state.id.toString())).join(":");
            this.setState({ notify_offline: removeNotifyOffline, isShowNotifyBrowser: true, options: {}, countMsg: false })
          }
        }
        if (this.state.room_Id) {
          let removeNotifyGroupsOffline = "";
          let currentNotifyGroupsOffline = "";
          if (this.state.notify_group_offline) {
            currentNotifyGroupsOffline = this.state.notify_group_offline.split(":");
            removeNotifyGroupsOffline = currentNotifyGroupsOffline.filter((val) => (val !== this.state.room_Id.toString())).join(":");
            this.setState({ notify_group_offline: removeNotifyGroupsOffline, isShowNotifyBrowser: true, options: {}, countMsg: false })
          }
        }
        global.socket.emit('readed_message', { token: sessionStorage.getItem('token') })
      }
    }
  }

  typing_message = (data) => { //handle friends' typing message event, i.e. "abc is typing a message..."
    if (this.state.clearTypingTimeoutId) {
      window.clearTimeout(this.state.clearTypingTimeoutId);
    }
    var msg_typing = document.getElementById('msg_typing');
    var msg_typing_new = document.createElement('li');
    msg_typing_new.setAttribute("id", `typing-${data.id}`);
    msg_typing_new.innerHTML = `<span class='typing-name'>${decodeURI(data.username)}</span> <span class="is-typing">is typing a message...</span>`;
    var remove_typing = document.getElementById(`typing-${data.id}`);
    if (msg_typing && data.isfocus) {
      if (!remove_typing) {
        msg_typing.appendChild(msg_typing_new)
        this.scrollToBottom();
      }
    } else {
      if (remove_typing) {
        msg_typing.removeChild(remove_typing)
      }
    }
    var clearTyping = window.setTimeout(() => {
      var remove_typing = document.getElementById(`typing-${data.id}`); //don't delete this line
      if (remove_typing) {
        msg_typing.removeChild(remove_typing)
      }
    }, 5000)
    this.setState({ clearTypingTimeoutId: clearTyping });
  }

  deleteUser = async (idName, name, idConv, removedUsername) => { //delete member in group handler
    let removeUserAction = () => {
      global.socket.emit('remove_user', { id: idName, roomId: idConv, token: sessionStorage.getItem('token') });
      global.socket.on('errRemoveUserGroupMsg', (data) => {
        toast.error("You are not allowed to do this", {
          position: toast.POSITION.TOP_RIGHT,
          toastId: data.token,
        });
      });

      global.socket.on('removeUserGroupMsg', (data) => {
        if (data.message === '' && data.removedUserId === idName) {
          //console.log("delete" + idName)
          let newNameGroup = this.state.NameGroup[this.state.NameGroup.map(conv => conv.name).indexOf(name)]
          if (newNameGroup) {
            newNameGroup = newNameGroup.part
            newNameGroup.splice(newNameGroup.map(index => index.id).indexOf(idName), 1)
            this.setState({ [this.state.NameGroup[this.state.NameGroup.map(conv => conv.name).indexOf(name)]]: newNameGroup })
          }
        }
      });
    }
    if (idName === this.props.id) {
      if (window.confirm("Do you want to leave this group chat?")) {
        global.socket.emit('remove_user', { id: idName, roomId: idConv, token: sessionStorage.getItem('token') })
        var disbandGroup = this.state.NameGroup;
        disbandGroup.splice(disbandGroup.map(index => index.name).indexOf(name), 1);
        this.setState({ NameGroup: disbandGroup, member: false, isOption: false, GroupConv: false, isConvOne: false, selectedFile: null, isEmoji: false });
        toast.info("You left the group chat", {
          position: toast.POSITION.TOP_RIGHT,
          toastId: "leave group chat",
        });
      }
    } else {
      let part = this.state.NameGroup[this.state.NameGroup.map(conv => conv.roomId).indexOf(this.state.room_Id)].part;
      if (part.length <= 2) {
        if (window.confirm(`Removing this user ${decodeURI(removedUsername)} will delete the group chat, Do you want to proceed?`)) {
          await removeUserAction();
          this.setState({ isOption: false, isConvOne: false })
          toast.info("Less than 2 users in one group", {
            position: toast.POSITION.TOP_RIGHT,
            toastId: "delete group chat",
          });
        }
      } else {
        if (window.confirm("Do you want to delete this user: " + decodeURI(removedUsername))) {
          removeUserAction();
        }
      }
    }
  }

  deleteConv = (name, id) => { //delete group handler
    if (window.confirm('Are you sure you want to delete this room ' + decodeURI(name))) {
      this.setState({ isConvOne: false, infoPress: false, isOption: false, member: false, selectedFile: null, isEmoji: false });
      global.socket.emit('delete_room', { roomId: id, token: sessionStorage.getItem('token') })
      global.socket.on('errorMsg', (data) => {
        if (data.message === '') {
          var disbandGroup = this.state.NameGroup;
          disbandGroup.splice(disbandGroup.map(index => index.name).indexOf(name), 1);
          this.setState({ NameGroup: disbandGroup, member: false, isOption: false, GroupConv: false });
        } else {
          toast.error("You are not allowed to do this", {
            position: toast.POSITION.TOP_RIGHT,
            toastId: data.token,
          });
        }
      })
      global.socket.on('validation', (data) => {
        if (data.message === "delete_room") {
          toast.success("Group deleted", {
            position: toast.POSITION.TOP_RIGHT,
            toastId: "deleteGroup",
          });
        }
      })
    } else {
      this.fetchNewConv()
    }
  }

  optionConv = () => { //group chat setting render
    if (this.state.isOption && this.state.isAdd && this.state.isConvOne) {
      return (
        <div className={
          this.state.isFullHeight && !this.props.videoPage ? 'config-group-chat config-group-chat-full-height'
            : this.props.videoPage ? 'config-group-chat config-group-chat-on-call'
              : 'config-group-chat'}>
          <div className='create-config-group'>
            <div className='title-config-group'>
              <span className='closeChat-btn' onClick={() => this.setState({ isOption: false, isAdd: false })} >
                <img className="cancel-icon" src={cancel} />
              </span>
              <p className='group-chat-setting-title'>Group Chat Settings</p>
              <div className="change-group-name-title">Change group name:</div>
              <div className="change-group-name-wrapper">
                <input className='form-control group-chat-name-input change-group-name-input' id='NameGroupChat2' name='NameGroupChat2' autoComplete="off" placeholder="Write a name here..." type='text' defaultValue={decodeURI(this.state.nameConv).trim()}></input>
                {this.showChangeGroupName()}
                <button className='movebtn change-group-name-btn' onClick={this.changeGroupName.bind(this)}>Save</button>
              </div>
              <hr className='' />
              <div className="add-remove-member-title">Add or remove group members:</div>
              <div className='allinclude1'>
                <button className='movebtn add-friend-groupchat-btn add-friend-groupchat-btn2' onClick={this.showFriendsGroupChat.bind(this)}>Add friends +</button>
                {this.friends_list_group2()}
              </div>
              <div className='group-setting-members-container'>
                {this.MemberInGroup()}
              </div>
            </div>
          </div>
        </div>
      )
    }
  }

  MemberInGroup = () => { //group chat setting -> member in group render
    var part = this.state.NameGroup[this.state.NameGroup.map(conv => conv.roomId).indexOf(this.state.room_Id)]
    if (this.state.member && part) {
      return (
        <Fragment>
          {
            part.part.map((name) => {
              return (
                <div key={name.id} className="add-friend-group-wrapper group-member-wrapper">
                  <div className="add-friend-group-avatar-wrapper group-setting-member-avatar-wraper"><img className='imgUser add-friend-group-avatar group-setting-member-avatar' src={`${settings.defaultSettings.REACT_APP_API_URL}/avatars/${name.avatars}`} onError={this.addDefaultSrc} alt="" /></div>
                  <p className='group-setting-member-name'>{this.showStatusFriends(name)} {decodeURI(name.name)}</p>
                  <span className='delete-friend-group' onClick={this.deleteUser.bind(this, name.id, part.name, part.roomId, name.name)}>
                    {this.props.id === name.id ? <i className="fa fa-sign-out remove-group-friend-icon"></i> : <i className="fa fa-times remove-group-friend-icon"></i>}
                  </span>
                </div>
              )
            })
          }
        </Fragment>
      )
    }
  }

  changeGroupName = () => { //change group name handler
    var newGroupName = document.getElementById('NameGroupChat2').value
    if (newGroupName.trim() === '') {
      toast.warn("Please enter group name!", {
        position: toast.POSITION.TOP_RIGHT
      });
    } else {
      this.setState({ GroupNameAfter: newGroupName, change_group_name: true, nameConv: newGroupName })
    }
  }

  showChangeGroupName = () => { //handler display after chaning group name
    if (this.state.change_group_name) {
      global.socket.emit('rename_room', { roomId: this.state.room_Id, roomName: this.state.GroupNameAfter })
      global.socket.on("validation", (data) => {
        if (data.message === 'rename_room') {
          toast.success("Group name changed", {
            position: toast.POSITION.TOP_RIGHT,
            toastId: "change group name"
          });
        }
      })
    } else {
      return null;
    }
  }

  //---------------------------------------------
  change_tab = () => { //change tab
    let [currentNotifyGroupsOffline, filteredNotifyGroup, currentNotifyOffline, filteredNotify] = [[], [], [], []];
    if (this.state.notify_group_offline) {
      currentNotifyGroupsOffline = this.state.notify_group_offline.split(":");
      filteredNotifyGroup = [...new Set(currentNotifyGroupsOffline)].filter((val) => (val !== null && val !== ""));
      if (this.state.NameGroup.length > 0) {
        var groups = this.state.NameGroup.map(val => val.roomId.toString());
        filteredNotifyGroup = filteredNotifyGroup.filter((val) => {
          return groups.indexOf(val) !== -1
        })
      }
    }
    if (this.state.notify_offline) {
      currentNotifyOffline = this.state.notify_offline.split(":");
      filteredNotify = [...new Set(currentNotifyOffline)].filter((val) => (val !== null && val !== ""));
      try {
        if (this.props.friends_list && this.props.friends_list.length > 0) {
          var friends = this.props.friends_list.map(val => val.id.toString());
          filteredNotify = filteredNotify.filter((val) => {
            return friends.indexOf(val) !== -1
          })
        }
      } catch (e) {

      }
    }
    let notif_offline = filteredNotify.length + filteredNotifyGroup.length;
    if (this.state.isFriendTab === true) {
      return (
        <div className="button-navigation">
          <button className='nav-bar-active' onClick={this.showFriend.bind(this)} >
            <i className="fa fa-comments-o switch-icon" aria-hidden="true"></i>
            <div className={notif_offline > 0 ? "switch-noti" : "switch-noti d-none"}>{notif_offline}</div>
          </button>
          <button className='nav-bar-inactive' onClick={this.showInvitations.bind(this)}>
            <i className="fa fa-user-plus switch-icon" aria-hidden="true"></i>
            <div className={this.props.invitations_list.length > 0 ? "switch-noti" : "switch-noti d-none"}>{this.props.invitations_list.length}</div>
          </button>
        </div>
      )
    } else if (this.state.isInvitationTab === true) {
      return (
        <div className="button-navigation">
          <button className='nav-bar-inactive' onClick={this.showFriend.bind(this)} >
            <i className="fa fa-comments-o switch-icon" aria-hidden="true"></i>
            <div className={notif_offline > 0 ? "switch-noti" : "switch-noti d-none"}>{notif_offline}</div>
          </button>
          <button className='nav-bar-active' onClick={this.showInvitations.bind(this)}>
            <i className="fa fa-user-plus switch-icon" aria-hidden="true"></i>
            <div className={this.props.invitations_list.length > 0 ? "switch-noti" : "switch-noti d-none"}>{this.props.invitations_list.length}</div>
          </button>
        </div>
      )
    }
    else {
      return null
    }
  }

  createGroupChat = () => { //Create Group Chat render
    if (this.state.isGroupChat) {
      return (
        <div className='createGroupChat'>
          <div className='group-chat-container'>
            <span className='closeChat-btn' onClick={this.closeCreate.bind(this)} >
              <img className="cancel-icon" src={cancel} />
            </span>
            <div className='group-chat-name'>
              <p className='group-chat-name-title'>Create a name for your Group Chat:</p>
              <input className='group-chat-name-input form-control' id='NameGroupChat' autoComplete='off' placeholder='Write a name here...' type='text' onChange={this.checkEmpty.bind(this)} ></input>
            </div>
            <hr className='horizontale2' />
            <div className='invite-title'>Invite at least 2 people to your group chat:</div>
            <div className='allinclude1' >
              <button className='movebtn add-friend-groupchat-btn' onClick={this.showFriendsGroup.bind(this)}>Add friends +</button>
              <div className='add-fr-group'>
                {this.friends_list_group()}
              </div>
            </div>
            {this.addFriendToGroup()}
            {
              (this.state.isAdd && this.state.GroupListId.length >= 2) && this.state.groupNameNotEmpty ? <button className='movebtn create-group-done-btn' onClick={this.showNext.bind(this)}>DONE</button> : <button className='movebtn create-group-done-btn create-group-done-btn-disable'>DONE</button>
            }
          </div>
        </div>
      )
    }
  }

  checkEmpty = (e) => { //check if create group chat name is empty
    if (e.target.value.length === 0 || e.target.value.trim() === '') {
      this.setState({ groupNameNotEmpty: false })
    } else {
      this.setState({ groupNameNotEmpty: true })
    }
  }

  showCreateChat = () => { //change create group chat state
    if (this.props.friends_list.length > 0) {
      this.setState({ id: null, room_Id: null, isGroupChat: true, isChatWithUserRole: false, isAdd: false, isNext: false, GroupListId: [], GroupList: [], isConvOne: false, isChat: false, historic: [], vueHisto: true, member: false, maxRenderMsg: 10, currentMsgRender: 0, tempMsg: [], isOption: false, infoPress: false, selectedFile: null, isEmoji: false })
    } else {
      this.setState({ isGroupChat: false, isAdd: false, isNext: false, GroupListId: [], GroupList: [] })
      toast.warn("You don't have any friends, please add some to create a Group Chat", {
        position: toast.POSITION.TOP_RIGHT
      });
    }
  }

  closeCreate = () => { //close create group chat
    this.setState({ isGroupChat: false, isAdd: false, isOption: false, infoPress: false })
  }

  friends_list_group = () => { //add friend to group chat render
    if (this.state.isFriendListGroup) {
      return (
        <div className='zone_list'>
          <div className="zone-list-header">
            <div className="zone-list-header-title">Add friends</div>
            <span className='closeChat-btn' onClick={this.notShowFriendsGroup} >
              <img className="cancel-icon" src={cancel} />
            </span>
          </div>
          <div className="add-friend-wrapper">
            {
              this.props.friends_list.map((friend) => {
                return (
                  <div className='ListGroup' key={friend.id}>
                    <div className='status-name-group'>
                      {this.showStatusFriends(friend)}
                      <p className="add-friend-name">{decodeURI(friend.display_name)}</p>
                    </div>
                    <button id='MoreFriend' className='btn btn-info add-friend-group' onClick={this.addFriendToList.bind(this, friend.id)}>ADD</button>
                  </div>
                )
              })
            }
          </div>
        </div>
      )
    }
  }

  showFriendsGroup = () => { //add friend to group friend list state
    this.setState(({ isFriendListGroup }) => ({ isFriendListGroup: !isFriendListGroup }));
  }

  notShowFriendsGroup = () => { //not show add friend to group friend list state
    this.setState({ isFriendListGroup: false })
  }

  showFriendsGroupChat = () => { //add friend to group friend list state
    this.setState(({ isFriendListGroupChat }) => ({ isFriendListGroupChat: !isFriendListGroupChat }));
  }

  notShowFriendsGroupChat = () => {  //not show add friend to group friend list state
    this.setState({ isFriendListGroupChat: false })
  }

  addFriendToList = (id) => { //add friend to group chat handler
    var group_list_id = this.state.GroupListId
    if (group_list_id.indexOf(id) === -1) {
      group_list_id.push(id);
      const { friends_list } = this.props;
      const first_name = friends_list[friends_list.map(index => index.id).indexOf(id)].first_name;
      const last_name = friends_list[friends_list.map(index => index.id).indexOf(id)].last_name;
      const display_name = friends_list[friends_list.map(index => index.id).indexOf(id)].display_name;
      const avatars = friends_list[friends_list.map(index => index.id).indexOf(id)].avatars;
      const status = friends_list[friends_list.map(index => index.id).indexOf(id)].status;
      const group_list = this.state.GroupList;
      group_list.push({ id, first_name, last_name, avatars, status, display_name });
      this.setState({ isAdd: true, GroupListId: group_list_id, GroupList: [...new Set(group_list)] });
    }
  }

  friends_list_group2 = () => { //add friend to group chat render in group chat setting
    const part = this.state.NameGroup[this.state.NameGroup.map(conv => conv.roomId).indexOf(this.state.room_Id)].part.map(friend => friend.id)
    const list = this.props.friends_list.filter(friend => part.indexOf(friend.id) === -1)
    if (this.state.isFriendListGroupChat) {
      return (
        <div className={this.state.isFullHeight ? 'zone_list zone-list-full-height' : 'zone_list'}>
          <div className="zone-list-header">
            <div className="zone-list-header-title">Add friends</div>
            <span className='closeChat-btn' onClick={this.notShowFriendsGroupChat} >
              <img className="cancel-icon" src={cancel} />
            </span>
          </div>
          <div className="add-friend-wrapper">
            {
              list.map((friend) => {
                return (
                  <div className='ListGroup' key={friend.id}>
                    <div className='status-name-group'>
                      {this.showStatusFriends(friend)}
                      <p className="add-friend-name">{decodeURI(friend.display_name)}</p>
                    </div>
                    {part.indexOf(friend.id) === -1 ? <button id='MoreFriend' className='btn btn-info add-friend-group' onClick={this.addFriendAlreadyCreate.bind(this, friend)}>ADD</button> : <button id='MoreFriend' className='btn btn-info add-friend-group d-none'></button>}
                  </div>
                )
              })
            }
          </div>
        </div>
      )
    }
  }

  addFriendAlreadyCreate = (user) => { //add friend handler to group chat in group chat setting
    const room = this.state.NameGroup.find(gr => gr.roomId === this.state.room_Id)
    //console.log("addFriendAlreadyCreate: " + room)
    global.socket.emit('new_user', { id: user.id, roomId: this.state.room_Id })
  }

  addFriendToGroup = () => { //add friend to group in create group chat
    return (
      <div className='add-friend-group-list'>
        {
          this.state.GroupList.map((friend) => {
            return (
              <div key={friend.id} className="add-friend-group-wrapper">
                <div className="add-friend-group-avatar-wrapper"><img className='imgUser add-friend-group-avatar' src={`${settings.defaultSettings.REACT_APP_API_URL}/avatars/${friend.avatars}`} onError={this.addDefaultSrc} alt="" /></div>
                <p className='add-friend-group-list-name'>{decodeURI(friend.display_name)}</p>
                <span className='remove-group-friend-btn' onClick={this.deleteAdd.bind(this, friend.id)}><i className="fa fa-times remove-group-friend-icon"></i></span>
              </div>
            )
          })
        }
      </div>
    )
  }

  deleteAdd = (id) => { //delete friend added to group chat
    var group_list_id = this.state.GroupListId
    if (group_list_id.indexOf(id) >= 0) {
      group_list_id.splice(group_list_id.indexOf(id), 1)
      const group_list = this.state.GroupList
      group_list.splice(group_list.map(index => index.id).indexOf(id), 1)
      this.setState({ isAdd: true, GroupListId: group_list_id, GroupList: group_list })
    }
  }

  next = () => {
    if (this.state.isNext) {
      if (this.state.GroupListId.length > 1) {
        if (this.state.name !== '') {
          var id = this.state.GroupListId
          global.socket.emit('change_room', { token: sessionStorage.getItem('token'), idFriend: id, room_name: this.state.name, isGroupChat: true });
          this.setState({ isNext: false })
        } else {
          return null;
        }
      } else {
        return null;
      }
    }
  }

  showNext = () => {  //finish creating group chat notification handler
    this.setState({ isNext: true, historic: [], vueHisto: false, isGroupChat: false, isAdd: false, GroupConv: true, maxRenderMsg: 10, currentMsgRender: 0, tempMsg: [], name: document.getElementById('NameGroupChat').value, groupNameNotEmpty: false })
    global.socket.on('groupExisted', (data) => {
      if (data.message === "groupExisted") {
        toast.error("Same group has already existed", {
          position: toast.POSITION.TOP_RIGHT,
          toastId: 'groupExisted'
        })
      }
    })
    global.socket.on("validation", (data) => {
      if (data.message === "create_group") {
        toast.success("Group created", {
          position: toast.POSITION.TOP_RIGHT,
          toastId: 'groupExisted'
        });
      }
    })
    if (document.getElementById('message')) {
      document.getElementById('message').innerHTML = "";
    }
  }

  showConvGroup = () => {
    if (this.state.GroupConv) {
      if (this.state.nothing) {
      } else {
        return (
          <div className=''>
            {this.next()}
          </div>
        )
      }
    }
  }

  showGroupConvClick = () => {
    this.setState(({ GroupConv }) => ({ GroupConv: !GroupConv }));
  }

  showOne = (name, roomId) => { //show group chatbox handler state
    this.setState({ id: null, isConvOne: true, isChat: false, isChatWithUserRole: false, GroupNameAfter: name, GroupNameAfterId: roomId, historic: [], vueHisto: true, member: true, maxRenderMsg: 10, currentMsgRender: 0, tempMsg: [], isGroupChat: false, isAdd: false, isOption: false, infoPress: false, room_Id: roomId, selectedFile: null, isEmoji: false },
      () => {
        let typing = document.getElementById('msg_typing')
        if (typing) {
          typing.innerHTML = ''
        }
        if (this.input_send_m && this.input_send_m.current) {
          this.input_send_m.current.focus();
        }
        if (roomId) {
          let removeNotifyGroupsOffline = "";
          let currentNotifyGroupsOffline = "";
          if (this.state.notify_group_offline) {
            currentNotifyGroupsOffline = this.state.notify_group_offline.split(":");
            removeNotifyGroupsOffline = currentNotifyGroupsOffline.filter((val) => (val !== roomId.toString())).join(":");
            this.setState({ notify_group_offline: removeNotifyGroupsOffline, isShowNotifyBrowser: true, options: {}, countMsg: false })
          }
        }
      }
    )

    global.socket.emit('change_group_room', { roomId: roomId });
    if (document.getElementById('message')) {
      document.getElementById('message').innerHTML = "";
    }
  }

  addEmoji = (event) => { //add emoji to input handler
    if (this.input_send_m && this.input_send_m.current) {
      this.input_send_m.current.value = this.input_send_m.current.value + event.native
      this.setState({ isEmoji: false })
    }
  }

  setFullHeight = () => {
    this.setState({ isFullHeight: !this.state.isFullHeight })
  }

  joinGroupCall = (room_id, call_group_id) => {
    global.socket.emit("joinGroupCall", { room_id: room_id, call_group_id: call_group_id })
  }

  showOneConvGroup = () => { //show group chatbox render
    if (this.state.isConvOne) {
      const heightBody = window.innerHeight - 60 - 50;
      const id = this.state.GroupNameAfterId;
      const part = this.state.NameGroup[this.state.NameGroup.map(conv => conv.roomId).indexOf(id)];
      var name = this.state.GroupNameAfter;
      let chatHeight;
      let size_messageHeight;
      chatHeight = 500;
      if (this.state.selectedFile) {
        size_messageHeight = chatHeight - 135 - 60;
      } else {
        size_messageHeight = chatHeight - 85 - 60;
      }
      if (this.state.room_Id) {
        var roomIndex = this.state.processing_upload.map(e => e.roomId).indexOf(this.state.room_Id);
        var processing_upload = this.state.processing_upload[roomIndex];
      }
      if (part) {
        let callIds = part.part.map(val => [val.id, val.status])
        let filterSelf = part.part.filter(val => val[0] !== this.props.id)
        return (
          <div className={
            this.props.videoPage ? 'chat chat-on-call'
              : this.state.isFullHeight ? 'chat chat-full-height'
                : 'chat chat-no-call'
          }
            style={{ minHeight: chatHeight }}>
            <div className='info'>
              <p className='NameConv'>{decodeURI(name).trim()}</p>
              <div className=" list-actions-chat">
                {part.callStatus === "OnCall" && !this.props.videoPage ?
                  <i className="fa fa-video-camera video-call-icon" onClick={() => this.props.joinOnGoingGroupCall(part.call_group_id, part.roomId)}></i>
                  : <i className="fa fa-video-camera video-call-icon group-call" title="Make a group call" aria-hidden="true" onClick={() => this.props.call(callIds, null, true, part.name, part.roomId)}></i>
                }

                <i className="fa fa-cog cog-icon" aria-hidden="true" onClick={this.showBtnOption.bind(this, part.name, part.roomId)}></i>
                {!this.props.videoPage ? <i className={this.state.isFullHeight ? "fa  fa-window-restore resize-icon" : "fa fa-window-maximize resize-icon"} onClick={() => this.setFullHeight()}></i> : ""}
                <img className="cancel-icon" src={cancel} onClick={this.closeChat.bind(this, "", this.state.room_Id)} />
              </div>
            </div>
            {
              part.callStatus === "OnCall" && !this.props.videoPage ?
                <div className='join-group-call-bar' onClick={() => this.props.joinOnGoingGroupCall(part.call_group_id, part.roomId)}>
                  <div className='join-group-call-animation'><i className="fa fa-video-camera video-call-icon"></i></div>
                  <div className='join-group-call-text'>On going call...</div>
                </div>
                : ''
            }
            <div className={
              this.state.isFullHeight && !this.state.selectedFile ? 'size_message size_message-full-height' :
                this.state.isFullHeight && this.state.selectedFile ? 'size_message size_message-full-height size_message-full-height-attach-file'
                  : 'size_message'
            } id="size_message" style={{ height: size_messageHeight, minHeight: size_messageHeight, maxHeight: size_messageHeight }}>
              <div className='scroll'>
                {
                  (this.state.currentMsgRender < this.state.tempMsg.length) ?
                    <button className="older-messages" onClick={this.getOlderMessages} type="button">↑ Get older messages</button>
                    : ''
                }
                {this.historic()}
                <ul className='message' id='message'></ul>
                <ul className='typing' id='msg_typing'>
                </ul>
                {processing_upload ?
                  <div className='sending-file-container' id={processing_upload.roomId}>
                    <div className='file-loader-container'>
                      <div className="file-loader">
                      </div>
                      <div className="file-loader-details">
                        <div className="file-loader-title">Sending file...</div>
                        <div className="file-loader-filename">{processing_upload.filename}</div>
                        <div className="progress-wrap progress" >
                          <div className="progress-bar" style={{ width: `${processing_upload.loaded}%` }}></div>
                        </div>
                      </div>
                      {this.scrollToBottom()}
                    </div>
                  </div>
                  : ""
                }
              </div>
            </div>
            <div className='convArea'>
              {this.chargeFile()}
            </div>
          </div>
        )
      } else {
        this.setState({ isConvOne: false, isOption: false })
      }
    }
  }

  showBtnOption = (name, roomId) => {
    this.setState({ isOption: true, nameConv: name, isFriendListGroup: false, isAdd: true, room_Id: roomId, isFriendListGroupChat: false })
  }

  showBtnInfoConv = (id) => {
    this.setState({ infoPress: !this.state.infoPress, room_Id: id, isChat: false })
  }

  async fetchNewConv() { //update group chat handler
    const headers = new Headers({
      'Accept': 'application/json',
      'Content-type': 'application/json'
    })
    let response = await fetch(settings.defaultSettings.REACT_APP_API_URL + '/chat/groupChat', { headers, method: 'POST', body: JSON.stringify({ token: sessionStorage.getItem('token') }) })
    let responseJ = await response.json()
    if (responseJ.message === 'nothing') {
      this.setState({ nothing: responseJ.message, change_group_name: false })
    } else {
      this.setState({ NameGroup: responseJ.envoi, change_group_name: false })
    }
  }

  //render chatbox message
  renderChatMessage = ({ typeUser = 'user', message = '', avatar = '', time, name = this.props.display_name, file = false, id = this.props.id, }) => {
    let senderavatars = "";
    let useravatar;
    let parts, partNames
    if (name == 'VIDEO_CHAT_ENDED') {
      parts = message.split(':').filter(e => !!e)
    }
    const defaultAvatar = `${settings.defaultSettings.REACT_APP_API_URL}/avatars/Anonyme.jpeg`;
    if (this.state.NameGroup[this.state.NameGroup.map(conv => conv.roomId).indexOf(this.state.room_Id)]) {
      let membersInGroup = this.state.NameGroup[this.state.NameGroup.map(conv => conv.roomId).indexOf(this.state.room_Id)].part;
      if (name == 'VIDEO_CHAT_ENDED') {
        partNames = parts.map(e => {
          const user = membersInGroup.find((member) => { return member.id == e })
          return user ? decodeURI(user.name) : ''
        })
      }
      let member = membersInGroup.filter((member) => { return member.id === id });
      if (member[0]) {
        useravatar = member[0].avatars;
      } else {
        if (this.state.isChatWithUserRole) {
          useravatar = this.state.currentUserRoleChat.avatars;
        } else {
          useravatar = this.props.friends_list[this.props.friends_list.map(index => index.id).indexOf(id)] !== undefined ? this.props.friends_list[this.props.friends_list.map(index => index.id).indexOf(id)].avatars : ''
        }
      }
    } else {
      if (this.props.friends_list.length > 0) {
        if (this.state.isChatWithUserRole) {
          useravatar = this.state.currentUserRoleChat.avatars;
        } else {
          useravatar = this.props.friends_list[this.props.friends_list.map(index => index.id).indexOf(id)] !== undefined ? this.props.friends_list[this.props.friends_list.map(index => index.id).indexOf(id)].avatars : ''
        }
      } else {
        if (this.state.isChatWithUserRole) {
          useravatar = this.state.currentUserRoleChat.avatars;
        } else {
          useravatar = ''
        }
      }
    }
    if (useravatar) {
      senderavatars = `${settings.defaultSettings.REACT_APP_API_URL}/avatars/${useravatar}`
    } else {
      senderavatars = defaultAvatar;
    }

    if (typeUser === "user") {
      senderavatars = defaultAvatar;
    }
    let formatedTime;
    if (time) {
      formatedTime = moment(time).format('DD/MM/YY, HH:mm');
    } else {
      formatedTime = moment(Date.now()).format('DD/MM/YY, HH:mm');
    }
    if (name == 'VIDEO_CHAT_ENDED') {
      if (partNames) {
        partNames = partNames.join(", ")
      }
      return (
        `<div class="video-ended-container">
            <div class="video-ended-header">Video call ended</div>
            <div class="video-ended-details">
              ${partNames ? `<div class="video-ended-text">- Participants: <span class="video-ended-text-details">${partNames}</span></div>` : ""}
              <div class="video-ended-text">- Ended at: <span class="video-ended-text-details">${formatedTime}</span></div>
            </div>
        </div>`
      )
    } else {
      return (`
        <div class="content-chat ${typeUser === 'user' ? 'current-user-box' : 'send-user-box'}" >
          <div class="avatar-user">
            <img class='imgGroup' src="${avatar ? `${settings.defaultSettings.REACT_APP_API_URL}/avatars/${avatar}` : senderavatars}" onerror="this.onerror=null; this.src='${defaultAvatar}';" />
          </div>
          <div class="chat-message-container">
            <div class="chat-message ${typeUser === 'user' ? 'current-user' : 'send-user'}">
              <div class="header-message">
                <p class="header-display_name ${typeUser === 'user' ? 'name-current-user' : 'name-send-user'}">${decodeURI(name)}</p>
              </div>
              ${!file ? `<p class=${typeUser === 'user' ? "send_msg" : "msg"}>${message}</p>` : file}
              <div class="delete-message">
              ${typeUser === 'user' ? `<i class="fa fa-trash-o"></i>` : ''}
              </div>
            </div>
            <p class="header-time ${typeUser === 'user' ? 'time-current-user' : 'time-send-user'}">${formatedTime}</p>
          </div>
        </div>`
      );
    }
  }

  getOlderMessages = () => { //get older message chatbox handler
    this.setState(({ maxRenderMsg }) => ({ maxRenderMsg: maxRenderMsg + 20 }), () => { this.renderHitoric(); });
  }

  renderHitoric = () => { //render message chatbox history
    var regex = /LIEN/gi;
    let currentMsgRenderCount = this.state.currentMsgRender;
    for (let x = 0; x < this.state.tempMsg.length; x++) {
      if (currentMsgRenderCount < this.state.maxRenderMsg && currentMsgRenderCount < this.state.tempMsg.length) { //maximum initial render of 20 messages
        if (this.props.id === this.state.tempMsg[currentMsgRenderCount].id) {
          if (regex.test(this.state.tempMsg[currentMsgRenderCount].message)) {
            const msg_send = document.createElement('li');
            const fileDisplayName = this.state.tempMsg[currentMsgRenderCount].message.replace(regex, '');
            const filename = this.state.tempMsg[currentMsgRenderCount].filename
            let fileSize = "";
            if (this.state.tempMsg[currentMsgRenderCount].size) {
              fileSize = this.bytesToSize(this.state.tempMsg[currentMsgRenderCount].size);
            }
            msg_send.id = this.state.tempMsg[currentMsgRenderCount].time
            const file = `<p class='send_msg'><span class="msg-download-file" ><i class="fa fa-download" aria-hidden="true"></i> ${this.state.tempMsg[currentMsgRenderCount].file_name !== undefined ? `${this.state.tempMsg[currentMsgRenderCount].file_name} (${fileSize})` : "File"}</span></p>`;
            const result = this.renderChatMessage({ typeUser: 'user', avatar: this.props.avatar, time: this.state.tempMsg[currentMsgRenderCount].time, name: this.props.display_name, file, id: this.props.id });
            msg_send.innerHTML = result;
            let download = msg_send.getElementsByTagName("span")[0];
            download.addEventListener('click', function (e) {
              global.socket.emit('download', { name: fileDisplayName, filename: filename });
            })

            const time = this.state.tempMsg[currentMsgRenderCount].time
            const id = this.props.id
            let deleteMess = msg_send.getElementsByClassName("delete-message")[0];
            deleteMess.addEventListener('click', (e) => {
              global.socket.emit('delete_message', { time, id, filename, isFile: true });
            })

            let chatMsgList = document.getElementById('message');
            chatMsgList.insertBefore(msg_send, chatMsgList.childNodes[0]);
          } else {
            var msg1 = document.createElement('li');
            msg1.id = this.state.tempMsg[currentMsgRenderCount].time
            const result = this.renderChatMessage({ typeUser: 'user', message: this.state.tempMsg[currentMsgRenderCount].message, avatar: this.props.avatar, time: this.state.tempMsg[currentMsgRenderCount].time, name: this.props.display_name, id: this.props.id });
            msg1.innerHTML = result;

            const time = this.state.tempMsg[currentMsgRenderCount].time
            const id = this.props.id
            let deleteMess = msg1.getElementsByClassName("delete-message")[0];
            deleteMess.addEventListener('click', (e) => {
              global.socket.emit('delete_message', { time, id });
            })

            let chatMsgList = document.getElementById('message');
            chatMsgList.insertBefore(msg1, chatMsgList.childNodes[0]);
          }
        } else {
          if (regex.test(this.state.tempMsg[currentMsgRenderCount].message)) {
            const msg_send = document.createElement('li');
            const fileDisplayName = this.state.tempMsg[currentMsgRenderCount].message.replace(regex, '');
            const filename = this.state.tempMsg[currentMsgRenderCount].filename
            let fileSize = "";
            if (this.state.tempMsg[currentMsgRenderCount].size) {
              fileSize = this.bytesToSize(this.state.tempMsg[currentMsgRenderCount].size);
            }
            const file = `<p class='msg'><span class="msg-download-file"><i class="fa fa-download" aria-hidden="true"></i> ${this.state.tempMsg[currentMsgRenderCount].file_name !== undefined ? `${this.state.tempMsg[currentMsgRenderCount].file_name} (${fileSize})` : "File"}</span></p>`;
            msg_send.id = this.state.tempMsg[currentMsgRenderCount].time
            const result = this.renderChatMessage({ typeUser: 'sendUser', time: this.state.tempMsg[currentMsgRenderCount].time, name: this.state.tempMsg[currentMsgRenderCount].display_name, file, id: this.state.tempMsg[currentMsgRenderCount].id });
            msg_send.innerHTML = result;
            let download = msg_send.getElementsByTagName("span")[0];
            download.addEventListener('click', function (e) {
              global.socket.emit('download', { name: fileDisplayName, filename: filename });
            })
            let chatMsgList = document.getElementById('message');
            chatMsgList.insertBefore(msg_send, chatMsgList.childNodes[0]);
          } else {
            var msg2 = document.createElement('li');
            msg2.id = this.state.tempMsg[currentMsgRenderCount].time
            const result = this.renderChatMessage({ typeUser: 'sendUser', message: this.state.tempMsg[currentMsgRenderCount].message, time: this.state.tempMsg[currentMsgRenderCount].time, name: this.state.tempMsg[currentMsgRenderCount].display_name, id: this.state.tempMsg[currentMsgRenderCount].id });
            msg2.innerHTML = result;
            let chatMsgList = document.getElementById('message');
            chatMsgList.insertBefore(msg2, chatMsgList.childNodes[0]);
          }
        }
        currentMsgRenderCount++;
      }
    }
    this.setState({ currentMsgRender: currentMsgRenderCount });
    if (currentMsgRenderCount <= 20) {
      this.scrollToBottom();
    }
  }

  historic = () => { // message chatbox history handler
    if (this.state.historic.length !== 0 && this.state.vueHisto === true) {
      this.setState({ tempMsg: this.state.historic.reverse() }, () => { this.renderHitoric(); });
    } else {
      return null
    }
    this.setState({ vueHisto: false, historic: [] })
  }

  showSearchFriend = () => { //search friend render
    return (
      <Fragment>
        <SearchFriend friends_list={this.props.friends_list} />
      </Fragment>
    )
  }

  colapseContact = () => {
    this.props.dispatch(handlePage(this.props.callPage, this.props.videoPage, false))
  }

  expandContact = () => {
    this.props.dispatch(handlePage(this.props.callPage, this.props.videoPage, true))
  }

  //InfosFriends

  componentDidMount = () => {
    window.addEventListener("dragenter", function (e) {
      if (e.target.name != 'textarea-container') {
        e.preventDefault();
        e.dataTransfer.effectAllowed = "none";
        e.dataTransfer.dropEffect = "none";
      }
    }, false);

    window.addEventListener("dragover", function (e) {
      if (e.target.name != 'textarea-container') {
        e.preventDefault();
        e.dataTransfer.effectAllowed = "none";
        e.dataTransfer.dropEffect = "none";
      }
    });

    window.addEventListener("drop", function (e) {
      if (e.target.name != 'textarea-container') {
        e.preventDefault();
        e.dataTransfer.effectAllowed = "none";
        e.dataTransfer.dropEffect = "none";
      }
    });

    global.socket.on('checkNewUser', async data => {
      if (this.state.isChat) {
        await this.setState({ isChat: false })
      }
    })

    global.socket.on('delete_message', async data => {
      if (!data.isNoti) { // check if delete new message
        if (!data.isRoomMultiUsr) {
          let removeNotifyOffline = "";
          let currentNotifyOffline = "";
          if (this.state.notify_offline) {
            currentNotifyOffline = this.state.notify_offline.split(":").filter(e => e !== '');
            removeNotifyOffline = currentNotifyOffline.filter((val) => (val != data.idUser.toString())).join(":");
            await this.setState({ notify_offline: removeNotifyOffline, isShowNotifyBrowser: true, options: {}, countMsg: false })
          }
        }
        else {
          let removeNotifyGroupsOffline = "";
          let currentNotifyGroupsOffline = "";
          if (this.state.notify_group_offline) {
            currentNotifyGroupsOffline = this.state.notify_group_offline.split(":").filter(e => e !== '')
            removeNotifyGroupsOffline = currentNotifyGroupsOffline.filter((val) => (val !== data.roomId.toString())).join(":");
            await this.setState({ notify_group_offline: removeNotifyGroupsOffline, isShowNotifyBrowser: true, options: {}, countMsg: false })
          }
        }
      }

      if (this.state.room_Id == data.roomId) {
        const message = document.getElementById(data.time)
        const newTempMsg = this.state.tempMsg.filter(msg => msg.time != data.time)

        await this.setState({ tempMsg: newTempMsg })
        if (message) {
          message.remove()
        }
      }
    })

    global.socket.on('validation', (data) => { //update group chat listener
      let findRoom = this.state.NameGroup[this.state.NameGroup.map(conv => conv.roomId).indexOf(data.roomId)]
      //console.log("update on " + data.message)
      //console.log("updateIds " + data.updateIds)
      //console.log(data.roomId)
      //console.log(findRoom)
      //console.log(data.updateIds.search(this.props.id))
      if (findRoom) {
        if (data.updateIds.search(this.props.id) !== -1 || findRoom.roomId === data.roomId) {
          this.fetchNewConv();
        }
      } else {
        if (data.updateIds.search(this.props.id) !== -1) {
          this.fetchNewConv();
        }
      }
    })

    global.socket.on('joinroom', async (data) => {
      await this.setState({ room_Id: data.roomid });
      if (this.input_send_m && this.input_send_m.current) {
        this.input_send_m.current.focus();
      }
      if (this.input_file && this.input_file.current) {
        this.input_file.current.value = "";
      }
      await this.setState({ selectedFile: null, isEmoji: false });
      if (this.props.videoPage) {
        if (document.getElementsByClassName("video")[0]) {
          document.getElementsByClassName("video")[0].classList.add('video-open-chat')
        }
      }
      if (document.getElementsByClassName("nav_bottom")[0]) {
        document.getElementsByClassName("nav_bottom")[0].classList.add('nav_bottom-on-chat')
      }
    })

    global.socket.on('disconnect', (data) => { //socket disconnect listener
      this.closeChat();
    })

    global.socket.on('upload_success', async (data) => { //upload success listener
      //console.log(data)
      await this.sendFile(data);
    })

    global.socket.on('download_file', (data) => { //download file listener
      toast.info("File downloading!", {
        position: toast.POSITION.TOP_RIGHT,
        toastId: "downloadingfile"
      });
      fetch(settings.defaultSettings.REACT_APP_API_URL + '/chat/downloadFile', {
        headers: new Headers({
          'Accept': 'application/json',
          'Content-type': 'application/json'
        }),
        method: 'POST',
        body: JSON.stringify({
          token: sessionStorage.getItem('token'),
          filename: data.filename,
          name: data.name,
          room: data.room
        })
      })
        .then(response => {
          response.blob().then(blob => {
            let url = window.URL.createObjectURL(blob);
            let a = document.createElement('a');
            a.href = url;
            a.download = data.name;
            a.click();
          });
        })
        .catch(err => console.log(err))
    })

    global.socket.on('histo', (data) => { //fetch message hisotry listener
      this.setState({ historic: data.message })
    })

    global.socket.on('errorMsg', (data) => {
      //console.log(data)
    })

    global.socket.on('notify_msg', async (data) => { //notification listener
      console.log(data)
      if (!data.isRoomMultiUsr) {
        console.log("single room")
        this.setState({ countMsg: true })
        if (this.state.id !== data.userid) {
          this.setState({ notify_offline: `${this.state.notify_offline}:${data.userid}` })
        } else {
          if (!this.state.msg_input_focused) {
            this.setState({ notify_offline: `${this.state.notify_offline}:${data.userid}` })
          } else {
            global.socket.emit('readed_message', { token: sessionStorage.getItem('token') })
          }
        }
      } else {
        //console.log("group room")
        if (this.state.room_Id !== data.room) {
          this.setState({ notify_group_offline: `${this.state.notify_group_offline}:${data.room}` })
        } else {
          if (!this.state.msg_input_focused) {
            this.setState({ notify_group_offline: `${this.state.notify_group_offline}:${data.room}` })
          } else {
            global.socket.emit('readed_message', { token: sessionStorage.getItem('token') })
          }
        }
      }
      await global.socket.emit('verif', { verif: data.verif + 1, roomId: data.room })
      this.receive_message(data);
    })

    global.socket.on('notify_offline', (data) => { //get notification when user offline
      //console.log("notify_offline: " + JSON.stringify(data))
      if (data.notif.length > 0 || data.notif_group.length > 0) {
        const notif = data.notif.join(':')
        const notif_group = data.notif_group.join(':')

        this.setState({
          notify_offline: notif,
          notify_group_offline: notif_group
        })
      }
    })

    global.socket.on('typing', (data) => { //friends' typing a message listener
      if (this.state.room_Id === data.room) {
        this.typing_message(data);
      }
    })

    global.socket.on('allCheckNewUser', (data) => {
      this.fetchNewConv();
    })

    global.socket.on('connectOne', (data) => {
      if (this.state.NameGroup.length > 0) {
        this.state.NameGroup.map((group) => {
          group.part.map((member) => {
            if (member.id === data.id) {
              this.fetchNewConv();
            }
          })
        })
      }
    })

    global.socket.on('disconnectOne', (data) => {
      if (this.state.NameGroup.length > 0) {
        this.state.NameGroup.map((group) => {
          group.part.map((member) => {
            if (member.id === data.id) {
              this.fetchNewConv();
            }
          })
        })
      }
    })

    const headers = new Headers({
      'Accept': 'application/json',
      'Content-type': 'application/json'
    })

    const display_name = this.props.display_name
    let send = { token: sessionStorage.getItem('token'), display_name: encodeURI(display_name) }
    fetch(settings.defaultSettings.REACT_APP_API_URL + '/chat/chat', { headers, method: 'POST', body: JSON.stringify(send) })
      .then(response => response.json())
      .then(responseJ => {
        this.setState({ NotificationGroup: responseJ.group, NotificationPrivate: responseJ.private })
      })
      .catch(function (error) {
        //console.log(error)
      }) //update on load

    this.next()

    this.fetchNewConv();

    // setInterval(() => {
    //   this.fetchNewConv();
    // }, 30 * 1000) //5 sec
  }


  UNSAFE_componentWillReceiveProps = (nextProps) => {
    if (nextProps.videoPage) {
      if (this.state.room_Id) {
        if (this.props.videoPage) {
          if (document.getElementsByClassName("video")[0]) {
            document.getElementsByClassName("video")[0].classList.add('video-open-chat')
          }
          if (document.getElementsByClassName("nav_bottom")[0]) {
            document.getElementsByClassName("nav_bottom")[0].classList.add('nav_bottom-on-chat')
          }
        }
      }
    }
  }

  componentWillUnMount = () => {

  }

  notification() {
    return (
      <Notification
        ignore={this.state.isShowNotifyBrowser}
        title={this.state.title}
        options={this.state.options}
        timeout={5000}
        onClick={this.handleNotificationOnClick}
      />
    );
  }

  handleNotificationOnClick(e, tag) {
    window.focus();
  }


  handleSearch = e => {
    //eslint-disable-next-line
    this.setState({ searchInput: e.target.value, searchInputRegex: e.target.value.replace(/[\-\[\]\/\{\}\(\)\*\+\?\.\\\^\$\|]/g, "\\$&") })
  }

  handleKeyDownSearch = e => {
    if (e.which === 27) {
      this.setState({ searchInputRegex: '', searchInput: '' })
    }
  }

  render() {
    const heightBody = window.innerHeight - 60 - 50;
    return (
      <>
        {!this.props.chatPage && !this.props.videoPage ? <div className="expand-btn" onClick={() => this.expandContact()}><i className="fa fa-angle-left" aria-hidden="true"></i></div> : ""}
        <div className={
          (this.state.room_Id || this.props.chatPage) && this.props.videoPage && !this.props.chatPage ? 'chat-column chat-column-on-call'
            : (this.state.room_Id || this.props.chatPage) && !this.props.videoPage ? 'chat-column'
              : ""
        }>
          {this.state.room_Id || this.state.isGroupChat ?
            <div className={!this.props.videoPage ? 'chat-group chat-group-no-call' : 'chat-group chat-group-on-call'} >
              {this.createGroupChat()}
              {this.chatFriends()}
              {this.showOneConvGroup()}
              {this.optionConv()}
              <div className={
                this.state.isEmoji && !this.state.isFullHeight ? "emoji-container d-block"
                  : this.state.isEmoji && (this.state.isFullHeight || this.props.videoPage) ? "emoji-container emoji-container-full-height d-block"
                    : "emoji-container"
              }>
                <Picker onClick={this.addEmoji} style={{ width: '290px', height: '360px' }} showPreview={false} showSkinTones={false} />
              </div>
            </div> : ""
          }

          {
            this.props.chatPage ?
              <div className='contact' style={{ minHeight: heightBody }}>
                <div className='switch'>
                  {this.change_tab()}
                </div>
                {
                  (this.state.isFriendTab) ? (
                    <div className="friend-tab">
                      <div className='search-bar'>
                        <div className='allinclude'>
                          <img className='searchpic' src={search} alt='' />
                          <input className='form-control search_zone' type='text' id='search' value={this.state.searchInput} placeholder='Search contacts' onChange={this.handleSearch} onKeyDown={this.handleKeyDownSearch} autoComplete='off' />
                        </div>
                      </div>
                      <div style={{ maxHeight: heightBody - 25 - 50 }} className="list-contact">

                        <div className='friend_zone'>
                          <div className="d-flex group-chat">
                            <div>
                              Friends
                            </div>
                          </div>
                          {this.friends_List()}
                        </div>

                        <div className="group-list">
                          <div className="d-flex group-chat">
                            <div>
                              Groups
                          </div>
                            <div className="ml-auto">
                              <Link to="/menu" onClick={this.showCreateChat.bind(this)}><i className="fa fa-plus-circle fs20" aria-hidden="true"></i></Link>
                            </div>
                          </div>
                          <div className='zone'>
                            {
                              !this.state.searchInputRegex ?
                                this.state.NameGroup.map((conv) => {
                                  let callIds = conv.part.map(val => [val.id, val.status])
                                  let filterSelf = callIds.filter(val => val[0] !== this.props.id)
                                  return (
                                    <div key={conv.roomId}>
                                      <div className={this.state.room_Id === conv.roomId ? 'group-wrapper selectedChat' : 'group-wrapper'}>
                                        <div className="d-flex name-noti-avatar-wrapper" onClick={this.showOne.bind(this, conv.name, conv.roomId)}>
                                          <div className='group-avatar' style={{ background: `url(${defaultGroupAvatar}) no-repeat center `, backgroundSize: "40px" }}></div>
                                          <div className="name-noti">
                                            <div className='group-name'>
                                              <div>{this.showStatusGroup(filterSelf)} {decodeURI(conv.name).trim()}</div>
                                              {conv.callStatus === "OnCall" ? <div className="group-name-on-call">On going call</div> : ''}
                                            </div>
                                            {this.state.notify_group_offline.search(conv.roomId) !== -1 ? (<i className='fa fa-exclamation-circle c-r' id={"g_" + conv.roomId}></i>) : ""}
                                          </div>
                                        </div>
                                        <div className={this.state.room_Id === conv.roomId ? 'group-action-buttons d-flex' : 'group-action-buttons'} >
                                          {conv.callStatus === "OnCall"
                                            ? <i className="fa fa-video-camera video-call-icon group-call" title="Join on going call" aria-hidden="true" onClick={() => this.props.joinOnGoingGroupCall(conv.call_group_id, conv.roomId)}></i>
                                            : <i className="fa fa-video-camera video-call-icon group-call" title="Make a group call" aria-hidden="true" onClick={() => this.props.call(callIds, null, true, conv.name, conv.roomId)}></i>}
                                          <i className="fa fa-times-circle-o group-delete-chat" aria-hidden="true" title="Delete group" onClick={this.deleteConv.bind(this, conv.name, conv.roomId)}></i>
                                        </div>
                                      </div>
                                    </div>
                                  )
                                }) : this.state.NameGroup.filter(group => new RegExp(this.state.searchInputRegex, 'i').test(decodeURI(group.name).trim())).map((conv) => {
                                  let callIds = conv.part.map(val => [val.id, val.status])
                                  let filterSelf = callIds.filter(val => val[0] !== this.props.id)
                                  return (
                                    <div key={conv.roomId}>
                                      <div className={this.state.room_Id === conv.roomId ? 'group-wrapper selectedChat' : 'group-wrapper'}>
                                        <div className="d-flex name-noti-avatar-wrapper" onClick={this.showOne.bind(this, conv.name, conv.roomId)}>
                                          <div className='group-avatar' style={{ background: `url(${defaultGroupAvatar}) no-repeat center `, backgroundSize: "40px" }}></div>
                                          <div className="name-noti">
                                            <div className='group-name'>{this.showStatusGroup(filterSelf)} {decodeURI(conv.name).trim()}</div>
                                            {this.state.notify_group_offline.search(conv.roomId) !== -1 ? (<i className='fa fa-exclamation-circle c-r' id={"g_" + conv.roomId}></i>) : ""}
                                          </div>
                                        </div>
                                        <div className={this.state.room_Id === conv.roomId ? 'group-action-buttons d-flex' : 'group-action-buttons'} >
                                          {conv.callStatus === "OnCall"
                                            ? <i className="fa fa-video-camera video-call-icon group-call" title="Join on going call" aria-hidden="true" onClick={() => this.props.joinOnGoingGroupCall(conv.call_group_id, conv.roomId)}></i>
                                            : <i className="fa fa-video-camera video-call-icon group-call" title="Make a group call" aria-hidden="true" onClick={() => this.props.call(callIds, null, true, conv.name, conv.roomId)}></i>}
                                          <i className="fa fa-times-circle-o group-delete-chat" aria-hidden="true" onClick={this.deleteConv.bind(this, conv.name, conv.roomId)}></i>
                                        </div>
                                      </div>
                                    </div>
                                  )
                                })
                            }
                          </div>
                        </div>
                      </div>
                    </div>
                  ) : (this.state.isInvitationTab) ? (
                    <div className="invitation-tab" >
                      <div className='search-bar'>
                        {this.showSearchFriend()}
                      </div>
                      <div className="invit-list" style={{ maxHeight: heightBody - 60 - 25 }}>
                        {this.invitations()}
                      </div>
                    </div>
                  ) : ' '
                }
              </div> : ""}
        </div>
        {this.showConvGroup()}
        {this.notification()}
        {this.infoFriend()}
      </>
    )
  }
}

const mapStateToProps = (state) => {
  return {
    id: state.myProfileReducer.id,
    first_name: decodeURI(state.myProfileReducer.first_name),
    last_name: decodeURI(state.myProfileReducer.last_name),
    display_name: decodeURI(state.myProfileReducer.display_name),
    avatar: state.myProfileReducer.avatar,
    email: state.myProfileReducer.email,
    status: state.myProfileReducer.status,
    friends_list: state.myProfileReducer.friends_list,
    invitations_list: state.myProfileReducer.invitations_list,
    error_acceptInvitation: state.myProfileReducer.error_acceptInvitation,
    error_refuseInvitation: state.myProfileReducer.error_refuseInvitation,
    videoPage: state.pageReducer.videoPage,
    chatPage: state.pageReducer.chatPage,
    admin: state.authorizationReducer.admin,
  }
}

export default connect(mapStateToProps)(Chat)
