
'use strict'

const BrowserSyncPlugin = require('browser-sync-webpack-plugin')


module.exports = {
  entry: {
    top:'./src/coffee/entry/Top.coffee'
  },
  output: {
    path: '../docs/assets/js',
    filename: '[name].bundle.js'
  },
  module: {
    loaders: [
      {
        test: /\.coffee$/,
        loader: 'coffee'
      }
    ]
  },
  resolve: {
    extensions: ['', '.coffee', '.js']
  },
  plugins: [
    new BrowserSyncPlugin({
      host: 'localhost',
      port: 3000,
      server: {
        baseDir: ['../docs']
      },
      open: false,
      injectChanges: true,
      files: [
        '../docs/**/*.js',
        '../docs/**/*.css',
        '../docs/**/*.html'
      ],
      ghostMode: false
    })
  ]
}
