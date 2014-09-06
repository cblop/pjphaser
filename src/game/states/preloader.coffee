class Preloader

  @asset = null
  @ready = false

  preload: ->
    @asset = @add.sprite(@game.width / 2, @game.height / 2, 'preloader')
    @asset.anchor.setTo 0.5, 0.5
    @load.onLoadComplete.addOnce @onLoadComplete, this
    @load.setPreloadSprite @asset
    @load.spritesheet 'police', 'assets/images/police.png', 512, 512
    @load.bitmapFont 'minecraftia', 'assets/fonts/minecraftia.png', 'assets/fonts/minecraftia.xml'
    @load.audio 'punch', 'assets/sounds/punch.mp3', 'assets/sounds/punch.ogg'
    @load.audio 'judy', 'assets/sounds/judy.mp3', 'assets/sounds/judy.ogg'
    @load.audio 'police', 'assets/sounds/police.mp3', 'assets/sounds/police.ogg'

  create: ->
    @asset.cropEnabled = false

  update: ->
    @game.state.start 'menu' unless not @ready

  onLoadComplete: ->
    @ready = true

module.exports = Preloader
