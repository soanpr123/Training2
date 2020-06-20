const defaultSettings = {
    REACT_APP_API_URL: process.env.REACT_APP_API_URL,
    URL_SOCKETIO: process.env.REACT_APP_URL_SOCKETIO,
    REACT_APP_GA_PROPERTY: process.env.REACT_APP_GA_PROPERTY,
    REACT_APP_DOCUMENT_TITLE: process.env.REACT_APP_DOCUMENT_TITLE
};

const APP_CONFIG = {
    RegexEmail: /^(([^<>()[\]\\.,;:\s@\\"]+(\.[^<>()[\]\\.,;:\s@\\"]+)*)|(\\".+\\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/,
    RegexDisplayName: /^[a-z0-9_-]{3,16}$/
}

const commonConfig = {
    FileUploadSizeLimit: 1000 * 1024 * 1024, // 1GB
}

const settings = { defaultSettings, APP_CONFIG, commonConfig };
export default settings;
