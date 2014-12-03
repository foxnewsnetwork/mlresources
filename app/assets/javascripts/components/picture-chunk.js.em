class Apiv1.PictureChunkComponent extends Ember.Component
  classNames: ["picture-chunk"]

  +computed picture.src
  src: -> @get("picture.src")

  +computed picture.fileName
  fileName: -> @get("picture.fileName")

  +computed model
  picture: ->
    return if Ember.isBlank @model
    Apiv1.ListingsPicture.fromFile @model

  actions:
    killPicture: ->
      @controller.sendAction "action", @model