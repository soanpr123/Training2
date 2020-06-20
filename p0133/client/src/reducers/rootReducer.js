import { combineReducers } from 'redux'
import myProfileReducer from './myProfileReducer'
import authorizationReducer from './authorizationReducer'
import infoFriendReducer from './infoFriendReducer'
import pageReducer from './pageReducer'

const rootReducer = combineReducers({
    myProfileReducer,
    authorizationReducer,
    infoFriendReducer,
    pageReducer,
})

export default rootReducer
