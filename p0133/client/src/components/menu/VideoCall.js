//Libiraries
import React, { Fragment } from 'react'
import { connect } from 'react-redux'
import 'socket.io-client'
import { toast } from 'react-toastify';
import Sound from 'react-sound';
import { Button, Modal, ModalBody, ModalFooter } from 'reactstrap'

//Actions
import handlePage from '../../actions/handlePageActions'
import fetchUpdateFriendsList from '../../actions/UpdateFriendsActions';
import fetchEditMyStatus from '../../actions/EditStatusActions';
import fetchMyProfile from '../../actions/MyProfileActions';

//Components
import Chat from './Chat'
import NavMenu from './NavMenu'
import OnCallButtons from './OnCallButtons'

//Others
import settings from '../../config';
import '../styles/css/VideoCall.css'
import '../styles/css/Chat.css'
import defaultAvatar from '../styles/images/avatar-icon.png'
import cameraNotFoundBg from '../styles/images/camera-not-found-bg.jpg'
import ringtone from '../styles/sound/ringtone.mp3'


import cancel from '../styles/images/cancel.svg';
import gridLayout from '../styles/images/grid-layout.svg';
import presenterLayout from '../styles/images/presenter-layout.svg';

class VideoCall extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      localStream: null, remoteStream: null, isAddList: false, isModalCall: false, bodyMessage: "", idFrom: 0, idCallTo: 0, joinGroupCall: false,
      groupCallBodyMessage: '', idFriends: null, declineCallTimeOut: "", groupDialing: false, callInterval: '', dialingTimeout: '', title: '', call_group_chat_room_id: '', call_group_id: '',
      sharingScreen: false, friendSharingScreen: false, isMuteAll: false, isMuteMic: false, isMuteWebcam: false, userInCall: [], gridLayout: true, presenterLayout: false
    }

    this.rtcPeerConnection = []
    this.iceServers = {
      iceServers: [{
        urls: ["stun:stun.l.google.com:19302"]
      }, {
        username: "another_user",
        credential: "another_password",
        urls: [
          "turn:117.6.135.148:8579?transport=udp",
          "turn:117.6.135.148:8579?transport=tcp",
        ]
      }]
    }

    this.el_localVideo = React.createRef();
  }

  toggleModalJoinCall = (data) => {

  }

  DeclineCall = async (isMissCall) => {
    if (this.state.isModalCall) {
      global.socket.emit('refuseCall', { idTo: this.state.idFrom, token: sessionStorage.getItem('token'), message: 'Refuse' })
      document.title = settings.defaultSettings.REACT_APP_DOCUMENT_TITLE;
    }
    window.clearTimeout(this.state.declineCallTimeOut)
    await this.setInitialState()
  }

  DeclineGroupDialing = async () => {
    global.socket.emit('refuseGroupDialing', { idTo: this.state.idFrom, token: sessionStorage.getItem('token'), message: 'Refuse' })
    document.title = settings.defaultSettings.REACT_APP_DOCUMENT_TITLE;
    window.clearTimeout(this.state.declineCallTimeOut)
    await this.setInitialState()
  }

  JoinGroupDialing = async () => {
    await this.getMediaToJoinGroupDialing(this.state.call_group_id, this.state.call_group_chat_room_id);
    document.title = settings.defaultSettings.REACT_APP_DOCUMENT_TITLE;
    window.clearTimeout(this.state.declineCallTimeOut)
    await this.setState({ isAddList: false, isModalCall: false, idFriends: '', idFrom: '', groupDialing: false })
  }

  JoinCall = async () => {
    await this.getMediaToAnswer(this.state.idFrom)
    document.title = settings.defaultSettings.REACT_APP_DOCUMENT_TITLE;
    await this.setState({ isAddList: false, isModalCall: false, idFriends: null, idFrom: null })
    window.clearTimeout(this.state.declineCallTimeOut)
  }

  JoinGroupCall = async () => {
    //console.log(this.state.idFriends)
    await this.getMediaToJoin(this.state.idFriends);
    document.title = settings.defaultSettings.REACT_APP_DOCUMENT_TITLE;
    await this.setState({ isAddList: false, isModalCall: false, idFriends: null, groupCallBodyMessage: '', idFrom: null, joinGroupCall: false });
    window.clearTimeout(this.state.declineCallTimeOut)
  }

  DeclineGroupCall = async () => {
    global.socket.emit('refuseGroupCall', { idFriendsTo: this.state.idFriends, token: sessionStorage.getItem('token') });
    document.title = settings.defaultSettings.REACT_APP_DOCUMENT_TITLE;
    window.clearTimeout(this.state.declineCallTimeOut)
    await this.setInitialState()
  }

  call = async (id, status, isGroupCall = false, groupName = "", call_group_chat_room_id = '') => {  //callFunction
    if (this.props.videoPage) {
      toast.warn("You are currently in a call!", {
        position: toast.POSITION.TOP_RIGHT,
        toastId: "already-in-call"
      });
    } else {
      if (!isGroupCall) {
        if (status === 'Offline' || status === undefined) {
          toast.warn("This user is currently offline!", {
            position: toast.POSITION.TOP_RIGHT,
            toastId: "call-offline-user"
          });
        } else {
          await this.setState({ idCallTo: id })
          this.getMediaToCall(id)
        }
      } else {
        let filterOnlineAndSelf = id.filter(val => val[1] === "Online").map(val => val[0]).filter(val => val !== this.props.id);
        let allOnlineMembers = id.filter(val => val[1] === "Online").map(val => val[0]);
        if (filterOnlineAndSelf.length > 0) {
          //console.log("group dialing to: ", filterOnlineAndSelf);
          await this.setState({ call_group_chat_room_id: call_group_chat_room_id })
          await this.getMediaToGroupCall(filterOnlineAndSelf, groupName, allOnlineMembers, call_group_chat_room_id);
        } else {
          toast.warn("No one is online!", {
            position: toast.POSITION.TOP_RIGHT,
            toastId: "everyone-offline"
          });
        }
      }
      this.checkUserInCall()
    }
  }

  endCall = async () => {
    if (this.state.shareScreen) {
      for (let x = 0; x < this.rtcPeerConnection.length; x++) {
        global.socket.emit('sharing', { idTo: this.rtcPeerConnection[x].id, sharing: false })
      }
    }
    let flterDuplicate = this.rtcPeerConnection.filter((val, idx, arr) => {
      return idx === arr.findIndex((value) => (
        value.id === val.id
      ))
    })
    if (this.rtcPeerConnection.length > 0) {
      if (this.state.call_group_id) {
        for (let i = 0; i < flterDuplicate.length; i++) {
          console.log(flterDuplicate[i])
          await flterDuplicate[i].peer.close()
        }
        await global.socket.emit('endCall', { call_group_id: this.state.call_group_id, token: sessionStorage.getItem('token') })
        global.socket.emit('validation', { message: 'update_group', roomId: this.state.call_group_chat_room_id })
        await this.setState({ call_group_id: '', call_group_chat_room_id: '' })
      } else {
        for (let i = 0; i < flterDuplicate.length; i++) {
          //console.log(flterDuplicate[x].id)
          global.socket.emit('endCall', { idTo: flterDuplicate[i].id, token: sessionStorage.getItem('token') })
          flterDuplicate[i].peer.close()
        }
      }
    } else {
      if (this.state.call_group_id) {
        await global.socket.emit('endCall', { call_group_id: this.state.call_group_id, token: sessionStorage.getItem('token') })
        global.socket.emit('validation', { message: 'update_group', roomId: this.state.call_group_chat_room_id })
      } else {
        global.socket.emit('endCall', { idTo: this.state.idCallTo, token: sessionStorage.getItem('token') })
      }
    }

    if (this.state.localStream) {
      await this.state.localStream.getTracks().forEach(async function (track) {
        await track.stop()
      })
    }
    this.rtcPeerConnection = []
    await this.props.dispatch(handlePage(this.props.callPage, false, true))
    window.clearTimeout(this.state.dialingTimeout)
    window.clearInterval(this.state.callInterval)
    await this.setInitialState()
  }

  isAddList = async () => {
    await this.setState(({ isAddList }) => ({ isAddList: !isAddList }));
  }

  muteAll = async () => {
    for (var x = 0; x < this.rtcPeerConnection.length; x++) {
      document.getElementById(this.rtcPeerConnection[x].id).muted = !document.getElementById(this.rtcPeerConnection[x].id).muted
    }
    await this.setState({ isMuteAll: !this.state.isMuteAll })
  }

  muteMic = async () => {
    //console.log('muteMic')
    if (this.props.videoPage) {
      this.state.localStream.getAudioTracks()[0].enabled = !(this.state.localStream.getAudioTracks()[0].enabled)
    }
    await this.setState({ isMuteMic: !this.state.isMuteMic })
  }

  muteWebcam = async () => {
    //console.log('muteWebcam')
    if (this.props.videoPage && this.state.localStream.getVideoTracks()[0]) {
      this.state.localStream.getVideoTracks()[0].enabled = !(this.state.localStream.getVideoTracks()[0].enabled)
    }
    await this.setState({ isMuteWebcam: !this.state.isMuteWebcam })
  }

  startSharingScreen = async () => {
    try {
      let screen = await navigator.mediaDevices.getDisplayMedia({ audio: true, video: true });
      let stream = await navigator.mediaDevices.getUserMedia({ audio: true, video: false });
      let audioTrack = stream.getAudioTracks()[0];
      screen.addTrack(audioTrack)
      if (this.el_localVideo && this.el_localVideo.current) {
        this.el_localVideo.current.srcObject = screen;
        console.log("run this")
      }
      for (let y = 0; y < this.rtcPeerConnection.length; y++) {
        await this.rtcPeerConnection[y].peer.removeStream(this.state.localStream)
        await this.setState({ localStream: screen })
        await this.rtcPeerConnection[y].peer.addStream(screen)
        global.socket.emit('sharing', { idTo: this.rtcPeerConnection[y].id, sharing: true })
        await this.rtcPeerConnection[y].peer.createOffer(this.setLocalAndOfferRenegotiate.bind(this, this.rtcPeerConnection[y].id), (e) => console.log(e))
        await this.setState({ sharingScreen: true })
        screen.getVideoTracks()[0].addEventListener('ended', () => { this.endSharingScreen() })
      }
      await this.setState({ sharingScreen: true, isMuteMic: false, isMuteWebcam: false })
    } catch (e) {
      console.log(e)
      this.handleError(e.name)
      this.endSharingScreen()
    }
  }

  endSharingScreen = async () => {
    try {
      let stream;
      try {
        stream = await navigator.mediaDevices.getUserMedia({ audio: true, video: true })
      } catch (e) {
        stream = await navigator.mediaDevices.getUserMedia({ audio: true, video: false })
      }
      if (this.el_localVideo && this.el_localVideo.current) {
        this.el_localVideo.current.srcObject = stream;
      }
      for (var x = 0; x < this.rtcPeerConnection.length; x++) {
        await this.rtcPeerConnection[x].peer.removeStream(this.state.localStream)
        await this.setState({ localStream: stream })
        await this.rtcPeerConnection[x].peer.addStream(stream)
        global.socket.emit('sharing', { idTo: this.rtcPeerConnection[x].id, sharing: false })
        await this.rtcPeerConnection[x].peer.createOffer(this.setLocalAndOfferRenegotiate.bind(this, this.rtcPeerConnection[x].id), (e) => console.log(e))
      }
      await this.setState({ sharingScreen: false, isMuteMic: false, isMuteWebcam: false })
    } catch (e) {
      this.handleError(e.name)
    }
  }
  sharingScreen = async () => {
    if (this.state.localStream) {
      await this.state.localStream.getTracks().forEach(async function (track) {
        await track.stop()
      })
    }
    if (this.state.sharingScreen) {
      this.endSharingScreen();
    } else {
      this.startSharingScreen();
    }
  }

  add = async (idFriend) => {
    //console.log("add")
    await this.setState({ isAddList: false })
    var idFriends = []
    this.rtcPeerConnection.forEach(connection => {
      idFriends.push(connection.id)
    });

    //console.log(idFriends)
    if (idFriends.indexOf(idFriend) === -1) {//test if already in the call
      //console.log('list of friends send to the joiner', idFriends)
      global.socket.emit('add', { idTo: idFriend, token: sessionStorage.getItem('token'), idFriends: idFriends, call_group_id: this.state.call_group_id, call_group_chat_room_id: this.state.call_group_chat_room_id })
    } else {
      toast.warn("This user is already in the call", {
        position: toast.POSITION.TOP_RIGHT
      });
    }
  }

  hasUserMedia = () => {
    return !!(navigator.mediaDevices.getUserMedia);
  }

  handleError = (error) => {
    let message;
    switch (error) {
      case 'NotFoundError':
        message = 'Please setup your webcam and your microphone.';
        break;
      case 'SourceUnavailableError':
        message = 'Your webcam is busy';
        break;
      case 'PermissionDeniedError':
      case 'NotAllowedError':
      case 'SecurityError':
        message = 'Device permission denied!';
        break;
      default:
        message = 'Sorry! Some error occurred.'
        break;
    }
    toast.error(message, {
      position: toast.POSITION.TOP_RIGHT
    });
  }

  getMediaToCall = async (id) => {
    let stream;
    if (this.hasUserMedia()) {
      try {
        stream = await navigator.mediaDevices.getUserMedia({ video: { facingMode: "user" }, audio: true });
        console.log(stream)
      } catch (e) {
        console.log(e)
        try {
          stream = await navigator.mediaDevices.getUserMedia({ video: false, audio: true });
        } catch (e) {
          this.handleError(e.name)
        }
      }
      if (stream) {
        await this.props.dispatch(handlePage(false, true, false));
        await this.setState({ localStream: stream });
        if (this.el_localVideo && this.el_localVideo.current) {
          this.el_localVideo.current.srcObject = stream;
        }
        global.socket.emit('invitCall', { idFriend: id, token: sessionStorage.getItem('token') });
      }
    } else {
      toast.error("WebRTC is not supported by your web browser or Operating system version", {
        position: toast.POSITION.TOP_RIGHT
      });
    }
  }

  getMediaToGroupCall = async (id, groupName, groupMembers, call_group_chat_room_id) => {
    let stream;
    if (this.hasUserMedia()) {
      try {
        stream = await navigator.mediaDevices.getUserMedia({ video: { facingMode: "user" }, audio: true });
      } catch (e) {
        try {
          stream = await navigator.mediaDevices.getUserMedia({ video: false, audio: true });
        } catch (e) {
          this.handleError(e.name)
        }
      }
      if (stream) {
        await this.props.dispatch(handlePage(false, true, false))
        await this.setState({ localStream: stream })
        if (this.el_localVideo && this.el_localVideo.current) {
          this.el_localVideo.current.srcObject = stream;
        }
        let call_group_id = Math.random().toString(36).substring(2, 15) + Math.random().toString(36).substring(2, 15);
        global.socket.emit('invitGroupDialing', { idFriend: id, token: sessionStorage.getItem('token'), groupName: groupName, groupMembers: groupMembers, call_group_chat_room_id: call_group_chat_room_id, call_group_id: call_group_id })
        await this.setState({ call_group_id: call_group_id, call_group_chat_room_id: call_group_chat_room_id })
      }
    } else {
      toast.error("WebRTC is not supported by your web browser or Operating system version", {
        position: toast.POSITION.TOP_RIGHT
      });
    }
  }

  getMediaToAnswer = async (idFrom) => {
    let stream;
    if (this.hasUserMedia()) {
      try {
        stream = await navigator.mediaDevices.getUserMedia({ video: { facingMode: "user" }, audio: true });
      } catch (e) {
        try {
          stream = await navigator.mediaDevices.getUserMedia({ video: false, audio: true });
        } catch (e) {
          stream = null;
          document.title = settings.defaultSettings.REACT_APP_DOCUMENT_TITLE;
          this.setState({ isModalCall: false })
          global.socket.emit('refuseCall', { idTo: this.state.idFrom, token: sessionStorage.getItem('token'), message: 'Refuse_NotDevice' })
          this.handleError(e.name)
        }
      }
      if (stream) {
        await this.props.dispatch(handlePage(false, true, false))
        document.title = settings.defaultSettings.REACT_APP_DOCUMENT_TITLE;
        await this.setState({ localStream: stream, isModalCall: false })
        if (this.el_localVideo && this.el_localVideo.current) this.el_localVideo.current.srcObject = stream
        global.socket.emit('ready', { idTo: idFrom, token: sessionStorage.getItem('token'), display_name: this.props.display_name })
        this.checkInCallInterval()
      }
    } else {
      toast.error("WebRTC is not supported by your web browser or Operating system version", {
        position: toast.POSITION.TOP_RIGHT
      });
      global.socket.emit('refuseCall', { idTo: this.state.idFrom, token: sessionStorage.getItem('token'), message: 'Refuse_NotDevice' })
    }
  }

  getMediaToJoin = async (idFriends) => {
    let stream;
    if (this.hasUserMedia()) {
      try {
        stream = await navigator.mediaDevices.getUserMedia({ video: { facingMode: "user" }, audio: true });
      } catch (e) {
        try {
          stream = await navigator.mediaDevices.getUserMedia({ video: false, audio: true });
        } catch (e) {
          this.handleError(e.name)
        }
      }
      if (stream) {
        await this.props.dispatch(handlePage(false, true, false))
        await this.setState({ localStream: stream })
        if (this.el_localVideo && this.el_localVideo.current) this.el_localVideo.current.srcObject = stream
        if (this.state.call_group_id) {
          global.socket.emit('readyGroupDialing', { call_group_id: this.state.call_group_id, call_group_chat_room_id: this.state.call_group_chat_room_id, token: sessionStorage.getItem('token'), display_name: this.props.display_name })
        } else {
          for (var x = 0; x < idFriends.length; x++) {
            global.socket.emit('ready', { idTo: idFriends[x], token: sessionStorage.getItem('token'), display_name: this.props.display_name })
          }
        }
        this.checkInCallInterval()
      }
    } else {
      toast.error("WebRTC is not supported by your web browser or Operating system version", {
        position: toast.POSITION.TOP_RIGHT
      });
      global.socket.emit('refuseCall', { idTo: this.state.idFrom, token: sessionStorage.getItem('token'), message: 'Refuse_NotDevice' })
    }
  }

  getMediaToJoinGroupDialing = async (call_group_id, call_group_chat_room_id) => {
    let stream;
    if (this.hasUserMedia()) {
      try {
        stream = await navigator.mediaDevices.getUserMedia({ video: { facingMode: "user" }, audio: true });
      } catch (e) {
        try {
          stream = await navigator.mediaDevices.getUserMedia({ video: false, audio: true });
        } catch (e) {
          this.handleError(e.name)
        }
      }
      if (stream) {
        await this.props.dispatch(handlePage(false, true, false))
        await this.setState({ localStream: stream })
        await this.setState({ call_group_id: call_group_id, call_group_chat_room_id: call_group_chat_room_id })
        if (this.el_localVideo && this.el_localVideo.current) this.el_localVideo.current.srcObject = stream
        global.socket.emit('readyGroupDialing', { call_group_id: call_group_id, call_group_chat_room_id: call_group_chat_room_id, token: sessionStorage.getItem('token'), display_name: this.props.display_name })
        this.checkInCallInterval()
      }
    } else {
      toast.error("WebRTC is not supported by your web browser or Operating system version", {
        position: toast.POSITION.TOP_RIGHT
      });
      global.socket.emit('refuseCall', { idTo: this.state.idFrom, token: sessionStorage.getItem('token'), message: 'Refuse_NotDevice' })
    }
  }

  checkTotalMembersVideoCall = () => {
    let totalMembers = document.getElementsByClassName('video-remote-container');
    let videoContainer = document.getElementById('video_container')
    if (this.state.gridLayout) {
      if (totalMembers && videoContainer) {
        videoContainer.classList.remove('video-container-grid')
        for (let i = 0; i < totalMembers.length; i++) {
          totalMembers[i].classList.remove("spectator-video")
          totalMembers[i].classList.remove("presenter-video")
        }
        if (totalMembers.length === 1) {
          totalMembers[0].classList.remove("friendVideo2")
          totalMembers[0].classList.remove("friendVideo3")
          totalMembers[0].classList.remove("friendVideo4")
          totalMembers[0].classList.remove("friendVideo4to8")
          totalMembers[0].classList.remove("friendVideo8to12")
        } else if (totalMembers.length === 2) {
          for (let i = 0; i < totalMembers.length; i++) {
            totalMembers[i].classList.add("friendVideo2")
            totalMembers[i].classList.remove("friendVideo3")
            totalMembers[i].classList.remove("friendVideo4")
            totalMembers[i].classList.remove("friendVideo4to8")
            totalMembers[i].classList.remove("friendVideo8to12")
          }
        } else if (totalMembers.length === 3) {
          for (let i = 0; i < totalMembers.length; i++) {
            totalMembers[i].classList.add("friendVideo3")
            totalMembers[i].classList.remove("friendVideo2")
            totalMembers[i].classList.remove("friendVideo4")
            totalMembers[i].classList.remove("friendVideo4to8")
            totalMembers[i].classList.remove("friendVideo8to12")
          }
        } else if (totalMembers.length === 4) {
          for (let i = 0; i < totalMembers.length; i++) {
            totalMembers[i].classList.add("friendVideo4")
            totalMembers[i].classList.remove("friendVideo2")
            totalMembers[i].classList.remove("friendVideo3")
            totalMembers[i].classList.remove("friendVideo4to8")
            totalMembers[i].classList.remove("friendVideo8to12")
          }
        } else if (totalMembers.length > 4 && totalMembers.length <= 8) {
          for (let i = 0; i < totalMembers.length; i++) {
            totalMembers[i].classList.add("friendVideo4to8")
            totalMembers[i].classList.remove("friendVideo2")
            totalMembers[i].classList.remove("friendVideo3")
            totalMembers[i].classList.remove("friendVideo4")
            totalMembers[i].classList.remove("friendVideo8to12")
          }
        } else if (totalMembers.length > 8 && totalMembers.length <= 12) {
          for (let i = 0; i < totalMembers.length; i++) {
            totalMembers[i].classList.add("friendVideo8to12")
            totalMembers[i].classList.remove("friendVideo2")
            totalMembers[i].classList.remove("friendVideo3")
            totalMembers[i].classList.remove("friendVideo4")
            totalMembers[i].classList.remove("friendVideo4to8")
          }
        }
        this.moveSpectatorVideo()
      }
    } else {
      if (totalMembers) {
        for (var i = 0; i < totalMembers.length; i++) {
          totalMembers[i].classList.remove("friendVideo8to12")
          totalMembers[i].classList.remove("friendVideo2")
          totalMembers[i].classList.remove("friendVideo3")
          totalMembers[i].classList.remove("friendVideo4")
          totalMembers[i].classList.remove("friendVideo4to8")
        }
        let hasPresenter = false;
        for (let i = 0; i < totalMembers.length; i++) {
          if (totalMembers[i].classList.contains("presenter-video")) {
            hasPresenter = true
          }
        } //check if has presenter

        if (!hasPresenter) { //if not, add one presenter, add spectator to all  others
          console.log("addpresenter")
          totalMembers[0].classList.remove("spectator-video")
          totalMembers[0].classList.add("presenter-video")
          for (let i = 1; i < totalMembers.length; i++) {
            totalMembers[i].classList.add("spectator-video")
          }
        } else { //if yes, add spectator to all others excepter presenter
          for (let i = 1; i < totalMembers.length; i++) {
            if (!totalMembers[i].classList.contains('presenter-video')) {
              totalMembers[i].classList.add("spectator-video")
            }
          }
        }
        this.moveSpectatorVideo()
      }
    }
  }

  setPresenterVideo = (id) => {
    let totalMembers = document.getElementsByClassName('video-remote-container');
    let spectatorContainer = document.getElementById('video-spectator-container')
    let presenterContainer = document.getElementById('video-presenter-container')
    let videoContainer = document.getElementById('video_container')
    if (this.state.presenterLayout) {
      for (let i = 0; i < totalMembers.length; i++) {
        if (totalMembers[i].id === `container_${id}`) {
          totalMembers[i].classList.remove("spectator-video")
          totalMembers[i].classList.add("presenter-video")
        } else {
          totalMembers[i].classList.remove("presenter-video")
          totalMembers[i].classList.add("spectator-video")
        }
      }
      this.moveSpectatorVideo()
    }
  }

  moveSpectatorVideo = () => {
    let totalMembers = document.getElementsByClassName('video-remote-container');
    let spectatorContainer = document.getElementById('video-spectator-container')
    let presenterContainer = document.getElementById('video-presenter-container')
    let videoContainer = document.getElementById('video_container')
    while (spectatorContainer.childNodes.length > 0) {
      videoContainer.appendChild(spectatorContainer.childNodes[0])
    }
    while (presenterContainer.childNodes.length > 0) {
      videoContainer.appendChild(presenterContainer.childNodes[0])
    }
    if (this.state.presenterLayout) {
      while (videoContainer.childNodes.length > 0) {
        if (videoContainer.childNodes[0].classList.contains("spectator-video")) {
          spectatorContainer.appendChild(videoContainer.childNodes[0])
        } else {
          presenterContainer.appendChild(videoContainer.childNodes[0])
        }
      }
    } else {
      while (spectatorContainer.childNodes.length > 0) {
        videoContainer.appendChild(spectatorContainer.childNodes[0])
      }
      while (presenterContainer.childNodes.length > 0) {
        videoContainer.appendChild(presenterContainer.childNodes[0])
      }
    }
  }

  checkUserInCall = async () => {
    let dialingTimeout = setTimeout(async () => {
      if (this.rtcPeerConnection.length < 1) {
        if (this.state.localStream) {
          await this.state.localStream.getTracks().forEach(async function (track) {
            await track.stop()
          })
        }
        this.rtcPeerConnection = []
        await this.props.dispatch(handlePage(this.props.callPage, false, true))
        window.clearInterval(this.state.callInterval)
        toast.warn('No answer', {
          position: toast.POSITION.TOP_RIGHT
        });
        await this.setState({ localStream: null, remoteStream: null, isAddList: false, idCallTo: 0 });
      }
    }, 22000)
    this.checkInCallInterval()
    await this.setState({ dialingTimeout: dialingTimeout });
  }

  checkInCallInterval = async () => {
    let inCallInterval = setInterval(async () => {
      console.log(this.rtcPeerConnection)
      if (this.rtcPeerConnection.length > 0) {
        let checkConnectionState = this.rtcPeerConnection.map(val => ({ connectionStatus: val.peer.iceConnectionState, id: val.id }))
        for (let i = 0; i < checkConnectionState.length; i++) {
          if (checkConnectionState[i].connectionStatus === "disconnected") {
            this.removeChildVideoNode(checkConnectionState[i].id)
          }
        }
        this.rtcPeerConnection = this.rtcPeerConnection.filter(val => val.peer.iceConnectionState !== "disconnected")
        if (this.rtcPeerConnection.length === 0) {
          if (this.state.localStream) {
            await this.state.localStream.getTracks().forEach(async function (track) {
              await track.stop()
            })
            await this.endCall()
            window.clearInterval(this.state.callInterval)
            window.clearTimeout(this.state.dialingTimeout)
          }
        }
        console.log(checkConnectionState)
      }
      this.checkTotalMembersVideoCall()
    }, 5000)
    await this.setState({ callInterval: inCallInterval });
  }

  joinOnGoingGroupCall = async (call_group_id, room_id) => {
    if (this.props.videoPage) {
      toast.warn("You are currently in a call!", {
        position: toast.POSITION.TOP_RIGHT,
        toastId: "already-in-call"
      });
    } else {
      await this.getMediaToJoinGroupDialing(call_group_id, room_id)
    }
  }

  gridLayoutSwitch = async () => {
    await this.setState({ gridLayout: true, presenterLayout: false })
    this.checkTotalMembersVideoCall()
  }

  presenterLayoutSwitch = async () => {
    await this.setState({ gridLayout: false, presenterLayout: true })
    this.checkTotalMembersVideoCall()
  }

  setInitialState = async () => {
    await this.setState({
      localStream: null, remoteStream: null, isAddList: false, isModalCall: false, bodyMessage: "", idFrom: 0, idCallTo: 0, joinGroupCall: false,
      groupCallBodyMessage: '', idFriends: null, declineCallTimeOut: "", groupDialing: false, callInterval: '', dialingTimeout: '', title: '', call_group_chat_room_id: '', call_group_id: '',
      sharingScreen: false, friendSharingScreen: false, isMuteAll: false, isMuteMic: false, isMuteWebcam: false, userInCall: [], gridLayout: true, presenterLayout: false
    })
  }

  removeChildVideoNode = (idFrom) => {
    if (document.getElementById('video_container').contains(document.getElementById(`container_${idFrom}`))) {
      document.getElementById('video_container').removeChild(document.getElementById(`container_${idFrom}`))
    }
    if (document.getElementById('video-presenter-container').contains(document.getElementById(`container_${idFrom}`))) {
      document.getElementById('video-presenter-container').removeChild(document.getElementById(`container_${idFrom}`))
    }
    if (document.getElementById('video-spectator-container').contains(document.getElementById(`container_${idFrom}`))) {
      document.getElementById('video-spectator-container').removeChild(document.getElementById(`container_${idFrom}`))
    }
  }
  componentDidMount = () => {

    global.socket.on('invitCall', async (data) => {
      if (this.props.videoPage) {
        toast.info(decodeURI(data.displayName) + ' try to reach you', {
          position: toast.POSITION.TOP_RIGHT
        });
        global.socket.emit('refuseCall', { idTo: data.idFrom, token: sessionStorage.getItem('token'), message: 'already in a call' })
      } else {
        document.title = `${decodeURI(data.displayName)} is calling`
        await this.setState({ bodyMessage: decodeURI(data.displayName) + ' want to contact you', isModalCall: true, idFrom: data.idFrom })
        this.toggleModalJoinCall(data)
        var declineTimeout = setTimeout(() => {
          if (this.state.joinGroupCall) {
            this.DeclineGroupCall()
          } else if (this.state.groupDialing) {
            this.DeclineGroupDialing()
          } else {
            this.DeclineCall(true)
          }
        }, 20000)
        await this.setState({ declineCallTimeOut: declineTimeout })
      }
    })

    global.socket.on('invitGroupDialing', async (data) => {
      await this.setState({ call_group_id: data.call_group_id, call_group_chat_room_id: data.call_group_chat_room_id })
      let filterSelf = data.groupMembers.filter(val => val !== this.props.id)
      if (this.props.videoPage) {
        toast.info(decodeURI(data.groupName) + ' try to reach you', {
          position: toast.POSITION.TOP_RIGHT
        });
        global.socket.emit('refuseCall', { idTo: data.idFrom, token: sessionStorage.getItem('token'), message: 'already in a call' })
        await this.setState({ call_group_id: '', call_group_chat_room_id: '' })
      } else {
        document.title = `${decodeURI(data.groupName)} is calling`;
        await this.setState({ bodyMessage: decodeURI(data.groupName) + ' want to contact you', isModalCall: true, groupDialing: true, idFrom: data.idFrom, idFriends: filterSelf })
        this.toggleModalJoinCall(data)
        var declineTimeout = setTimeout(() => {
          if (this.state.groupDialing) {
            this.DeclineGroupDialing()
          }
        }, 20000)
        await this.setState({ declineCallTimeOut: declineTimeout })
      }
    })

    global.socket.on('refuseCall', async (data) => {
      const event = new CustomEvent('remove_oncall_student', { detail: data.idFrom })
      document.dispatchEvent(event)
      if (data.message === 'Refuse') {
        toast.warn(decodeURI(data.displayName) + ' did not answer your call', {
          position: toast.POSITION.TOP_RIGHT
        });
      } else if (data.message === 'Refuse_NotDevice') {
        toast.warn(decodeURI(data.displayName) + ' device not supported', {
          position: toast.POSITION.TOP_RIGHT
        });
      } else {
        toast.warn(decodeURI(data.displayName) + ' is ' + data.message, {
          position: toast.POSITION.TOP_RIGHT
        });
      }

      if (this.state.localStream) {
        await this.state.localStream.getTracks().forEach(function (track) {
          track.stop()
        })
        if (this.el_localVideo && this.el_localVideo.current) {
          this.el_localVideo.current.srcObject = null;
        }
      }
      window.clearInterval(this.state.callInterval)
      window.clearTimeout(this.state.dialingTimeout)
      this.props.dispatch(handlePage(this.props.callPage, false, true))
      await this.setState({ localStream: null })
    })

    global.socket.on('ready', async (data) => {
      console.log("ready", data.idFrom)
      try {
        window.clearTimeout(this.state.dialingTimeout)
        await this.rtcPeerConnection.push({ peer: new RTCPeerConnection(this.iceServers), id: data.idFrom })
        var currentConnection = await this.rtcPeerConnection[this.rtcPeerConnection.map(index => index.id).indexOf(data.idFrom)].peer
        console.log(currentConnection)
        currentConnection.onicecandidate = await this.onIceCandidate.bind(this, data.idFrom)
        currentConnection.onaddstream = await this.onTrack.bind(this, data.idFrom, data.display_name)
        console.log("ready", "start add track")
        await this.state.localStream.getTracks().forEach(async (track) => {
          await currentConnection.addTrack(track, this.state.localStream)
        })
        console.log("ready", "add track end, start create offfer")
        await currentConnection.createOffer(this.setLocalAndOffer.bind(this, data.idFrom), (e) => console.log(e))
        global.socket.emit('validation', { message: 'update_group', roomId: this.state.call_group_chat_room_id })
      } catch (e) {

      }
    })

    global.socket.on('offer', async (data) => {
      console.log('offer data', data)
      await this.rtcPeerConnection.push({ peer: new RTCPeerConnection(this.iceServers), id: data.idFrom })
      var currentConnection = await this.rtcPeerConnection[this.rtcPeerConnection.map(index => index.id).indexOf(data.idFrom)].peer
      console.log('offer current connection', currentConnection)
      currentConnection.onicecandidate = await this.onIceCandidate.bind(this, data.idFrom)
      currentConnection.onaddstream = await this.onTrack.bind(this, data.idFrom, data.display_name)
      console.log('offer gettrack')
      await this.state.localStream.getTracks().forEach(async (track) => {
        await currentConnection.addTrack(track, this.state.localStream)
      })
      console.log('offer gettrack end, start setRemoteDescription and create answer')
      await currentConnection.setRemoteDescription(data.sdp)
      await currentConnection.createAnswer(this.setLocalAndAnswer.bind(this, data.idFrom), (e) => console.log(e))
      console.log('offer gettrack end, start setRemoteDescription and create answer end')
    })

    global.socket.on('offerRenegotiate', async (data) => {
      var currentConnection = await this.rtcPeerConnection[this.rtcPeerConnection.map(index => index.id).indexOf(data.idFrom)].peer
      this.removeChildVideoNode(data.idFrom)
      currentConnection.onaddstream = this.onTrack.bind(this, data.idFrom, data.display_name)
      await this.state.localStream.getTracks().forEach(async (track) => {
        if (!this.state.friendSharingScreen && !this.state.localStream) {
          await currentConnection.addTrack(track, this.state.localStream)
        }
      })
      await currentConnection.setRemoteDescription(data.sdp)
      await currentConnection.createAnswer(this.setLocalAndAnswer.bind(this, data.idFrom), (e) => console.log(e))
    })


    global.socket.on('answer', async (data) => {
      global.socket.emit('join_call_room', { callRoom: data.callRoom, token: sessionStorage.getItem('token') })
      console.log("answer data", data)
      if (this.rtcPeerConnection[this.rtcPeerConnection.map(index => index.id).indexOf(data.idFrom)]) {
        console.log("answer setRemoteDescription")
        var currentConnection = await this.rtcPeerConnection[this.rtcPeerConnection.map(index => index.id).indexOf(data.idFrom)].peer
        await currentConnection.setRemoteDescription(data.sdp)
        await this.setState({ isMuteAll: false })
      }
      this.checkTotalMembersVideoCall()
    })

    global.socket.on('candidate', async (data) => {
      if (this.rtcPeerConnection[this.rtcPeerConnection.map(index => index.id).indexOf(data.idFrom)]) {
        var currentConnection = await this.rtcPeerConnection[this.rtcPeerConnection.map(index => index.id).indexOf(data.idFrom)].peer
      }
      var candidate = await new RTCIceCandidate({ sdpMLineIndex: data.label, candidate: data.candidate })
      if (currentConnection) {
        await currentConnection.addIceCandidate(candidate)
      }
    })

    global.socket.on('join', async (data) => {
      var tabDisplayName = data.displayNameOthers;
      if (tabDisplayName.length > 1) {
        var last = decodeURI(tabDisplayName.pop())
        document.title = `${decodeURI(data.displayNameCaller)} is calling`
        await this.setState({ isModalCall: true, joinGroupCall: true, idFriends: data.idFriends, groupCallBodyMessage: `${decodeURI(data.displayNameCaller)} want you to join the call with ${decodeURI(tabDisplayName.join(','))} and ${last}`, call_group_id: data.call_group_id, call_group_chat_room_id: data.call_group_chat_room_id })
      } else {
        document.title = `${decodeURI(data.displayNameCaller)} is calling`
        await this.setState({ isModalCall: true, joinGroupCall: true, idFriends: data.idFriends, groupCallBodyMessage: `${decodeURI(data.displayNameCaller)} want you to join the call with ${decodeURI(tabDisplayName[0])}`, call_group_id: data.call_group_id, call_group_chat_room_id: data.call_group_chat_room_id })
      }
    })

    global.socket.on('refuseGroupCall', (displayName) => {
      toast.warn(decodeURI(displayName) + ' refuse to join', {
        position: toast.POSITION.TOP_RIGHT
      });
    })

    global.socket.on('refuseGroupDialing', (data) => {
      toast.warn(decodeURI(data.displayName) + ' refuse to join', {
        position: toast.POSITION.TOP_RIGHT
      });
    })

    global.socket.on('sharing', async (sharing) => {
      if (sharing) {
        await this.setState({ friendSharingScreen: true, isMuteAll: false })

      } else {
        await this.setState({ friendSharingScreen: false, isMuteAll: false })
      }
    })

    global.socket.on('errorCalling', (data) => {
      console.log(data)
    })

    global.socket.on('endCall', async (idFrom) => {
      console.log("endCall: " + this.rtcPeerConnection.length)
      if (this.rtcPeerConnection.length > 1) {
        //console.log('closing this id : ', idFrom)
        this.rtcPeerConnection[this.rtcPeerConnection.map(index => index.id).indexOf(idFrom)].peer.close()
        this.rtcPeerConnection.splice(this.rtcPeerConnection.map(index => index.id).indexOf(idFrom), 1)
        await this.removeChildVideoNode(idFrom)
        await this.checkTotalMembersVideoCall()
      } else {
        if (this.rtcPeerConnection.length > 0) {
          await this.rtcPeerConnection[0].peer.close()
          this.rtcPeerConnection = []
          if (this.state.localStream) {
            await this.state.localStream.getTracks().forEach(async function (track) {
              console.log("close")
              await track.stop()
            })
          }
        }
        await this.props.dispatch(handlePage(this.props.callPage, false, true))
        document.title = settings.defaultSettings.REACT_APP_DOCUMENT_TITLE;
        global.socket.emit('validation', { message: 'update_group', roomId: this.state.call_group_chat_room_id })
        window.clearTimeout(this.state.declineCallTimeOut)
        window.clearInterval(this.state.callInterval)
        await this.setInitialState()
      }
    })
  }

  onIceCandidate = (idFrom, event) => {
    if (event.candidate) {
      global.socket.emit('candidate', {
        type: 'candidate',
        label: event.candidate.sdpMLineIndex,
        id: event.candidate.sdpMid,
        candidate: event.candidate.candidate,
        idTo: idFrom,
        token: sessionStorage.getItem('token')
      })
    }
  }

  onTrack = async (idFrom, display_name, event) => {
    let videoRemoteContainer = document.createElement('div');
    videoRemoteContainer.className = 'video-remote-container';
    videoRemoteContainer.addEventListener('click', () => this.setPresenterVideo(idFrom));
    let videoRemoteNameContainer = document.createElement('div');
    videoRemoteNameContainer.className = 'video-remote-name-container';
    let videoRemoteName = document.createElement('div');
    videoRemoteName.className = 'video-remote-name';
    videoRemoteName.appendChild(document.createTextNode(display_name));
    videoRemoteNameContainer.appendChild(videoRemoteName)
    videoRemoteContainer.appendChild(videoRemoteNameContainer)

    let videoRemote = document.createElement('video');
    videoRemote.id = idFrom;
    // videoRemote.autoplay = true;
    videoRemote.setAttribute('autoplay', '');
    videoRemote.setAttribute('muted', '');
    videoRemote.setAttribute('playsinline', true);
    videoRemote.className = 'friendVideo';
    videoRemote.srcObject = event.stream;
    videoRemote.style = `background: url("${cameraNotFoundBg}") center center / 100% no-repeat;`;
    videoRemoteContainer.id = `container_${idFrom}`;
    videoRemoteContainer.appendChild(videoRemote);
    if (this.state.gridLayout) {
      if (document.getElementById('video_container')) {
        document.getElementById('video_container').appendChild(videoRemoteContainer);
      }
    } else {
      if (document.getElementById('video-spectator-container')) {
        document.getElementById('video-spectator-container').appendChild(videoRemoteContainer);
      }
    }

    await this.setState({ remoteStream: event.stream });
    if (this.el_localVideo && this.el_localVideo.current) {
      this.el_localVideo.current.classList.add('localVideoOnCall');
    }
  }

  setLocalAndOffer = async (idFrom, sessionDescription) => {
    console.log("set local and offer start")
    var currentConnection = this.rtcPeerConnection[this.rtcPeerConnection.map(index => index.id).indexOf(idFrom)].peer
    await currentConnection.setLocalDescription(sessionDescription)
    console.log("set local and offer end")
    global.socket.emit('offer', { sdp: sessionDescription, idTo: idFrom, token: sessionStorage.getItem('token'), display_name: this.props.display_name })
  }

  setLocalAndOfferRenegotiate = (idFrom, sessionDescription) => {
    var currentConnection = this.rtcPeerConnection[this.rtcPeerConnection.map(index => index.id).indexOf(idFrom)].peer
    currentConnection.setLocalDescription(sessionDescription)
    global.socket.emit('offerRenegotiate', { sdp: sessionDescription, idTo: idFrom, token: sessionStorage.getItem('token'), display_name: this.props.display_name })
  }

  setLocalAndAnswer = async (idFrom, sessionDescription) => {
    console.log('setLocalAndAnswer start, session Description', sessionDescription)
    var currentConnection = this.rtcPeerConnection[this.rtcPeerConnection.map(index => index.id).indexOf(idFrom)].peer
    console.log('setLocalAndAnswer setLocalDescription')
    await currentConnection.setLocalDescription(sessionDescription)
    global.socket.emit('answer', { sdp: sessionDescription, idTo: idFrom, token: sessionStorage.getItem('token') })
    this.checkTotalMembersVideoCall()
  }

  render() {
    return (
      <div>
        <NavMenu window='VIDEO CALL' endCallFunction={this.endCall.bind(this)} />

        <div className="chat-container">
          <Chat call={this.call.bind(this)} joinOnGoingGroupCall={this.joinOnGoingGroupCall.bind(this)} call_group_id={this.state.call_group_id} call_group_chat_room_id={this.state.call_group_chat_room_id} />
        </div>
        {this.props.videoPage ? (
          <div className='video_call_container'>
            <div className='video_container'>
              <div className="video-layout-button-container">
                <div className={this.state.gridLayout ? "layout-icon-wrapper layout-icon-wrapper-active" : "layout-icon-wrapper"} title="Grid layout" onClick={() => this.gridLayoutSwitch()}><img className="layout-icon" src={gridLayout} /></div>
                <div className={this.state.presenterLayout ? "layout-icon-wrapper layout-icon-wrapper-active" : "layout-icon-wrapper"} title="Presenter layout" onClick={() => this.presenterLayoutSwitch()}><img className="layout-icon" src={presenterLayout} /></div>
              </div>
              <div className='video' >
                <video ref={this.el_localVideo} className='localVideo' autoPlay={true} muted playsInline={true} style={{ background: `url(${cameraNotFoundBg}) no-repeat center `, backgroundSize: "100%" }}></video>
                <div id='video_container' className={this.state.gridLayout ? "video-grid-container" : "d-none"}>
                </div>
                <div id="video-presenter-container" className={this.state.presenterLayout ? "video-presenter-container" : "d-none"}>
                </div>
                <div id="video-spectator-container" className={this.state.presenterLayout ? "video-spectator-container" : "d-none"}>
                </div>
              </div>
              {
                this.state.isAddList ? (
                  <div className='list-friend-to-invite'>
                    <div className="add-friend-video-call-title">Add friends to group call</div>
                    <span className='closeChat-btn' onClick={this.isAddList.bind(this)} >
                      <img className="cancel-icon" src={cancel} />
                    </span>
                    <div className="list-friends-container">{this.addList()}</div>
                  </div>
                ) : (null)
              }
            </div>
          </div>
        ) : null}

        <Modal isOpen={this.state.isModalCall} centered={true}>
          <Sound
            url={ringtone}
            playStatus={this.state.isModalCall ? Sound.status.PLAYING : Sound.status.STOPPED}
          />
          <ModalBody>
            <div className="row">
              <div className="col-1">
                <i className="fa fa-phone-square fasize40" aria-hidden="true"></i>
              </div>
              <div className="col-11">
                <span className="fw-500">Calling video you... <br /></span>
                <div className="caller-name">{this.state.joinGroupCall ? this.state.groupCallBodyMessage : this.state.bodyMessage}</div>
              </div>
            </div>
          </ModalBody>
          <ModalFooter>
            <div className="d-flex">
              <div className="ml-auto">
                <Button color="danger btnfont mr-2"
                  onClick={this.state.joinGroupCall ? this.DeclineGroupCall
                    : this.state.groupDialing ? this.DeclineGroupDialing
                      : this.DeclineCall.bind(this, false)}>
                  Decline</Button>
                <Button color="secondary btnwhite btnfont"
                  onClick={this.state.joinGroupCall ? this.JoinGroupCall
                    : this.state.groupDialing ? this.JoinGroupDialing
                      : this.JoinCall.bind(this)}>
                  Join</Button>
              </div>
            </div>
          </ModalFooter>
        </Modal>
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        {
          this.props.videoPage ? <OnCallButtons
            isAddList={this.state.isAddList}
            isMuteAll={this.state.isMuteAll}
            isMuteMic={this.state.isMuteMic}
            isMuteWebcam={this.state.isMuteWebcam}
            isSharingScreen={this.state.sharingScreen}
            muteMic={this.muteMic.bind(this)}
            muteWebcam={this.muteWebcam.bind(this)}
            muteAll={this.muteAll.bind(this)}
            addList={this.isAddList.bind(this)}
            endCallFunction={this.endCall.bind(this)}
            shareScreenFunction={this.sharingScreen.bind(this)} /> : ''
        }
      </div>
    )
  }

  showStatusFriends = (friend) => {
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

  addDefaultSrc(ev) {
    ev.target.src = defaultAvatar
  }

  addList = () => {
    if (this.props.videoPage) {
      if (this.props.friends_list.length > 0) {
        //console.log(this.props.friends_list)
        return (
          <div className="list-friends">
            {this.props.friends_list.map((friend) => {
              return (
                <div className='friends row friend-call-wrapper' key={friend.id}>
                  <div className="infor-add-friend">
                    <img className='imgUser' src={`${settings.defaultSettings.REACT_APP_API_URL}/avatars/${friend.avatars}`} onError={this.addDefaultSrc} alt={`imgUser-${friend.id}`} />
                    <div className="add-friend-video-call-status-name">
                      {this.showStatusFriends(friend)}
                      <p className="add-friend-video-call-name">{decodeURI(friend.display_name)}</p>
                    </div>
                  </div>
                  <div className="add-friend">
                    <button className='btn btn-info add-friend-group-call' onClick={this.add.bind(this, friend.id)} type='button'>ADD</button>
                  </div>
                </div>
              )
            })}
          </div>
        )
      }
    }
  }
}

const mapStateToProps = (state) => {
  return {
    display_name: decodeURI(state.myProfileReducer.display_name),
    id: state.myProfileReducer.id,
    admin: state.authorizationReducer.admin,
    friends_list: state.myProfileReducer.friends_list,
    callPage: state.pageReducer.callPage,
    videoPage: state.pageReducer.videoPage,
    chatPage: state.pageReducer.chatPage
  }
}

export default connect(mapStateToProps)(VideoCall)
