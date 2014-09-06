class Puppet
  constructor: (@name, @sprite, @lines, @audio) ->
    @targ = @sprite.x
    @speed = 10.0
    @direction = 'right'
    @anim = 'side'
    @emotion = 'happy'

  move: ->
    if Math.abs(@sprite.x - @targ) <= @speed
      @sprite.x = @targ
    else
      if @sprite.x < @targ
        @sprite.x += @speed
      else if @sprite.x > @targ
        @sprite.x -= @speed

  sayLine: ->
    @audio.play()

  drawEmotion: () ->

  drawSubs: () ->

  turn: ->
    if @direction == "right" then @direction = "left" else @direction = "right"

  update: ->
    @move()
    @sprite.animations.play @anim
    

module.exports = Puppet
