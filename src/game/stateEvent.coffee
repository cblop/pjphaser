Event = require './event'

class StateEvent extends Event
#class MoveEvent
  constructor: (@puppet, @delay, @emo) ->
    super

  trigger: ->
    @puppet.emotion = @emo
    #console.log "New target:" + @target
    #console.log "Now at: " + @puppet.sprite.x

module.exports = StateEvent

