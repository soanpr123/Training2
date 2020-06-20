import { UPLOAD_AVATAR, UPLOAD_AVATAR_SUCCESS, UPLOAD_AVATAR_ERROR } from '../constants/ActionTypes'
import settings from '../config';
import axios from 'axios'

export const uploadAvatar = () => ({
    type: UPLOAD_AVATAR,
    loading: true
})

export const uploadAvatarSuccess = (avatar) => ({
    type: UPLOAD_AVATAR_SUCCESS,
    avatar,
    loading: true,
    error: ''
})

export const uploadAvatarError = (error) => ({
    type: UPLOAD_AVATAR_ERROR,
    error,
    loading: true
})

export default function axiosUploadAvatar(data) {
    return dispatch => {
        dispatch(uploadAvatar())

        return axios.post(settings.defaultSettings.REACT_APP_API_URL+'/user/changeAvatar',data, {})
            .then( response => {
                dispatch(uploadAvatarSuccess(response.data.file))
            })
            .catch((error) => {
                //console.log('catch')
                dispatch(uploadAvatarError(error))
            })
    }
}
