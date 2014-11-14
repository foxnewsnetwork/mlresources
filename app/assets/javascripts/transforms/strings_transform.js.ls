Apiv1.StringsTransform = DS.Transform.extend do
  serialize: (strings) ->
    return if Ember.is-blank strings
    _.map strings, (string) -> string