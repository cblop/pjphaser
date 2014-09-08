class Puppet
  constructor: (@name, @sprite, @lines, @audio) ->
    @debug = true
    @speaking = false
    @targ = @sprite.x
    @speed = 10.0
    @direction = 'right'
    @anim = 'rest'
    @emotion = 'happy'
    @emotionLabel = @sprite.game.add.bitmapText(@sprite.x, @sprite.game.height - 150, 'minecraftia', @emotion)
    @emotionLabel.fontSize = 15
    @emotionLabel.tint = 0xffff00
    @emotionLabel.x = @sprite.x - @emotionLabel.textWidth / 2
    @subtitle = @sprite.game.add.bitmapText @sprite.x, 150, 'minecraftia', ''
    @subtitle.fontSize = 20
    @subtitle.tint = 0xffffff
    @subtitle.align = 'center'

  move: ->
    if Math.abs(@sprite.x - @targ) <= @speed
      @sprite.x = @targ
    else
      if @sprite.x < @targ
        if @direction = 'left'
          @sprite.scale.x = 1
          @direction = 'right'
        @sprite.x += @speed
      else if @sprite.x > @targ
        if @direction = 'right'
          @sprite.scale.x = -1
          @direction = 'left'
        @sprite.x -= @speed

  changeDirection: ->
    if @direction = 'left'
      @sprite.scale.x = 1
      @direction = 'right'
    else if @direction = 'right'
      @sprite.scale.x = -1
      @direction = 'left'


  sayLine: ->
    @audio.play()
    @speaking = true
    rand = Math.floor(Math.random() * @lines[@emotion].length)
    @subtitle.x = -1000
    @subtitle.text = @lines[@emotion][rand]
    @sprite.game.time.events.add(1000, @clearLines, this)

  clearLines: ->
    @speaking = false
    @subtitle.text = ''

  drawEmotion: () ->
    @emotionLabel.text = @emotion
    @emotionLabel.align = 'center'
    @emotionLabel.x = @sprite.x - @emotionLabel.textWidth / 2

  drawSubs: () ->
    @subtitle.align = 'center'
    @subtitle.x = @sprite.x - @subtitle.textWidth / 2
    @subtitle.parent.bringToTop(@subtitle)
    @subtitle.fontSize = 20

  turn: ->
    if @direction == "right" then @direction = "left" else @direction = "right"

  update: ->
    @move()
    @drawSubs() if @speaking == true
    if @debug then @drawEmotion() else @emotionLabel.text = ""
    @sprite.animations.play @anim
    

module.exports = Puppet
