STROPHE = require 'strophe'
#StrPub = require 'pubsub'

class XmppSub
  constructor: (@server) ->
    @conn = new Strophe.Connection(@server)
    @conn.connect 'anim@localhost', 'animuser', @onConnect
    @node = 'events'

  onConnect: (status) ->
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
        @subscribe()
      else console.log status

  subscribe: ->
    console.log "hi"

module.exports = XmppSub
