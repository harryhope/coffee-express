# server.coffee
# Bootstrap the application.
express = require 'express'
cookies = require 'cookie-parser'
parser = require 'body-parser'
routes = require './app/routes'
config = require './app/config'

port = process.env.PORT or 3000
app = express()

app
  .use cookies()
  .use parser.json()
  .use routes

app.listen port, ->
  console.log('Listening on port %s', @address().port)

module.exports = app
