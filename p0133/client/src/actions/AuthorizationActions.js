import { AUTHORIZATION, AUTHORIZATION_SUCCESS, AUTHORIZATION_ERROR } from '../constants/ActionTypes.js'
import settings from '../config'

const headers = new Headers({
    'Accept': 'application/json',
    'Content-type': 'application/json'
})

export const authorization = () => ({
    type: AUTHORIZATION,
    loading: false
})

export const authorizationSuccess = (admin, loged) => ({
    type: AUTHORIZATION_SUCCESS,
    admin,
    loged,
    loading: true
})

export const authorizationError = (error) => ({
    type: AUTHORIZATION_ERROR,
    error,
    loading: false
})

export default function fetchAuthorization(token) {
    return async (dispatch) => {
        let response = await fetch(settings.defaultSettings.REACT_APP_API_URL+'/authorization', { headers, method: 'POST', body: JSON.stringify({ token: token }) })
        let responseJSON = await response.json()
        //console.log(responseJSON.message)
        if ( await responseJSON.message === 'false') {
            //console.log('f f')
            dispatch(authorizationSuccess(false, false))
        } else if (await responseJSON.message === 'true') {
            if (await responseJSON.role === 'admin') {
                //console.log('t t')
                dispatch(authorizationSuccess(true, true))
              } else {
                //console.log('f t')
                dispatch(authorizationSuccess(false, true))
            }
        } else {
            //console.log('f f')
            dispatch(authorizationSuccess(false, false))
        }
    }
}
