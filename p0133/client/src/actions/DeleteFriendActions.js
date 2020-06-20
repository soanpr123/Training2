import { DELETE_FRIEND, DELETE_FRIEND_SUCCESS, DELETE_FRIEND_ERROR } from '../constants/ActionTypes'
import settings from '../config'
import fetchUpdateFriendsList from './UpdateFriendsActions';

const headers = new Headers({
    'Accept': 'application/json',
    'Content-type': 'application/json'
})

export const deleteFriend = () => ({
    type: DELETE_FRIEND,
    loading: true
})

export const deleteFriendSuccess = (friends_list) => ({
    type: DELETE_FRIEND_SUCCESS,
    friends_list,
    loading: true,
    error: ''
})

export const deleteFriendError = (error) => ({
    type: DELETE_FRIEND_ERROR,
    error,
    loading: true
})

export default function fetchDeleteFriend(token, idFriend) {
    return dispatch => {
        let send = { token, idFriend }
        dispatch(deleteFriend())

        return fetch(settings.defaultSettings.REACT_APP_API_URL+'/friends/deleteFriend', { headers, method: 'POST', body: JSON.stringify(send) })
            .then( response => response.json())
            .then( responseJ => {
                if  (responseJ.message === 'ok') {
                    //console.log(responseJ.newFriendList)
                    // dispatch(deleteFriendSuccess(responseJ.newFriendList))
                } else if (responseJ.message ==='friends empty') {
                    // dispatch(deleteFriendSuccess(""))
                } else {
                    dispatch(deleteFriendError('We have issues with the server. Please try again later.'))
                }
                dispatch(fetchUpdateFriendsList(sessionStorage.getItem('token')))
            })
            .catch((error) => {
                dispatch(deleteFriendError(error))
            })
    }
}
