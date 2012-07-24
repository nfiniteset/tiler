window.TILER = {
  models: {}
  views: {}
  collections: {}
  tilesets: {}
}

$ ->
  data = TILER.tilesets.coloredPencils
  tileset = new TILER.collections.Tileset(data.tiles, data)
  TILER.grid = new TILER.views.Grid
    el: '.grid'
    tileset: tileset
    layout: new TILER.models.TreeLayout
      tileset: tileset
      width: 4
      height: 4
      tileHeight: data.tileHeight
      tileWidth: data.tileWidth
  TILER.grid.render()