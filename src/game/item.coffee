class Item
  constructor: (@name, @sprite) ->
    @owner = ""

  bind: (puppet) ->
    @owner = puppet

  eaten: ->
    @owner = ""
    @sprite.x = OFFSTAGERIGHT

  update: ->
    if @owner != ""
      @sprite.x = @owner.sprite.x
      @sprite.animations.play "carried"
    else
      @sprite.animations.play "dropped"

module.exports = Item
