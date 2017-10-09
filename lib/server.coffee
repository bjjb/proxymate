server = ->
  express = require 'express'
  morgan = require 'morgan'
  middleware = require './middleware'
  config = require './config'

  app = express()
  cfg = config(process.env)

  app.use morgan('tiny')
  app.use middleware(cfg)
  app.use express.static('app')

  app.listen cfg.port, ->
    { name, version } = require '../package'
    { address, port } = @address()
    console.log "#{name} v#{version} listening on #{address}:#{port}"

if process.argv[1] is __filename
  server()
else
  module.exports = server
