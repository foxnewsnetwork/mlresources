class Apiv1.PicturesGroupComponent extends Ember.Component
  classNames: ["pictures-group"]
  pictures: []

  actions:
    killPicture: (picture) ->
      @pictures.removeObject picture