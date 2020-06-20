import { ACCEPT_INVITATION, ACCEPT_INVITATION_SUCCESS, ACCEPT_INVITATION_ERROR } from '../constants/ActionTypes'
import settings from '../config'
import fetchUpdateFriendsList from './UpdateFriendsActions';

const headers = new Headers({
    'Accept': 'application/json',
    'Content-type': 'application/json'
})

export const acceptInvitation = () => ({
    type: ACCEPT_INVITATION,
    loading: true
})

export const acceptInvitationSuccess = (newFriends_list, newInvitations_list) => ({
    type: ACCEPT_INVITATION_SUCCESS,
    newFriends_list,
    newInvitations_list,
    loading: true,
    error: ''
})

export const acceptInvitationError = (error) => ({
    type: ACCEPT_INVITATION_ERROR,
    error,
    loading: true
})

export default function fetchAcceptInvitation(token, idFriend, emailFriend) {
    const send = { token, idFriend, emailFriend}
    return dispatch => {
        dispatch(acceptInvitation())

        return fetch(settings.defaultSettings.REACT_APP_API_URL+'/invitations/acceptInvitation',
            { headers, method: 'POST', body: JSON.stringify(send) })
            .then( response => response.json())
            .then( responseJ => {
                //console.log(responseJ.message)
                if (responseJ.message === 'error friend Request'){
                    dispatch(acceptInvitationError('We have issues with the server. Please, try again later.'))
                } else {
                    if (responseJ.message === 'New Invitations1') {
                        //console.log(responseJ.message, responseJ.newFriendsInfo, responseJ.newInvitsInfo)
                        dispatch(acceptInvitationSuccess(responseJ.newFriendsInfo, responseJ.newInvitsInfo))
                    } else if (responseJ.message === 'No more invitations1') {
                        //console.log(responseJ.message, responseJ.newFriendsInfo)
                        dispatch(acceptInvitationSuccess(responseJ.newFriendsInfo, {}))
                    } else if (responseJ.message === 'New Invitations2') {
                        //console.log(responseJ.message, responseJ.newFriendsInfo, responseJ.newInvitsInfo)
                        dispatch(acceptInvitationSuccess(responseJ.newFriendsInfo, responseJ.newInvitsInfo))
                    } else if (responseJ.message === 'No more invitations2') {
                        //console.log(responseJ.message, responseJ.newFriendsInfo)
                        dispatch(acceptInvitationSuccess(responseJ.newFriendsInfo, {}))
                    } else if (responseJ.message === 'New Invitations3') {
                        //console.log(responseJ.message, responseJ.newFriendsInfo, responseJ.newInvitsInfo)
                        dispatch(acceptInvitationSuccess(responseJ.newFriendsInfo, responseJ.newInvitsInfo))
                    } else if (responseJ.message === 'No more invitations3') {
                        //console.log(responseJ.message, responseJ.newFriendsInfo)
                        dispatch(acceptInvitationSuccess(responseJ.newFriendsInfo, {}))
                    } else if (responseJ.message === 'New Invitations4') {
                        //console.log(responseJ.message, responseJ.newFriendsInfo, responseJ.newInvitsInfo)
                        dispatch(acceptInvitationSuccess(responseJ.newFriendsInfo, responseJ.newInvitsInfo))
                    } else if (responseJ.message === 'No more invitations4') {
                        //console.log(responseJ.message, responseJ.newFriendsInfo)
                        dispatch(acceptInvitationSuccess(responseJ.newFriendsInfo, {}))
                    } else {
                        //console.log('no match with responseJ.message')
                        dispatch(acceptInvitationError('We have issues with the server. Please, try again later.'))
                    }
                  dispatch(fetchUpdateFriendsList(sessionStorage.getItem('token')))
                }
            })
            .catch((error) => {
                dispatch(acceptInvitationError(error))
            })
    }
}
