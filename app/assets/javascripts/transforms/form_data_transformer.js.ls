class Apiv1.FormDataTransformer
  _is-integer = (number) ->
    _.isFinite(parseInt number) and (parseFloat(number) % 1 is 0)
    
  _is-form-data-primitive = (data) ->
    (data instanceof File) or (typeof data is "string") or (typeof data is "number")

  _make-key = (pre, key) ->
    return key if Ember.is-blank pre
    pre + "[#{key}]"
  

  @shallowify = (hash, pre="") ->
    return {} unless hash
    output = {}
    for key in Ember.keys hash
      value = hash[key]
      new-key = _make-key pre, key
      if _is-form-data-primitive value
        output[new-key] = value
      else
        _.extend output, Apiv1.FormDataTransformer.shallowify(value, new-key)
    output

  @object-to-form-data = (hash) ->
    shallow-hash = Apiv1.FormDataTransformer.shallowify hash
    new FormData!
      for key in Ember.keys shallow-hash
        ..append key, shallow-hash[key]