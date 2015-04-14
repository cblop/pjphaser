MicInput = require '../micInput'

class Menu

  @titleTxt = null
  @startTxt = null
  @instTxt = null
  @spaceTxt = null
  @micTxt = null

  create: ->
    x = @game.width / 2
    y = @game.height / 5

    @titleTxt = @add.bitmapText(x, y, 'minecraftia', 'Punch and Judy', 50)
    @titleTxt.align = 'center'
    @titleTxt.tint = 0xffff00
    @titleTxt.x = @game.width / 2 - @titleTxt.textWidth / 2

    y = y + @titleTxt.height + 20

    @instTxt = @add.bitmapText(x, y, 'minecraftia', 'Cheer or boo at the puppets by', 20)
    @instTxt.align = 'center'
    #@instTxt.fontSize = 15
    @instTxt.x = @game.width / 2 - @instTxt.textWidth / 2

    y = y + @instTxt.height
    @spaceTxt = @add.bitmapText(x, y, 'minecraftia', 'clicking the buttons', 20)
    @spaceTxt.align = 'center'
    @spaceTxt.x = @game.width / 2 - @spaceTxt.textWidth / 2

    y = y + @spaceTxt.height
    @micTxt = @add.bitmapText(x, y, 'minecraftia', 'or shouting into the microphone', 20)
    @micTxt.align = 'center'
    @micTxt.x = @game.width / 2 - @micTxt.textWidth / 2
    @micTxt.text = ''

    y = y + @micTxt.height + 20
    @startTxt = @add.bitmapText(x, y, 'minecraftia', 'START', 50)
    @startTxt.align = 'center'
    @startTxt.tint = 0xffff00
    @startTxt.x = @game.width / 2 - @startTxt.textWidth / 2

    @input.onDown.add @onDown, this

    @game.mic = new MicInput(@conf)

  conf: =>
    @micTxt.text = 'or shouting into the microphone'

  update: ->

  onDown: ->
    @game.state.start 'show'

module.exports = Menu
