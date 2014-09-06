Event = require './event'

class SpeakEvent extends Event
#class MoveEvent
  constructor: (@puppet, @delay) ->
    super

  trigger: ->
    @puppet.sayLine()
    #console.log "New target:" + @target
    #console.log "Now at: " + @puppet.sprite.x

module.exports = SpeakEvent

