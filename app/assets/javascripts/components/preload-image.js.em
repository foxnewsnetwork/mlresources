class Apiv1.PreloadImageComponent extends Ember.Component
  attributeBindings: ["id", "class", "alt", "src"]
  classNames: ["preload-image"]
  tagName: ['img']
  alreadyQueuedPreloader: false

  +observer source
  manageSourcePreloading: ->
    return if @alreadyQueuedPreloader or Ember.isBlank @source
    @alreadyQueuedPreloader = true
    Apiv1.ImagePreloader.registerImage @source, (img) => @src = img.src
    
  didInsertElement: ->
    @manageSourcePreloading()