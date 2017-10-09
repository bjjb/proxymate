config = (obj) ->
  redis = obj.PROXYMATE_REDIS_URI ? obj.REDIS_URI ? 'redis://localhost:6379'
  port = obj.PROXYMATE_PORT ? obj.PORT ? 8899
  auth = obj.PROXYMATE_AUTH
  header = obj.PROXYMATE_HEADER
  result = { redis, port }
  result = Object.assign(result, { auth }) if auth?
  result = Object.assign(result, { header }) if header?
  result

module.exports = config
