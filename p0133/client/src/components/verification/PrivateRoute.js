import React from 'react'
import { Route, Redirect } from 'react-router-dom'
import settings from '../../config';
import fetchAuthorization from '../../actions/AuthorizationActions'
import { connect } from 'react-redux'
import io from 'socket.io-client';

class PrivateRoute extends React.Component {
    constructor(props) {
        super(props)
        this.state = { out: false }
        var socket = io.connect(settings.defaultSettings.URL_SOCKETIO, {
            // path: '/socket-chat/',
            forceNew: true,
            reconnection: true,
            reconnectionDelay: 1000,
            reconnectionDelayMax: 5000,
            reconnectionAttempts: Infinity
        });
        global.socket = socket;
    }

    componentDidMount = () => {
        if (sessionStorage.getItem('token') === null) {
            this.setState({ out: true })
        } else {
            this.props.dispatch(fetchAuthorization(sessionStorage.getItem('token')))
        }
    }

    render() {
        const { component: Component, ...rest } = this.props;
        if (this.state.out) {
            return (<Redirect to={{ pathname: "/login" }} />)
        } else {
            if (this.props.loading) {
                return (<Route {...rest} render=
                    {
                        props => this.props.loged ? (<Component {...props} />) : (<Redirect to={{ pathname: "/login" }} />)
                    }
                />)
            } else {
                if (this.props.error === '') {
                    return <p>Loading ...</p>
                } else {
                    return <p>{this.props.error}</p>
                }
            }
        }
    }
}

const mapStateToProps = state => {
    return {
        loged: state.authorizationReducer.loged,
        loading: state.authorizationReducer.loading,
        error: state.authorizationReducer.error
    }
}

export default connect(mapStateToProps)(PrivateRoute)
