Ember.Handlebars.register-helper 'i18n', (property, options) ->
  params = options.hash
  I18n.t property, params  
