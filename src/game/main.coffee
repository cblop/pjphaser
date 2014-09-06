window.onload = ->
  'use strict'

  Phaser = require 'phaser'

  game = new Phaser.Game 800, 600, Phaser.AUTO, 'pj-coffee'

  # Game States
  game.state.add 'boot', require './states/boot'
  game.state.add 'preloader', require './states/preloader'
  game.state.add 'menu', require './states/menu'
  game.state.add 'show', require './states/show'

  game.state.start 'boot'
