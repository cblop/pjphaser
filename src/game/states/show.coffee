Puppet = require '../puppet'
Item = require '../item'
MoveEvent = require '../moveEvent'
SpeakEvent = require '../speakEvent'
EventHandler = require '../eventHandler'
PubSub = require '../pubsub'

class Show
  addAnims: ->
    x = @game.width / 2
    y = @game.height / 2
    @punchSprite = @add.sprite OFFSTAGELEFT, y + 30, 'punch'
    @punchSprite.anchor.setTo 0.5, 0.5
    @punchSprite.animations.add 'rest', [0], 2, true
    @punchSprite.animations.add 'front', [2], 2, true
    @punchSprite.animations.add 'hit', [4, 5], 10, true

    @judySprite = @add.sprite OFFSTAGERIGHT, y, 'judy'
    @judySprite.anchor.setTo 0.5, 0.5
    @judySprite.animations.add 'rest', [0], 2, true
    @judySprite.animations.add 'front', [1], 2, true
    @judySprite.animations.add 'babyside', [2], 2, true
    @judySprite.animations.add 'babyfront', [3], 2, true

    @babySprite = @add.sprite OFFSTAGERIGHT, y, 'baby'
    @babySprite.anchor.setTo 0.5, 0.5
    @babySprite.animations.add 'rest', [0], 2, true
    @babySprite.animations.add 'front', [1], 2, true

    @crocSprite = @add.sprite OFFSTAGERIGHT, y, 'croc'
    @crocSprite.anchor.setTo 0.5, 0.5
    @crocSprite.animations.add 'rest', [0], 2, true
    @crocSprite.animations.add 'front', [0], 2, true
    @crocSprite.animations.add 'snap', [0, 1], 10, true

    @policeSprite = @add.sprite OFFSTAGERIGHT, y, 'police'
    @policeSprite.anchor.setTo 0.5, 0.5
    @policeSprite.animations.add 'rest', [0], 2, true
    @policeSprite.animations.add 'hit', [3, 4, 5], 10, true
    @policeSprite.animations.add 'front', [6], 2, true
    @policeSprite.animations.add 'point', [9], 2, true
    @policeSprite.animations.add 'dead', [12], 2, true

    @joeySprite = @add.sprite OFFSTAGERIGHT, y, 'joey'
    @joeySprite.anchor.setTo 0.5, 0.5
    @joeySprite.animations.add 'rest', [0], 2, true
    @joeySprite.animations.add 'front', [2], 2, true
    @joeySprite.animations.add 'hit', [4, 5], 10, true
    @joeySprite.animations.add 'dead', [6], 2, true

    @sausagesSprite = @add.sprite OFFSTAGERIGHT, y + 100, 'sausages'
    @sausagesSprite.anchor.setTo 0.5, 0.5
    @sausagesSprite.animations.add 'carried', [0], 2, true
    @sausagesSprite.animations.add 'dropped', [1], 2, true

  addSounds: ->
    @punchSound = @add.audio 'punch'
    @judySound = @add.audio 'judy'
    @babySound = @add.audio 'baby'
    @policeSound = @add.audio 'police'
    @joeySound = @add.audio 'joey'
    @crocSound = @add.audio 'croc'

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
    @babyLines = @readFile('baby')
    @policeLines = @readFile('police')
    @joeyLines = @readFile('joey')
    @crocLines = @readFile('croc')

  cheerHandler: =>
    @pubsub.publish {agent: 'audience', functor: 'response', value: 'cheer'}

  booHandler: =>
    @pubsub.publish {agent: 'audience', functor: 'response', value: 'boo'}

  create: ->
    #@game.stage.backgroundColor = '#000000'
    @add.sprite 0, 0, 'backdrop'

    @reactionText = ''
    #@reactionText = 'Audience Reacts!'


    #@xmppsub.conn.options.sync = true
    #@pubsub = new PubSub('/http-bind/')

    @addAnims()
    @addSounds()
    @addLines()

    @puppets = []
    @punch = new Puppet('punch', @punchSprite, @punchLines, @punchSound)
    @judy = new Puppet('judy', @judySprite, @judyLines, @judySound)
    @baby = new Puppet('baby', @babySprite, @babyLines, @babySound)
    @joey = new Puppet('joey', @joeySprite, @joeyLines, @joeySound)
    @croc = new Puppet('croc', @crocSprite, @crocLines, @crocSound)
    @police = new Puppet('police', @policeSprite, @policeLines, @policeSound)

    @puppets.push(@punch)
    #@puppets.push(@judy)
    #@puppets.push(@baby)
    @puppets.push(@joey)
    @puppets.push(@croc)
    #@puppets.push(@police)

    @sausages = new Item('sausages', @sausagesSprite)

    @eh = new EventHandler(@game)
    @pubsub = new PubSub('http://localhost:5280/http-bind/', @eh, this)
    #@pubsub = new PubSub('http://localhost:5280/http-bind/', @eh, this)

    @add.sprite 0, 0, 'curtains'

    @audienceText = @add.bitmapText(@game.width / 2, @game.height / 2, 'minecraftia', @reactionText)
    @audienceText.tint = 0xFFFF00
    @audienceText.align = 'center'
    @audienceText.x = @game.width / 2 - @audienceText.textWidth / 2

    @cheerButton = @game.add.button(200, @game.height - 80, 'cheerButton', @cheerHandler, this, 2, 1, 0)
    @booButton = @game.add.button(@game.width - 300, @game.height - 80, 'booButton', @booHandler, this, 2, 1, 0)

  update: ->
    puppet.update() for puppet in @puppets
    @sausages.update()
    noise = @game.mic.getSamples()
    #console.log noise
    if @game.input.keyboard.isDown(Phaser.Keyboard.SPACEBAR) or noise > 0.7
      @audienceText.text = @reactionText
      @pubsub.publish {agent: 'audience', functor: 'response', value: 'cheer'}
    else
      @audienceText.text = ""



module.exports = Show
