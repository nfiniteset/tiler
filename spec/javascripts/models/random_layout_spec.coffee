describe 'TreeLayout model', ->
  beforeEach ->
    @tile = new TILER.models.Tile {name:'tile', arcs: ['ns']}
    @tileA = new TILER.models.Tile {name:'tileA', arcs: ['es']}
    @tileB = new TILER.models.Tile {name: 'tileB', arcs: ['ws']}
    @tileC = new TILER.models.Tile {name: 'tileC', arcs:['nw', 'ws']}
    @tileset = new TILER.collections.Tileset [@tile, @tileA, @tileB, @tileC]
    @layout = new TILER.models.TreeLayout
      width: 4
      height: 4
      tileset: @tileset

  describe '#getSpotOnSide', ->
    beforeEach ->
      @layout.placeTile(1,1,@tile)
      @northSpot = @layout.getSpotOnSide(@tile, 'n')
      @eastSpot= @layout.getSpotOnSide(@tile, 'e')
      @southSpot= @layout.getSpotOnSide(@tile, 's')
      @westSpot= @layout.getSpotOnSide(@tile, 'w')

    it 'finds neighboring spots', ->
      expect(@northSpot.x).toBe(1)
      expect(@northSpot.y).toBe(0)
      expect(@eastSpot.x).toBe(2)
      expect(@eastSpot.y).toBe(1)
      expect(@southSpot.x).toBe(1)
      expect(@southSpot.y).toBe(2)
      expect(@westSpot.x).toBe(0)
      expect(@westSpot.y).toBe(1)
