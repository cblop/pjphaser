STROPHE = require 'strophe'
StrPub = require 'pubsub'
MoveEvent = require './moveEvent'
SpeakEvent = require './speakEvent'
AnimEvent = require './animEvent'

class XmppSub
  constructor: (@server, @eventHandler, @context) ->
    @node = 'events'
    @conn = new Strophe.Connection(@server)
    @conn.connect 'anim@localhost', 'animuser', @onConnect

  onConnect: (status) =>
    switch status
      when Strophe.Status.CONNECTING
        console.log "CONNECTING"
      when Strophe.Status.CONNFAIL
        console.log "CONNFAIL"
      when Strophe.Status.DISCONNECTING
        console.log "DISCONNECTING"
      when Strophe.Status.DISCONNECTED
        console.log "DISCONNECTED"
      when Strophe.Status.CONNECTED
        console.log "CONNECTED"
        #@conn.pubsub.connect('punch@localhost', null)
        @subscribe()
      else console.log status

  disconnect: ->
    @conn.disconnect()

  subscribe: ->
    @conn.pubsub.subscribe(@node, null, @onEvent, @onSubscribed, @onError, false)

  onEvent: (message) =>
    jsonString = (message.getElementsByTagName 'JSON')[0].innerHTML
    eventObj = JSON.parse(jsonString)
    functor = eventObj['FUNCTOR']
    agent = eventObj['AGENT']
    value = eventObj['VALUE']
    console.log jsonString

    puppet = @context.punch
    for p in @context.puppets
      if p.name == agent
        puppet = p

    if functor == 'move'
      console.log 'move: ' + puppet.name + ' to: ' + value
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
      puppet.emotion = value
      @eventHandler.addEvent(new SpeakEvent(puppet, 0))

    else if functor == 'anim'
      @eventHandler.addEvent(new AnimEvent(puppet, 0, value))

    true

  onSubscribed: =>
    console.log "SUBSCRIBED to " + @node
    @conn.addHandler(@onEvent, null, 'message', null, null, null)

  onError: =>
    console.log "Failed to subscribe to " + @node
    #@conn.pubsub.createNode(@node)

module.exports = XmppSub
