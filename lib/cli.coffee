cli = require 'commander'

{ version } = require '../package'
cmd = null

cli.version version
    .option '-R, --redis', 'the Redis database location'

cli.action -> cli.help()

cli.command 'server'
  .alias 's'
  .description 'start a server'
  .option '-p, --port', 'the listener port'
  .action (cmd, options) ->
    server = require './server'
    cmd = server()

module.exports = cli
