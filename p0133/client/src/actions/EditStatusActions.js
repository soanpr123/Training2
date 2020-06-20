import { EDIT_MY_STATUS, EDIT_MY_STATUS_SUCCESS, EDIT_MY_STATUS_ERROR } from '../constants/ActionTypes'
import settings from '../config'

const headers = new Headers({
    'Accept': 'application/json',
    'Content-type': 'application/json'
})

export const editMyStatus = () => ({
    type: EDIT_MY_STATUS,
    loading: true
})

export const editMyStatusSuccess = (status) => ({
    type: EDIT_MY_STATUS_SUCCESS,
    status,
    error: '',
    loading: true
})

export const editMyStatusError = (error) => ({
    type: EDIT_MY_STATUS_ERROR,
    error,
    loading: false
})

export default function fetchEditMyStatus(token, status) {
    const send = { token, status }
    return dispatch => {
        dispatch(editMyStatus())

        return fetch(settings.defaultSettings.REACT_APP_API_URL+'/user/status', { headers, method: 'POST', body: JSON.stringify(send) })
            .then( response => response.json())
            .then( responseJ => {
                if (responseJ.message === 'error'){
                    dispatch(editMyStatusError('We have issues with the server. Please, try again later'))
                    return 'edit err'
                } else {
                    dispatch(editMyStatusSuccess(status))
                    return 'edit success'
                }
            })
            .catch((error) => {
                dispatch(editMyStatusError(error))
            })
    }
}
