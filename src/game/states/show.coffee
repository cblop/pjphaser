Puppet = require '../puppet'
MoveEvent = require '../moveEvent'
SpeakEvent = require '../speakEvent'
EventHandler = require '../eventHandler'
XmppSub = require '../xmppsub'

class Show
  addAnims: ->
    x = @game.width / 2
    y = @game.height / 2
    @punchSprite = @add.sprite x, y + 30, 'punch'
    @punchSprite.anchor.setTo 0.5, 0.5
    @punchSprite.animations.add 'side', [0], 2, true
    @punchSprite.animations.add 'hit', [2, 3], 10, true
    @punchSprite.animations.add 'front', [4], 2, true

    @policeSprite = @add.sprite x, y, 'police'
    @policeSprite.anchor.setTo 0.5, 0.5
    @policeSprite.animations.add 'side', [0], 2, true
    @policeSprite.animations.add 'hit', [3, 4, 5], 10, true
    @policeSprite.animations.add 'front', [6], 2, true
    @policeSprite.animations.add 'point', [9], 2, true
    @policeSprite.animations.add 'dead', [12], 2, true

  addSounds: ->
    @punchSound = @add.audio 'punch'
    @policeSound = @add.audio 'police'

  readFile: (fname) ->
    textBlob = @game.cache.getText fname
    textLines = textBlob.split '\n'
    textLines.pop()
    lines = {}
    dlist = []

    key = ''
    for line in textLines
      if line.charAt(0) == ':'
        key = (line.split ':')[1]
        dlist = []
      else
        pieces = line.split ';'
        dlist.push pieces[0]
        lines[key] = dlist

    lines
        


  addLines: ->
    @punchLines = @readFile('punch')
    @judyLines = @readFile('judy')
    @policeLines = @readFile('police')

  create: ->
    @game.stage.backgroundColor = '#000000'
    @add.sprite 0, 0, 'backdrop'

    @reactionText = 'Audience Reacts!'

    @xmppsub = new XmppSub('http://localhost:5280/http-bind/')

    #@xmppsub.conn.options.sync = true
    #@pubsub = new PubSub('/http-bind/')

    @addAnims()
    @addSounds()
    @addLines()

    @puppets = []
    @punch = new Puppet('punch', @punchSprite, @punchLines, @punchSound)
    @police = new Puppet('police', @policeSprite, @policeLines, @policeSound)

    @puppets.push(@punch)
    @puppets.push(@police)

    @ev = new MoveEvent(@police, 1000, 100)
    @ev2 = new MoveEvent(@punch, 2000, 700)
    @ev3 = new SpeakEvent(@police, 2000)
    @ev4 = new SpeakEvent(@police, 3000)
    @eh = new EventHandler(@game)
    @eh.addEvent(@ev)
    @eh.addEvent(@ev2)

    @add.sprite 0, 0, 'curtains'

    @audienceText = @add.bitmapText(@game.width / 2, @game.height / 2, 'minecraftia', @reactionText)
    @audienceText.tint = 0xFFFF00
    @audienceText.align = 'center'
    @audienceText.x = @game.width / 2 - @audienceText.textWidth / 2

  update: ->
    if @game.input.keyboard.isDown(Phaser.Keyboard.SPACEBAR)
      @audienceText.text = @reactionText
    else
      @audienceText.text = ""

    puppet.update() for puppet in @puppets


module.exports = Show
