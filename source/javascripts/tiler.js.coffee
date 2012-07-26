window.TILER = {
  models: {}
  views: {}
  collections: {}
  tilesets: {}
}

$ ->
  $.getJSON 'javascripts/data/colored_pencil.json', (data) ->
    console.log data
    tileset = new TILER.collections.Tileset(data.tiles, data)
    TILER.grid = new TILER.views.Grid
      el: '.grid'
      tileset: tileset
      layout: new TILER.models.FancyTreeLayout
        tileset: tileset
        width: 4
        height: 4
        tileHeight: data.tileHeight
        tileWidth: data.tileWidth
    TILER.grid.render()