import { INFO_FRIEND, INFO_FRIEND_SUCCESS, INFO_FRIEND_ERROR } from '../constants/ActionTypes.js'

const initialState = {
    id: 0, first_name: '', last_name: '', display_name: '', email: '', bio: '', company: '',
    phone: '', status: '', loading: false, error: ''
}

const infoFriend = (state = initialState, action) => {
    switch (action.type) {
        case INFO_FRIEND:
            return { ...state, loading: action.loading }
        case INFO_FRIEND_SUCCESS:
            return {
                ...state, id: action.friendInfo.id, first_name: action.friendInfo.first_name, last_name: action.friendInfo.last_name,
                display_name: action.friendInfo.display_name, email: action.friendInfo.email, bio: action.friendInfo.bio,
                company: action.friendInfo.company, phone: action.friendInfo.phone, status: action.friendInfo.status, loading: action.loading, error: action.error
            }
        case INFO_FRIEND_ERROR:
            return { ...state, loading: action.loading, error: action.error }
        default:
            return state
    }
}

export default infoFriend
