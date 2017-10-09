redis = require 'redis'

middleware = ({ redis, header }) ->
  redis   ?= 'redis://localhost:6379'
  header  ?= 'x-proxymate'
  (req, resp, next) ->
    { headers } = req
    return next() unless headers[header]
    resp.set('Content-Type', 'text/plain')
    resp.status(200)
    resp.write('Hello, from Proxymate')
    resp.end()

module.exports = middleware
