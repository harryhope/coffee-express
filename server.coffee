# server.coffee
# Bootstrap the application.
express = require 'express'
cookies = require 'cookie-parser'
logger = require 'morgan'
parser = require 'body-parser'
routes = require './app/routes/main'
config = require './app/config/config'

port = process.env.PORT or 3000
app = express()

app.use logger 'combined' if app.get('env') is 'development'

app
  .use cookies()
  .use parser.json()
  .use routes

app.listen port, ->
  console.log('Listening on port %s in %s mode', @address().port, app.get 'env')

module.exports = app
