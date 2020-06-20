import { AUTHORIZATION, AUTHORIZATION_SUCCESS,AUTHORIZATION_ERROR } from '../constants/ActionTypes.js'

const initialState = {
    admin: false, loged: false, loading: false, error: null
}

const authorization = (state = initialState, action) => {
    switch(action.type) {
        case AUTHORIZATION:
            return { ...state, loading: action.loading }
        case AUTHORIZATION_SUCCESS:
            return { ...state, admin: action.admin, loged: action.loged, loading: action.loading }
        case AUTHORIZATION_ERROR:
            return { ...state, loading: action.loading, error: action.error }
        default:
            return state
    }
}

export default authorization
