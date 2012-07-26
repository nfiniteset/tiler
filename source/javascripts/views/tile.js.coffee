class TILER.views.Tile extends Backbone.View
  
  tagName: 'li'
  
  initialize: ->
    @$el.append("<img />")
    @model.bind 'change:x', @updateX, @
    @model.bind 'change:y', @updateY, @
    @model.bind 'change:asset', @updateAsset, @
    @model.bind 'change:filled', @updateClass, @
    @model.bind 'change:placed', @updateClass, @

  updateX: ->
    @$el.css 'left', @model.get('x') * 200
  
  updateY: ->
    @$el.css 'top', @model.get('y') * 200
  
  updateAsset: ->
    @$('img').attr('src', "/images/#{@model.get('asset')}")
  
  updateClass: ->
    @$el.toggleClass('filled', !!@model.get('filled'))
    @$el.toggleClass('placed', !!@model.get('placed'))
  
  render: ->
    @updateX()
    @updateY()
    @updateAsset()
    @updateClass()
    @