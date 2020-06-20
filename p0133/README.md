# Set up local environment
## Client

 1. client/package.json
```
"start": "set PORT=3001 && react-scripts start"
```

2. client/.env
```javasript
    REACT_APP_API_URL = http://localhost:3000
    REACT_APP_URL_SOCKETIO = http://localhost:3005
```
3. client/src/verification/PrivateRoute.js
- comment path: '/socket-chat/
```javascript
     // path: '/socket-chat/',

```
## Back-end
1. react-backend/app.js
- https -> http
```javascript
    const https = require('http')
```
2. react-backend/.env
```
    FE_URL: 'http://localhost:3000',
```