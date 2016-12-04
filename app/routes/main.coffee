# routes/index.coffee
# Define application routes.
express = require 'express'
router = express.Router()
{NotFound} = require '../utils/error-generator'

# Index
router.get '/', (req, res) ->
  res.render 'index'

# Catch-all for non-existant routes.
router.get '*', (req, res) ->
  throw new NotFound()

module.exports = router
