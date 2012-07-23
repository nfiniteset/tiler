window.TILER = {
  models: {}
  views: {}
  collections: {}
}

$ ->
  tileset = new TILER.collections.Tileset(TILER.tileset8x8)
  TILER.grid = new TILER.views.Grid
    el: '.grid'
    tileset: tileset
    layout: new TILER.models.TreeLayout
      tileset: tileset
      width: 8
      height: 8
  TILER.grid.render()