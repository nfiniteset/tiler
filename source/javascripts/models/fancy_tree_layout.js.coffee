class TILER.models.FancyTreeLayout extends TILER.models.Layout
  
  fillGrid: ->
    super
    firstTile = @placeFirstTile()
    @findAndPlaceMatchingTiles(firstTile)
    @fillSpace()
    
  placeFirstTile: ->
    # firstTile = @tileset.at(12)
    firstTile = @getRandomTile()
    @placeTile(Math.floor(@width/2), @height-1, firstTile)
    firstTile

  findAndPlaceMatchingTiles: (root) ->
    sides = @getSidesToMatch(root)
    for side in sides
      newSpot = @getSpotOnSide(root, side)
      break if !newSpot || @tileAt(newSpot.x, newSpot.y)
      newTile = @findMatchingTile(root, side)
      if newTile
        @placeTile newSpot.x, newSpot.y, newTile
        if @getSidesToMatch(newTile)
          @findAndPlaceMatchingTiles(newTile)

  getSidesToMatch: (tile) ->
    sides = ['n', 'e', 's', 'w']
    
    _.filter sides, (side) =>
      spot = @getSpotOnSide(tile, side)
      # remove sides adjacent to the edge of the grid
      return false if @atBorder(side, tile)
      # remove sides occupied by another tile
      return false if spot && @tileAt spot.x, spot.y
      true

  findMatchingTile: (root, side) ->
    tiles = @availableTiles.sort -> 0.5 - Math.random()
    _.find tiles, (tile) =>
      @fitsSide(root, tile, side)

  fitsSide: (root, tile, edge) ->
    matchingEdge = switch edge
      when 'n' then 's'
      when 'e' then 'w'
      when 's' then 'n'
      when 'w' then 'e'
    rootEdge = root.get('edges')[edge]
    comparisonEdge = tile.get('edges')[matchingEdge]
    @compare(rootEdge, comparisonEdge)

  compare: (edge1, edge2) ->
    matches = []
    _.each [0..edge1.length], (i) ->
      val1 = edge1[i]
      val2 = edge2[i]
      diff = Math.abs(val2 - val1)
      matches.push diff if diff < 2000
    matches.length * (1 / edge1.length) >= .6

  getSpotOnSide: (tile, side) ->
    x = tile.get('x')
    y = tile.get('y')
    switch side
      when 'n' then {x:x, y:y-1}
      when 'e' then {x:x+1, y:y}
      when 's' then {x:x, y:y+1}
      when 'w' then {x:x-1, y:y}

