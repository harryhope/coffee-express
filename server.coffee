# server.coffee
# Bootstrap the application.
express = require 'express'
cookies = require 'cookie-parser'
morgan = require 'morgan'
winston = require 'winston'
parser = require 'body-parser'
routes = require './app/routes/main'
config = require './app/config/config'

port = process.env.PORT or 3000
app = express()

app.use morgan 'combined' if app.get('env') is 'development'

app
  .set('view engine', 'jade')
  .set('views', './app/views')

app
  .use cookies()
  .use parser.json()
  .use parser.urlencoded {extended: yes}
  .use routes

app.listen port, ->
  winston.info('Listening on port %s in %s mode', @address().port, app.get 'env')

module.exports = app
