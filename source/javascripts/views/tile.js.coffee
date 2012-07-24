class TILER.views.Tile extends Backbone.View
  
  tagName: 'li'
  
  initialize: ->
    @$el.append("<img />")
    @model.bind 'change:x', @updateX, @
    @model.bind 'change:y', @updateY, @
    @model.bind 'change:asset', @updateAsset, @
    @model.bind 'change:filled', @updateFilled, @

  updateX: ->
    @$el.css 'left', @model.get('x') * 200
  
  updateY: ->
    @$el.css 'top', @model.get('y') * 200
  
  updateAsset: ->
    @$('img').attr('src', "/images/#{@model.get('asset')}")
  
  updateFilled: ->
    if @model.get('filled')
      @$el.addClass('filled')
    else
      @$el.removeClass('filled')
  
  render: ->
    @updateX()
    @updateY()
    @updateAsset()
    @updateFilled()
    @