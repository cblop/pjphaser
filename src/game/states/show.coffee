Puppet = require '../puppet'
MoveEvent = require '../moveEvent'
SpeakEvent = require '../speakEvent'
EventHandler = require '../eventHandler'

class Show
  addAnims: ->
    x = @game.width / 2
    y = @game.height / 2
    @policeSprite = @add.sprite x, y, 'police'
    @policeSprite.anchor.setTo 0.5, 0.5
    @policeSprite.animations.add 'side', [0], 2, true
    @policeSprite.animations.add 'hit', [3, 4, 5], 10, true
    @policeSprite.animations.add 'front', [6], 2, true
    @policeSprite.animations.add 'point', [9], 2, true
    @policeSprite.animations.add 'dead', [12], 2, true

  addSounds: ->
    @policeSound = @add.audio 'police'

  create: ->
    @addAnims()
    @addSounds()
    @puppets = []
    @police = new Puppet('police', @policeSprite, [], @policeSound)

    @puppets.push(@police)

    @ev = new MoveEvent(@police, 1000, 0)
    @ev2 = new MoveEvent(@police, 2000, 700)
    @ev3 = new SpeakEvent(@police, 3000)
    @eh = new EventHandler(@game)
    @eh.addEvent(@ev)
    @eh.addEvent(@ev2)
    @eh.addEvent(@ev3)

  update: ->
    puppet.update() for puppet in @puppets


module.exports = Show
