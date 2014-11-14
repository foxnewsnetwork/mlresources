class Apiv1.ImagePreloader extends Ember.Object
  areWeUsingPreloader: false
  stillLoadingImages: []
  registerImage: (source, callback) ->
    img = new Image()
    @areWeUsingPreloader = true
    @stillLoadingImages.pushObject img
    img.onload = =>
      @stillLoadingImages.removeObject img
      callback img if typeof callback is "function"
    img.src = source

  preloadImagesFromCSS: ->
    Apiv1.ImagesToPreload.map _.bind @registerImage, @

  +computed stillLoadingImages.length, areWeUsingPreloader
  isLoading: ->
    @areWeUsingPreloader and @stillLoadingImages.length > 0


Apiv1.ImagePreloader.instance = new Apiv1.ImagePreloader()
Apiv1.ImagePreloader.instance.preloadImagesFromCSS()
Apiv1.ImagePreloader.registerImage = _.bind Apiv1.ImagePreloader.instance.registerImage, Apiv1.ImagePreloader.instance