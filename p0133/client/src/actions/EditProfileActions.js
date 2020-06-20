import { EDIT_MY_PROFILE, EDIT_MY_PROFILE_SUCCESS, EDIT_MY_PROFILE_ERROR } from '../constants/ActionTypes'
import settings from '../config'
import { toast } from 'react-toastify';

const headers = new Headers({
    'Accept': 'application/json',
    'Content-type': 'application/json'
})

export const editMyProfile = () => ({
    type: EDIT_MY_PROFILE,
    loading: true
})

export const editMyProfileSuccess = (myProfile) => ({
    type: EDIT_MY_PROFILE_SUCCESS,
    myProfile,
    loading: true,
    error: ''
})

export const editMyProfileError = (error) => ({
    type: EDIT_MY_PROFILE_ERROR,
    error,
    loading: true
})

export default function fetchEditMyProfile(myProfile, token) {
    const send = {
        first_name: myProfile.first_name, last_name: myProfile.last_name, display_name: myProfile.display_name,
        phone: myProfile.phone, company: myProfile.company, bio: myProfile.bio, token
    }
    return dispatch => {
        dispatch(editMyProfile())

        return fetch(settings.defaultSettings.REACT_APP_API_URL + '/user/editProfile', { headers, method: 'POST', body: JSON.stringify(send) })
            .then(response => response.json())
            .then(responseJ => {
                dispatch(editMyProfileSuccess(myProfile))
                toast.info("Your Profile has been successfully updated", {
                    position: toast.POSITION.TOP_RIGHT
                });
            })
            .catch((error) => {
                //console.log('error')
                dispatch(editMyProfileError('We have issues with the server, please try again later'))
            })
    }
}
