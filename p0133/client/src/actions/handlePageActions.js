import { HANDLE_PAGE } from '../constants/ActionTypes'

const handlePage = (callPage, videoPage, chatPage) => ({
    type: HANDLE_PAGE,
    callPage,
    videoPage,
    chatPage
})

export default handlePage
