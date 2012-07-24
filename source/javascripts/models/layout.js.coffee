class TILER.models.Layout

  constructor: (@attributes) ->
    {@tileset, @width, @height} = @attributes
    @placedTiles = []
    @availableTiles = @tileset.models

  fillGrid: ->
    @clearGrid()

  clearGrid: ->
    @availableTiles = @availableTiles.concat @placedTiles
    @placedTiles = []
    for tile in @availableTiles
      tile.removeFromGrid()

  getRandomTile: ->
    @availableTiles[ Math.floor(Math.random()*@availableTiles.length) ]

  placeTile: (x, y, tile) ->
    return if @tileAt(x,y)
    tile.set('x', x)
    tile.set('y', y)
    @availableTiles.splice(@availableTiles.indexOf(tile), 1)
    @placedTiles.push(tile)
    lastTile = tile
    
  removeTile: (tile) ->
    tile.removeFromGrid()
    @placedTiles.splice(@placedTiles.indexOf(tile), 1)
    @availableTiles.push(tile)

  atBorder: (border, tile) ->
    switch border
      when 'n' then tile.get('y') == 0
      when 'e' then tile.get('x') == @width-1
      when 's' then tile.get('y') == @height-1
      when 'w' then tile.get('x') == 0

  tileAt: (x, y) ->
    tile = _.find @placedTiles, (tile) ->
      tile.get('x') == x && tile.get('y') == y
    tile || null
    
  fillSpace: ->
    for row in [0..@height-1]
      for column in [0..@width-1]
        if !@tileAt(row, column)
          tile = @getRandomTile()
          if tile
            tile.set('filled', true)
            @placeTile(row, column, tile)
