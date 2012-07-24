describe 'Tile model', ->
  beforeEach ->
    @tile = new TILER.models.Tile {
      arcs: ['ne', 'se']
    }
    
  describe '#removeFromGrid', ->
    beforeEach ->
      @tile.set('x', 3)
      @tile.set('y', 2)
      @tile.set('filled', false)
      @tile.removeFromGrid()
      
    it 'removes grid properties', ->
      expect(@tile.get('x')).not.toBeDefined()
      expect(@tile.get('y')).not.toBeDefined()
      expect(@tile.get('filled')).not.toBeDefined()
    
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
      