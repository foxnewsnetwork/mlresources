class Apiv1.FilePreviewer
  @generate-data-urls = (files) ->
    _.map files, _.bind(@generateDataUrl, @)
  @generate-data-url = (file) ->
    fp = new Apiv1.FilePreviewer(file)
    fp.data-url!
  (@file) ->
  data-url: ->
    @read-promise!.then (reader) -> reader.result
  read-promise: ->
    @promise-maker (resolve) ~>
      @resolution-file-reader(resolve).readAsDataURL @file
      
  promise-maker: (handlers) ->
    DS.PromiseObject.create promise: new Ember.RSVP.Promise(handlers)

  resolution-file-reader: (resolve) ->
    r = new FileReader()
    r.onloadend = (e) ->
      resolve e.target
    r