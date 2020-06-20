const jwt = require('jsonwebtoken');

const PRIVATE_KEY = process.env.REACT_APP_PRIVATE_KEY.replace(/\\n/g, '\n');

const encryptRSA = (username, password) => {
  let encoded = jwt.sign({ username: username, password: password }, PRIVATE_KEY, { expiresIn: '6h', algorithm: 'RS256' })
  return encoded;
}

export default encryptRSA;
