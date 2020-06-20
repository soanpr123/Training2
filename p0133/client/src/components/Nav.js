import React from 'react';
import './styles/css/App.css';
import Logo from './styles/images/uoi-logo-white.png';

function Nav() {

    return (
        <nav className="navigation-login">
            <img className="logo-login" src={Logo} alt="Voispy" />
        </nav>
    )
}

export default Nav;
