class EventHandler
  constructor: (@game) ->
  addEvent: (@event) ->
    @game.time.events.add(@event.delay, @event.trigger, @event)

module.exports = EventHandler

