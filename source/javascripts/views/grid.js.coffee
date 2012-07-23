class TILER.views.Grid extends Backbone.View
  
  initialize: () ->
    {@tileset, @layout} = @options
    _.bindAll @, ['render']
    $(document).on 'keydown', @render
    @list = $('<ul></ul>')
    @$el.append(@list)
    @tileset.each (tile) =>
      tileView = new TILER.views.Tile {model: tile}
      @list.append(tileView.render().el)
    
  render: () ->
    @$el.css('width', @layout.width*100)
    @layout.fillGrid()
    @