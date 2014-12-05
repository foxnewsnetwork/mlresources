class Apiv1.PicturesGroupComponent extends Ember.Component
  classNames: ["pictures-group"]
  pictures: []
  totalAllowedSize: "10 mb"

  +computed images.@each.fileSize
  totalFileSize: ->
    Apiv1.StringEx.byteUnits @images.reduce @pictureSummer, 0


  +computed pictures.@each
  images: ->
    return [] if Ember.isBlank @pictures
    @pictures.map (pic) => Apiv1.ListingsPicture.fromFile pic

  pictureSummer: (sumSizes, image) ->
    sumSizes + image.get("fileSize")

  actions:
    killPicture: (picture) ->
      @pictures.removeObject picture