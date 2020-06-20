import { UPDATE_FRIENDS_LIST, UPDATE_FRIENDS_LIST_SUCCESS, UPDATE_FRIENDS_LIST_ERROR } from '../constants/ActionTypes.js'
import settings from '../config'

const headers = new Headers({
    'Accept': 'application/json',
    'Content-type': 'application/json'
})

export const updateFriendsList = () => ({
    type: UPDATE_FRIENDS_LIST,
    loading: true
})

export const updateFriendsListSuccess = (friends_list, invitations_list) => ({
    type: UPDATE_FRIENDS_LIST_SUCCESS,
    friends_list,
    invitations_list,
    error: '',
    loading: true
})

export const updateFriendsListError = (error) => ({
    type: UPDATE_FRIENDS_LIST_ERROR,
    error,
    loading: true
})

export default function fetchUpdateFriendsList(token) {
    return dispatch => {
        dispatch(updateFriendsList())
        return fetch(settings.defaultSettings.REACT_APP_API_URL+'/user/updateStatus', { headers, method: 'POST', body: JSON.stringify({ token }) })
            .then( (response) => {
                if (global.socket.disconnected){
                  global.socket.connect()
                  global.socket.emit('user', { token: sessionStorage.getItem('token') })
                }
                return response.json()})
            .then( responseJ => {
                // console.log(responseJ)
                if (responseJ.message === 'error' || responseJ.message === 'error select invitations' ||
                    responseJ.message === 'error invitations infos request') {
                    //console.log('error server')
                    dispatch(updateFriendsListError('We have issues with the server. Please, try again later.'))
                    document.getElementById('overlay').classList.add('d-block');
                } else if (responseJ.message === 'nothing') {
                    //console.log('No F & No I')
                    dispatch(updateFriendsListSuccess({}, {}))
                    document.getElementById('overlay').classList.remove('d-block');
                } else if (responseJ.message === 'invit') {
                    //console.log('No F & I')
                    dispatch(updateFriendsListSuccess({}, responseJ.data))
                    document.getElementById('overlay').classList.remove('d-block');
                } else if (responseJ.message === 'update status') {
                    // console.log('F & No I')
                    dispatch(updateFriendsListSuccess(responseJ.status, {}))
                    document.getElementById('overlay').classList.remove('d-block');
                } else if (responseJ.message === 'invitation') {
                    //console.log('F & I')
                    dispatch(updateFriendsListSuccess(responseJ.status, responseJ.data))
                    document.getElementById('overlay').classList.remove('d-block');
                } else {
                    //console.log('error')
                    dispatch(updateFriendsListError('We have issues with the server. Please, try again later.'))
                    document.getElementById('overlay').classList.add('d-block');
                }
            })
            .catch((error) => {
                //console.log('catch')
                dispatch(updateFriendsListError(error))
                document.getElementById('overlay').classList.add('d-block');
            })
    }
}
