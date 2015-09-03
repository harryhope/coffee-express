# routes/index.coffee
# Define application routes.
express = require 'express'
router = express.Router()

router.get '/', (req, res) ->
  res.json {status: 'success', data: {response: 200}}

module.exports = router
