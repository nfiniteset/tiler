src = '../../source/javascripts'
Tile = require src+'models/tile'

describe 'Layout model', ->
  beforeEach ->
    @tile = new TILER.models.Tile {name:'tile', arcs: ['ns']}
    @tileA = new TILER.models.Tile {name:'tileA', arcs: ['es']}
    @tileB = new TILER.models.Tile {name: 'tileB', arcs: ['ws']}
    @tileC = new TILER.models.Tile {name: 'tileC', arcs:['nw', 'ws']}
    @tileset = new TILER.collections.Tileset [@tile, @tileA, @tileB, @tileC]
    @layout = new TILER.models.Layout
      width: 4
      height: 4
      tileset: @tileset

  describe '#placeTile', ->
    beforeEach ->
      @layout.placeTile(1, 2, @tile)

    it 'assigns a position', ->
      expect(@tile.get('x')).toBe(1)
      expect(@tile.get('y')).toBe(2)

    it 'removes the tile from availableTiles', ->
      expect(@layout.availableTiles).not.toContain(@tile)

    it 'adds the tile to placedTiles', ->
      expect(@layout.placedTiles).toContain(@tile)

  describe '#removeTile', ->
    beforeEach ->
      @layout.placeTile(1,1,@tile)
      @layout.removeTile(@tile)

    it 'removes position', ->
      expect(@tile.get('x')).not.toBeDefined()
      expect(@tile.get('y')).not.toBeDefined()

    it 'adds the tile to availableTiles', ->
      expect(@layout.availableTiles).toContain(@tile)

    it 'removes the tile from placedTiles', ->
      expect(@layout.placedTiles).not.toContain(@tile)

  describe '#clearGrid', ->
    beforeEach ->
      @layout.placeTile(0,3,@tile)
      @layout.placeTile(1,2,@tileA)
      @layout.placeTile(2,1,@tileB)
      @layout.placeTile(3,0,@tileC)
      expect(@layout.placedTiles.length).toBe(4)
      @layout.clearGrid()

    it 'removes all tiles', ->
      expect(@layout.placedTiles.length).toBe(0)

    it 'removes location from each tile', ->
      for tile in @layout.availableTiles
        expect(tile.get('x')).not.toBeDefined()
        expect(tile.get('y')).not.toBeDefined()

  describe '#atBorder', ->
    describe 'with a tile at the upper left', ->
      beforeEach ->
        @layout.placeTile(0, 0, @tile)

      it 'is at the north border', ->
        expect(@layout.atBorder('n', @tile)).toBe(true)

      it 'is at the west border', ->
        expect(@layout.atBorder('w', @tile)).toBe(true)

      it 'isnt at the east border', ->
        expect(@layout.atBorder('e', @tile)).toBe(false)

      it 'isnt at the south border', ->
        expect(@layout.atBorder('s', @tile)).toBe(false)

  describe '#tileAt', ->
    beforeEach ->
      @layout.placeTile(3,2,@tile)

    describe 'when it finds a tile', ->
      beforeEach ->
        @result = @layout.tileAt(3,2)

      it 'returns the tile', ->
        expect(@result).toEqual(@tile)

    describe 'when it doesnt find a tile', ->
      beforeEach ->
        @result = @layout.tileAt(1,1)

      it 'returns null', ->
        expect(@result).toBeNull()