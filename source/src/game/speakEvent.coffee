Event = require './event'

class SpeakEvent extends Event
#class MoveEvent
  constructor: (@puppet, @delay, @speech) ->
    super

  trigger: ->
    @puppet.sayLine(@speech)
    #console.log "New target:" + @target
    #console.log "Now at: " + @puppet.sprite.x

module.exports = SpeakEvent

