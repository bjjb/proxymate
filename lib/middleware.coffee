uri     = require 'url'
request = require 'request'

proxy = (host) ->
  return unless host?
  (req) ->
    { method, headers, path } = req
    url = uri.parse(host)
    url.pathname = path
    url = url.format()
    headers.host = url.host
    new Promise (resolve, reject) ->
      try
        console.log("⇒ [#{method}] #{url}")
        request { url, headers }, (error, resp) ->
          return reject(error) if error?
          resolve resp
      catch e
        console.error('ERROR!', e)
        reject(e)

respond = (down) ->
  (up) ->
    down.set(k, v) for own k, v of up.headers
    down.status up.statusCode
    down.write up.body
    down.end()

error = (down) ->
  (error) ->
    down.status 500
    down.set 'Content-Type', 'application/json'
    down.write JSON.stringify(error)
    down.end()

middleware = ({ redis, header }) ->
  redis   ?= 'redis://localhost:6379'
  header  ?= 'x-proxymate'
  (req, resp, next) ->
    { method } = req
    return next() unless method.toUpperCase() is 'GET'
    return next() unless doProxy = proxy(req.headers[header])
    doProxy(req).then(respond(resp)).catch(error(resp))

module.exports = middleware
