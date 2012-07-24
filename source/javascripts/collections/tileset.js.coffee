class TILER.collections.Tileset extends Backbone.Collection
  model: TILER.models.Tile

  removeFromGrid: ->
    @each (tile) ->
      tile.removeFromGrid()