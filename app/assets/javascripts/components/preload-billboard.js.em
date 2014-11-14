class Apiv1.PreloadBillboardComponent extends Ember.Component
  classNames: ["preload-billboard"]
  alreadyLoaded: false
  +computed Apiv1.ImagePreloader.instance.isLoading
  stillLoading: -> Apiv1.ImagePreloader.instance.get "isLoading"

  +computed Apiv1.ImagePreloader.instance.isLoading
  finishedLoading: -> not Apiv1.ImagePreloader.instance.get "isLoading"

  +observer Apiv1.ImagePreloader.instance.isLoading
  manageWhichToHide: ->
    return if @alreadyLoaded
    if @stillLoading
      $("#billboard-holder").show()
      $("#everything-else-holder").hide()
    if @finishedLoading
      @alreadyLoaded = true
      $("#everything-else-holder").show()
      $("#billboard-holder").hide "puff", 750

  didInsertElement: ->
    @manageWhichToHide()