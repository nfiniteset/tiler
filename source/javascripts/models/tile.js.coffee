class TILER.models.Tile extends Backbone.Model
  
  initialize: (@attributes) ->
  
  getConnectingSides: ->
    sides = @get('arcs').join('').split('')
    _.uniq(sides)
    
  removeFromGrid: ->
    @set('x', undefined)
    @set('y', undefined)
    @set('filled', undefined)
    @set('placed', undefined)