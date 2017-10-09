middleware = (redis_url) ->
  (req, resp, next) ->
    resp.set('Content-Type', 'text/plain')
    resp.status(200)
    resp.write('Hello, from Proxymate')
    resp.end()

@Proxymate = { middleware }
