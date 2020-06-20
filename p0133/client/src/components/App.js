import React from 'react'
import './styles/css/App.css'
import Logo from './Logo.js'
import Signup from './connection/Signup.js'
import Login from './connection/Login.js'
import { BrowserRouter as Router, Switch, Route } from 'react-router-dom'
import ForgotPassword from './password/ForgotPassword.js'
import ChangePassword from './password/ChangePassword.js'
import VerifiedEmail from './verification/VerifiedEmail'
import ActivateAccount from './verification/ActivateAccount'
import DeleteAccount from './verification/DeleteAccount'
import Admin from './admin/Admin'
import PrivateRoute from './verification/PrivateRoute'
import ChangeEmail from './profile/ChangeEmail'
import EditMyProfile from './profile/EditMyProfile'
import VideoCall from './menu/VideoCall'
import { ToastContainer, Zoom } from 'react-toastify';
import 'react-toastify/dist/ReactToastify.css';

//-------------------------------------------------Test
function App() {
  return (
    <Router>
      <div className="App">
        <Switch>
          <Route path='/' exact component={Logo} />
          <Route path='/login' component={Login} />
          <Route path='/signup' component={Signup} />
          <Route path='/frgtPasswrd' component={ForgotPassword} />
          <Route path='/changePasswrd' component={ChangePassword} />
          <Route path='/verifiedEmail' component={VerifiedEmail} />
          <Route path='/activateAccount' component={ActivateAccount} />
          <Route path='/deleteAccount' component={DeleteAccount} />
          <PrivateRoute path='/menu/changeEmail' component={ChangeEmail} />
          <PrivateRoute path='/admin' component={Admin} />
          <PrivateRoute path='/menu' exact component={VideoCall} />
          <PrivateRoute path='/menu/EditMyProfile' component={EditMyProfile} />
        </Switch>
        <ToastContainer autoClose={2100} transition={Zoom} />
      </div>
    </Router>
  );
}
export default App
