class Boot

  preload: ->
    @load.image 'preloader', 'assets/images/preloader.gif'

  create: ->
    @game.input.maxPointers = 1
    @game.stage.backgroundColor = '#ff0000'
    if @game.device.desktop
      @game.scale.pageAlignHorizontally = true
    else
      @game.scaleMode = Phaser.ScaleManager.SHOW_ALL
      @game.scale.minWidth = 480
      @game.scale.minHeight = 260
      @game.scale.maxWidth = 1600
      @game.scale.maxHeight = 1200
      @game.scale.forceLandscape = true
      @game.scale.setScreenSize true

    @game.state.start 'preloader'

module.exports = Boot
