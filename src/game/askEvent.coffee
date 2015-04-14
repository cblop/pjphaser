Event = require './event'

class AskEvent extends Event
#class MoveEvent
  constructor: (@puppet, @delay, @speech) ->
    super

  trigger: ->
    @puppet.sayLine(@speech)
    #@puppet.sprite.animations.play "front"
    @puppet.anim = "front"
    #console.log "New target:" + @target
    #console.log "Now at: " + @puppet.sprite.x

module.exports = AskEvent

