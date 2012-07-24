class TILER.models.TreeLayout extends TILER.models.Layout
  
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
      newTile = @findMatchingTile(side)
      if newTile
        @placeTile newSpot.x, newSpot.y, newTile
        if @getSidesToMatch(newTile)
          @findAndPlaceMatchingTiles(newTile)
    
  getSidesToMatch: (tile) ->
    sides = tile.getConnectingSides()
    
    _.filter sides, (side) =>
      spot = @getSpotOnSide(tile, side)
      # remove sides adjacent to the edge of the grid
      return false if @atBorder(side, tile)
      # remove sides occupied by another tile
      return false if spot && @tileAt spot.x, spot.y
      true

  findMatchingTile: (side) ->
    tiles = @availableTiles.sort -> 0.5 - Math.random()
    _.find tiles, (tile) =>
      @fitsSide(tile, side)

  getSpotOnSide: (tile, side) ->
    x = tile.get('x')
    y = tile.get('y')
    switch side
      when 'n' then {x:x, y:y-1}
      when 'e' then {x:x+1, y:y}
      when 's' then {x:x, y:y+1}
      when 'w' then {x:x-1, y:y}

  fitsSide: (tile, side) ->
    matchingSide = switch side
      when 'n' then 's'
      when 'e' then 'w'
      when 's' then 'n'
      when 'w' then 'e'
    _.contains(@getSidesToMatch(tile), matchingSide)
