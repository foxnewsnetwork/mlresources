class Apiv1.ProductsProductShowController extends Ember.ObjectController
  queryParams: ['mp']
  mp: null
  +computed model
  product: -> @get "model"

  +computed model.pictures
  pictures: -> @model.pictures

  +computed model.pictures.@each, mp
  mainPic: (key, pic) ->
    return @get("pictures.firstObject") if Ember.isBlank @mp
    @pictures.findBy("id", @mp) || @get("pictures.firstObject")

  actions:
    selectMainPic: (picture) ->
      @mp = picture.get("id")