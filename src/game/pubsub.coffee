STROPHE = require 'strophe'
StrPub = require 'pubsub'
MoveEvent = require './moveEvent'
SpeakEvent = require './speakEvent'
AnimEvent = require './animEvent'

class PubSub
  constructor: (@server, @eventHandler, @context) ->
    @node = 'ev'
    @conn = new Strophe.Connection(@server)
    @conn.connect 'anim@cblop.com', 'animuser', @onConnect
    #@conn.connect 'anim@localhost', 'animuser', @onConnect

  onConnect: (status) =>
    switch status
      when Strophe.Status.CONNECTING
        console.log "CONNECTING"
      when Strophe.Status.CONNFAIL
        console.log "CONNFAIL"
        @onError()
      when Strophe.Status.DISCONNECTING
        console.log "DISCONNECTING"
      when Strophe.Status.DISCONNECTED
        console.log "DISCONNECTED"
        @onError()
      when Strophe.Status.CONNECTED
        console.log "CONNECTED"
        #@conn.pubsub.connect('punch@localhost', null)
        @subscribe()
      else console.log status

  disconnect: ->
    @conn.disconnect()

  subscribe: ->
    @conn.pubsub.subscribe(@node, null, @onEvent, @onSubscribed, @onError, false)

  publish: (message, @onPublished) ->
    # IMPORTANT: change server value here
    #msg = $iq({type: 'set', from: @conn.jid, to: 'pubsub@' + 'localhost'}).c('pubsub', {xmlns: 'http://jabber.org/protocol/pubsub'}).c('publish', {node: @node}).list('item', [message])
    #console.log msg.toString()
    #jsonString = '{&quot;AGENT&quot; &quot;test&quot; &quot;FUNCTOR&quot; &quot;say&quot; &quot;VALUE&quot; &quot;test&quot;}'
    jsonString = '{"AGENT": "' + message.agent + '", "FUNCTOR": "' + message.functor + '", "VALUE": "' + message.value + '"}'
    #jsonString = "Test string"

    #json = document.createElement("JSON")
    #tnode = document.createTextNode(jsonString)

    xml = $build('JSON', {}).t(jsonString).tree()

    #xml = json.appendChild tnode
    msg = {attrs: {}, data: xml}
    #console.log msg

    @conn.pubsub.publish(@node, [msg], @onPublished)

  onPublished: =>
    #console.log 'Published message'
    true

  onEvent: (message) =>
    jsonString = (message.getElementsByTagName 'JSON')[0].innerHTML
    eventObj = JSON.parse(jsonString)
    functor = eventObj['FUNCTOR']
    agent = eventObj['AGENT']
    value = eventObj['VALUE']
    #console.log message

    puppet = @context.punch
    for p in @context.puppets
      if p.name == agent
        puppet = p

    if functor == 'move'
      #console.log 'move: ' + puppet.name + ' to: ' + value
      target = OFFSTAGELEFT
      switch value
        when 'offstageLeft' then target = OFFSTAGELEFT
        when 'offstageRight' then target = OFFSTAGERIGHT
        when 'stageLeft' then target = STAGELEFT
        when 'stageRight' then target = STAGERIGHT
        when 'stageCentre' then target = STAGECENTRE
        else target = OFFSTAGELEFT

      mv = new MoveEvent(puppet, 0, target)
      @eventHandler.addEvent(mv)

    else if functor == 'say'
      #console.log 'puppet: ' + puppet.name + ' says: ' + value
      @eventHandler.addEvent(new SpeakEvent(puppet, 0, value))

    else if functor == 'anim'
      #console.log 'puppet: ' + puppet.name + ' anim: ' + value
      @eventHandler.addEvent(new AnimEvent(puppet, 0, value))

    else if functor == 'emotion'
      #console.log 'puppet: ' + puppet.name + ' emotion: ' + value
      puppet.emotion = value
    console.log agent + ', ' + functor + ', ' + value


    true

  onSubscribed: =>
    console.log "SUBSCRIBED to " + @node
    @conn.addHandler(@onEvent, null, 'message', null, null, null)
    @conn.addHandler(@debugHandler, null, null, null, null, null)
    @publish {agent: 'director', functor:'start', value: 'start'}

  debugHandler:(iq) =>
    #console.log iq
    true

  onError: =>
    console.log "Failed to subscribe to " + @node
    @context.game.state.start 'error'
    #@conn.pubsub.createNode(@node)

module.exports = PubSub
