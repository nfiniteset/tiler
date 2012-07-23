dscribe 'TreeLayout model', ->
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

  describe '#getSidesToMatch', ->
    describe 'with a tile agaist', ->
    
    beforeEach ->
      @layout.placeTile(1, 3, @tile)
      @layout.placeTile(1, 2, @tileB)
      @sidesToMatch = @layout.getSidesToMatch(@tileB)
      
    it '', ->