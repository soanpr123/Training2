import { HANDLE_PAGE } from '../constants/ActionTypes.js'

const initialState = {
    callPage: true, chatPage: true, videoPage: false
}

const page = (state = initialState, action) => {
    switch(action.type) {
        case HANDLE_PAGE:
            return { ...state, callPage: action.callPage, videoPage: action.videoPage, chatPage: action.chatPage }
        default:
            return state
    }
}

export default page
