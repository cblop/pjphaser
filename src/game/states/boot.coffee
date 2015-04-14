class Boot

  preload: ->
    @load.image 'preloader', 'assets/images/preloader.gif'

  create: ->
    @game.input.maxPointers = 1
    @game.stage.backgroundColor = '#ff0000'
    @scale.scaleMode = Phaser.ScaleManager.SHOW_ALL
    @scale.pageAlignVertically = true
    @scale.setScreenSize(true)

    @game.state.start 'preloader'

module.exports = Boot
