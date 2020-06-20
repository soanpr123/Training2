import { MY_PROFILE, MY_PROFILE_SUCCESS, MY_PROFILE_ERROR } from '../constants/ActionTypes.js'
import { EDIT_MY_STATUS, EDIT_MY_STATUS_SUCCESS, EDIT_MY_STATUS_ERROR } from '../constants/ActionTypes.js'
import { EDIT_MY_PROFILE, EDIT_MY_PROFILE_SUCCESS, EDIT_MY_PROFILE_ERROR } from '../constants/ActionTypes.js'
import { ACCEPT_INVITATION, ACCEPT_INVITATION_SUCCESS, ACCEPT_INVITATION_ERROR } from '../constants/ActionTypes.js'
import { REFUSE_INVITATION, REFUSE_INVITATION_SUCCESS, REFUSE_INVITATION_ERROR } from '../constants/ActionTypes.js'
import { UPLOAD_AVATAR, UPLOAD_AVATAR_SUCCESS, UPLOAD_AVATAR_ERROR } from '../constants/ActionTypes.js'
import { UPDATE_FRIENDS_LIST, UPDATE_FRIENDS_LIST_SUCCESS, UPDATE_FRIENDS_LIST_ERROR } from '../constants/ActionTypes.js'
import { DELETE_FRIEND, DELETE_FRIEND_SUCCESS, DELETE_FRIEND_ERROR } from '../constants/ActionTypes.js'

const initialState = {
    id: '', first_name: '', last_name: '', email: '', phone: '', company: '', display_name: '', bio: '', status: '', friends_list: {},
    invitations_list: {}, loading: false, error_profile: '', error_status: '', error_edit: '', error_acceptInvitation: '',
    error_refuseInvitation: '', avatar: '', error_avatar: '', error_list: ''
}

const myProfile = (state = initialState, action) => {
    switch (action.type) {
        //-----------------------------------------------------------------------------------------------------------------------------
        case MY_PROFILE:
            return { ...state, loading: action.loading }
        case MY_PROFILE_SUCCESS:
            return {
                ...state, id: action.myProfile.id, first_name: action.myProfile.first_name, last_name: action.myProfile.last_name, email: action.myProfile.email,
                phone: action.myProfile.phone, company: action.myProfile.company, display_name: action.myProfile.display_name,
                bio: action.myProfile.bio, status: action.myProfile.status, friends_list: action.friends_list,
                invitations_list: action.invitations_list, loading: action.loading, error_profile: action.error, avatar: action.avatar
            }
        case MY_PROFILE_ERROR:
            return { ...state, loading: action.loading, error_profile: action.error }
        //-----------------------------------------------------------------------------------------------------------------------------
        case EDIT_MY_STATUS:
            return { ...state, loading: action.loading }
        case EDIT_MY_STATUS_SUCCESS:
            return { ...state, status: action.status, loading: action.loading, error_status: action.error }
        case EDIT_MY_STATUS_ERROR:
            return { ...state, loading: action.loading, error_status: action.error }
        //-----------------------------------------------------------------------------------------------------------------------------
        case EDIT_MY_PROFILE:
            return { ...state, loading: action.loading }
        case EDIT_MY_PROFILE_SUCCESS:
            return {
                ...state, id: action.myProfile.id, first_name: action.myProfile.first_name, last_name: action.myProfile.last_name,
                phone: action.myProfile.phone, company: action.myProfile.company, display_name: action.myProfile.display_name,
                bio: action.myProfile.bio, status: action.myProfile.status, loading: action.loading, error_edit: action.error
            }
        case EDIT_MY_PROFILE_ERROR:
            return { ...state, loading: action.loading, error_edit: action.error }
        //-----------------------------------------------------------------------------------------------------------------------------
        case ACCEPT_INVITATION:
            return { ...state, loading: action.loading }
        case ACCEPT_INVITATION_SUCCESS:
            return { ...state, friends_list: action.newFriends_list, invitations_list: action.newInvitations_list, loading: action.loading, error_acceptInvitation: action.error }
        case ACCEPT_INVITATION_ERROR:
            return { ...state, loading: action.loading, error_acceptInvitation: action.error }
        //-----------------------------------------------------------------------------------------------------------------------------
        case REFUSE_INVITATION:
            return { ...state, loading: action.loading }
        case REFUSE_INVITATION_SUCCESS:
            return { ...state, invitations_list: action.newInvitations_list, loading: action.loading, error_refuseInvitation: action.error }
        case REFUSE_INVITATION_ERROR:
            return { ...state, loading: action.loading, error_refuseInvitation: action.error }
        //-----------------------------------------------------------------------------------------------------------------------------
        case UPLOAD_AVATAR:
            return { ...state, loading: action.loading }
        case UPLOAD_AVATAR_SUCCESS:
            return { ...state, avatar: action.avatar, loading: action.loading, error_avatar: action.error }
        case UPLOAD_AVATAR_ERROR:
            return { ...state, loading: action.loading, error_avatar: action.error }
        //-----------------------------------------------------------------------------------------------------------------------------
        case UPDATE_FRIENDS_LIST:
            return { ...state, loading: action.loading }
        case UPDATE_FRIENDS_LIST_SUCCESS:
            return { ...state, friends_list: action.friends_list, invitations_list: action.invitations_list, loading: action.loading, error_list: action.error }
        case UPDATE_FRIENDS_LIST_ERROR:
            return { ...state, loading: action.loading, error_list: action.error }
        //-----------------------------------------------------------------------------------------------------------------------------
        case DELETE_FRIEND:
            return { ...state, loading: action.loading }
        case DELETE_FRIEND_SUCCESS:
            return { ...state, friends_list: action.friends_list, loading: action.loading, error_list: action.error }
        case DELETE_FRIEND_ERROR:
            return { ...state, loading: action.loading, error_list: action.error }
        default:
            return state
    }
}

export default myProfile