Event = require './event'

class MoveEvent extends Event
#class MoveEvent
  constructor: (@puppet, @delay, @target) ->
    super

  trigger: ->
    @puppet.targ = @target
    #console.log "New target:" + @target
    #console.log "Now at: " + @puppet.sprite.x

module.exports = MoveEvent

