class Apiv1.HashEx
  @camelize = (hash) ->
    output = {}
    for key, value of hash
      output[Ember.String.camelize key] = value
    output