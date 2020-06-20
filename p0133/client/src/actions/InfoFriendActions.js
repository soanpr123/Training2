import { INFO_FRIEND, INFO_FRIEND_SUCCESS, INFO_FRIEND_ERROR } from '../constants/ActionTypes.js'
import settings from '../config'

const headers = new Headers({
    'Accept': 'application/json',
    'Content-type': 'application/json'
})

export const infoFriend = () => ({
    type: INFO_FRIEND,
    loading: true
})

export const infoFriendSuccess = (friendInfo) => ({
    type: INFO_FRIEND_SUCCESS,
    friendInfo,
    error: '',
    loading: true
})

export const infoFriendError = (error) => ({
    type: INFO_FRIEND_ERROR,
    error,
    loading: true
})

export default function fetchInfoFriend(idFriend) {
    return async (dispatch) => {
        let response = await fetch(settings.defaultSettings.REACT_APP_API_URL+'/friends/friendInfo', { headers, method: 'POST', body: JSON.stringify({ idFriend }) })
        let responseJSON = await response.json()
        // console.log(responseJSON)
        if ( await responseJSON.message === 'info') {
            dispatch(infoFriendSuccess(responseJSON.info))
            return true
        } else {
            dispatch(infoFriendError('We have issues with the server. Please try again later !'))
            return false
        }
    }
}
