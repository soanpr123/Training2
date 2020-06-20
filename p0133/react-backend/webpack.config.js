const path = require('path');
const nodeExternals = require('webpack-node-externals')

module.exports = {
  entry: './bin/index.js',
  output: {
    path: path.resolve(__dirname, 'dist'),
    filename: 'webrtc.bundle.js'
  },
  externals: [nodeExternals()],
  target: 'node',
  node: {
    __dirname: false
  }
};