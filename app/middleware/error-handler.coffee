# error-handler.coffee
# Handle application errors.

module.exports = (err, req, res, next) ->
  if not err
    err = new NotFound()

  switch err?.status
    when 404
      return res.render 'error-pages/404'
    else
      return res.render 'error-pages/unhandled-error'
