# config/index.coffee
# Return app configuration settings.
CSON = require 'cson'

name = process.env.NODE_ENV or 'development'

try
  config = CSON.requireCSONFile "./config/#{name}.cson"
catch
  throw new Error "Unable to read #{name}.cson from /config. Make sure it exists and is valid cson."

module.exports = config
