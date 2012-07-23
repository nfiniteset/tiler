describe 'Tile model', ->
  beforeEach ->
    @tile = new TILER.models.Tile {
      arcs: ['ne', 'se']
    }
    
  describe '#getConnectingSides',->
    beforeEach ->
      @sides = @tile.getConnectingSides()
      
    it 'returns each connecting side once', ->
      expect(@sides).toContain('n')
      expect(@sides).toContain('e')
      expect(@sides).toContain('s')
      expect(@sides.length).toBe(3)
     
    it 'doesnt return non-connecting sides', ->
      expect(@sides).not.toContain('w')
      