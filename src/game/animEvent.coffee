Event = require './event'

class AnimEvent extends Event
#class MoveEvent
  constructor: (@puppet, @delay, @anim) ->
    super

  trigger: ->
    if @anim == 'turn'
      @puppet.changeDirection()
    else
      @puppet.anim = @anim
    #console.log "New target:" + @target
    #console.log "Now at: " + @puppet.sprite.x

module.exports = AnimEvent

