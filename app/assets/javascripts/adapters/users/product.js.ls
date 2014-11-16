Apiv1.UsersProductAdapter = DS.ActiveModelAdapter.extend do
  namespace: "users"
  ajax-options: (url, type, hash) ->  
    hash || {}
      ..url = url
      ..type = type
      ..dataType = 'json'
      ..context = @
      if hash.data and type isnt 'GET'
        ..processData = false
        ..contentType = false
        ..data = @process-form-data hash.data
      if @get 'headers'
        ..before-send = @process-headers-etc @get 'headers'

  process-headers-etc: (headers, xhr) -->
    for-each.call Ember.keys(headers), (key) -> xhr.set-request-header key, headers[key]

  process-form-data: (data) ->
    Apiv1.FormDataTransformer.object-to-form-data data