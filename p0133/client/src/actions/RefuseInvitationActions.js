import { REFUSE_INVITATION, REFUSE_INVITATION_SUCCESS, REFUSE_INVITATION_ERROR } from '../constants/ActionTypes'
import settings from '../config'

const headers = new Headers({
    'Accept': 'application/json',
    'Content-type': 'application/json'
})

export const refuseInvitation = () => ({
    type: REFUSE_INVITATION,
    loading: true
})

export const refuseInvitationSuccess = (newInvitations_list) => ({
    type: REFUSE_INVITATION_SUCCESS,
    newInvitations_list,
    loading: true,
    error: ''
})

export const refuseInvitationError = (error) => ({
    type: REFUSE_INVITATION_ERROR,
    error,
    loading: true
})

export default function fetchRefuseInvitation(token, id, email) {
    const send = { token, id, email}
    return dispatch => {
        dispatch(refuseInvitation())

        return fetch(settings.defaultSettings.REACT_APP_API_URL+'/invitations/refuseInvitation',
            { headers, method: 'POST', body: JSON.stringify(send) })
            .then( response => response.json())
            .then( responseJ => {
                //console.log(responseJ.message)
                if (responseJ.message === 'erreur invitations request'){
                    dispatch(refuseInvitationError('We have issues with the server. Please, try again later.'))
                } else {
                    if (responseJ.message === 'invitation refused ok & No I') {
                        dispatch(refuseInvitationSuccess({}))
                    } else if (responseJ.message === 'invitation refused ok & I') {
                        //console.log(responseJ.newInvitsInfo)
                        dispatch(refuseInvitationSuccess(responseJ.newInvitsInfo))
                    } else {
                        //console.log('else')
                        dispatch(refuseInvitationError('We have issues with the server. Please, try again later.'))
                    }
                }
            })
            .catch((error) => {
                //console.log('catch')
                dispatch(refuseInvitationError(error))
            })
    }
}
