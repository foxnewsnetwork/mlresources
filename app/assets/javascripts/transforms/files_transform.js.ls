Apiv1.FileTransform = DS.Transform.extend do
  serialize: (file) -> file

Apiv1.FilesTransform = DS.Transform.extend do
  serialize: (files) ->
    return if Ember.is-blank files
    _.map files, (file) -> file