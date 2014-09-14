window.onload = ->
  'use strict'

  Phaser = require 'phaser'
  @OFFSTAGELEFT = 0
  @OFFSTAGERIGHT = 800
  @STAGELEFT = 200
  @STAGERIGHT = 650
  @STAGECENTRE = 400

  game = new Phaser.Game 800, 600, Phaser.AUTO, 'pj-coffee'
  @Globals = {mic: null, noise: 0}

  # Game States
  game.state.add 'boot', require './states/boot'
  game.state.add 'preloader', require './states/preloader'
  game.state.add 'menu', require './states/menu'
  game.state.add 'show', require './states/show'
  game.state.add 'error', require './states/error'

  game.state.start 'boot'
