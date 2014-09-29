class Error

  @errorTxt = null
  @instTxt = null

  create: ->
    x = @game.width / 2
    y = @game.height / 5

    @titleTxt = @add.bitmapText(x, y, 'minecraftia', 'Connection Error', 50)
    @titleTxt.align = 'center'
    @titleTxt.tint = 0xffff00
    @titleTxt.x = @game.width / 2 - @titleTxt.textWidth / 2

    y = y + @titleTxt.height + 20

    @instTxt = @add.bitmapText(x, y, 'minecraftia', 'Click to try again', 20)
    @instTxt.align = 'center'
    #@instTxt.fontSize = 15
    @instTxt.x = @game.width / 2 - @instTxt.textWidth / 2

    @input.onDown.add @onDown, this

  update: ->

  onDown: ->
    @game.state.start 'menu'

module.exports = Error
