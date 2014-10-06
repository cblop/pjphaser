class Preloader

  @asset = null
  @ready = false

  preload: ->
    @asset = @add.sprite(@game.width / 2, @game.height / 2, 'preloader')
    @asset.anchor.setTo 0.5, 0.5
    @load.onLoadComplete.addOnce @onLoadComplete, this
    @load.setPreloadSprite @asset

    @load.image 'backdrop', 'assets/images/stage2.png'
    @load.image 'curtains', 'assets/images/stage1.png'

    @load.spritesheet 'punch', 'assets/images/punch.png', 512, 512
    @load.spritesheet 'police', 'assets/images/police.png', 512, 512
    @load.spritesheet 'judy', 'assets/images/judy.png', 512, 512
    @load.spritesheet 'joey', 'assets/images/joey.png', 512, 512
    @load.spritesheet 'baby', 'assets/images/baby.png', 512, 512
    @load.spritesheet 'croc', 'assets/images/croc.png', 512, 512

    @load.bitmapFont 'minecraftia', 'assets/fonts/minecraftia.png', 'assets/fonts/minecraftia.xml'

    @load.audio 'punch', 'assets/sounds/punch.mp3', 'assets/sounds/punch.ogg'
    @load.audio 'judy', 'assets/sounds/judy.mp3', 'assets/sounds/judy.ogg'
    @load.audio 'joey', 'assets/sounds/joey.mp3', 'assets/sounds/joey.ogg'
    @load.audio 'baby', 'assets/sounds/baby.mp3', 'assets/sounds/baby.ogg'
    @load.audio 'police', 'assets/sounds/police.mp3', 'assets/sounds/police.ogg'

    @load.text 'punch', 'assets/sounds/punch.csv'
    @load.text 'judy', 'assets/sounds/judy.csv'
    @load.text 'joey', 'assets/sounds/joey.csv'
    @load.text 'baby', 'assets/sounds/baby.csv'
    @load.text 'police', 'assets/sounds/police.csv'

  create: ->
    @asset.cropEnabled = false

  update: ->
    @game.state.start 'menu' unless not @ready

  onLoadComplete: ->
    @ready = true

module.exports = Preloader
