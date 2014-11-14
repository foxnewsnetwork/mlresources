class Apiv1.AdminTranslationRoute extends Ember.Route
  model: (params) ->
    oldTranslations: @oldTranslations(params.key)
    newTranslations: @newTranslations(params.key)

  oldTranslations: (key) ->
    @store.find("translation", key: key)

  newTranslations: (key) ->
    tls = _.map Apiv1.Translation.KnownLanguages, (lng, loc) =>
      @store.createRecord "translation", locale: loc, key: key
    _.sortBy tls, (translation) -> translation.get("locale")