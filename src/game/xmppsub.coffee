STROPHE = require 'strophe'
StrPub = require 'pubsub'

class XmppSub
  constructor: (@server) ->
    @node = 'evnode'
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
    console.log (message.getElementsByTagName 'JSON')[0]
    true

  onSubscribed: =>
    console.log "SUBSCRIBED to " + @node
    @conn.addHandler(@onEvent, null, 'message', null, null, null)

  onError: =>
    console.log "Failed to subscribe to " + @node
    #@conn.pubsub.createNode(@node)

module.exports = XmppSub
