class Apiv1.ListingsPicture extends Ember.Object
  +observer file
  manageSource: -> 
    Apiv1.FilePreviewer.generateDataUrl(@file).then (source) => @src = source

  +computed file.name
  fileName: -> @get "file.name"

  +computed file.size
  fileSize: -> @get "file.size"

Apiv1.ListingsPicture.fromFile = (file) ->
  p = new Apiv1.ListingsPicture()
  p.set "file", file
  p.set "permalink", Math.random().toString()
  p
    
