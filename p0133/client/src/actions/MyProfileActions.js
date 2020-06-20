import { MY_PROFILE, MY_PROFILE_SUCCESS, MY_PROFILE_ERROR } from '../constants/ActionTypes.js'
import settings from '../config'

const headers = new Headers({
    'Accept': 'application/json',
    'Content-type': 'application/json'
})

export const myProfile = () => ({
    type: MY_PROFILE,
    loading: false
})

export const myProfileSuccess = (myProfile, friends_list, invitations_list, avatar) => ({
    type: MY_PROFILE_SUCCESS,
    myProfile,
    friends_list,
    invitations_list,
    avatar,
    error: '',
    loading: true
})

export const myProfileError = (error) => ({
    type: MY_PROFILE_ERROR,
    error,
    loading: false
})

export default function fetchMyProfile(token) {
    return dispatch => {
        dispatch(myProfile())
        return fetch(settings.defaultSettings.REACT_APP_API_URL+'/user/profile', { headers, method: 'POST', body: JSON.stringify({ token }) })
            .then( response =>
                response.json())
            .then( responseJ => {
                // console.log(responseJ)
                //console.log(responseJ.infoFriends)
                if (responseJ.message === 'error request'){
                    //console.log('bad profile')
                    dispatch(myProfileError('We have issues with the server. Please, try again later.'))
                } else {
                    if (responseJ.message === 'No F and No I') {
                        //console.log('just myProfile', responseJ.avatarUser)
                        dispatch(myProfileSuccess(responseJ.infoUser, {}, {}, responseJ.avatarUser))
                    } else if (responseJ.message === 'F and No I') {
                        //console.log('myProfile & friends', responseJ.avatarUser)
                        dispatch(myProfileSuccess(responseJ.infoUser, responseJ.infoFriends, {}, responseJ.avatarUser))
                    } else if (responseJ.message === 'No F and I') {
                        //console.log('myProfile & invitations', responseJ.avatarUser)
                        dispatch(myProfileSuccess(responseJ.infoUser, {}, responseJ.infoInvits, responseJ.avatarUser))
                    } else if (responseJ.message === 'F and I'){
                        //console.log('myProfile & friends & invitations', responseJ.avatarUser)
                        dispatch(myProfileSuccess(responseJ.infoUser, responseJ.infoFriends, responseJ.infoInvits, responseJ.avatarUser))
                    } else {
                        //console.log('bad bad profile')
                        dispatch(myProfileError('We have issues with the server. Please, try again later.'))
                    }
                }
            })
            .catch((error) => {
                //console.log('catch')
                dispatch(myProfileError(error))
            })
    }
}
