class Apiv1.AdminTranslationsIndexRoute extends Ember.Route
  queryParams: 
    query:
      refreshModel: true
    page:
      refreshModel: true
    per:
      refreshModel: true
    locale:
      refreshModel: true
  query: ''
  page: 1
  per: 50
  locale: 'en'

  findTranslations: (p) ->
    @store.find "translation", p
    
  model: (params) ->
    translations: @findTranslations params