express = require 'express'
morgan = require 'morgan'
proxymate = require '.'

app = express()

redis     = process.env.REDIS_URL ? 'redis://localhost:6379'
port      = process.env.PORT ? 8080
auth      = process.env.AUTH ? null
hostname  = process.env.BIND ? 'localhost'
adminPath = process.env.ADMIN_PATH ? 'admin'

app.use morgan('tiny')
app.use adminPath, express.static('app')
app.use proxymate.middleware(redis)

app.listen port, hostname, ->
  { name, version } = require './package'
  { address, port } = @address()
  console.log "#{name} v#{version} listening on #{address}:#{port}"
