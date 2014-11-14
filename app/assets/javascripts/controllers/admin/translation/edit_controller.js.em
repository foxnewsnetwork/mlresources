class Apiv1.AdminTranslationEditController extends Ember.ObjectController
  
  +computed model.oldTranslations.@each.id
  olds: ->
    return [] unless @get("model.oldTranslations.length") > 0
    @model.oldTranslations.sortBy("locale")

  +computed model.newTranslations
  news: ->
    @get "model.newTranslations"

  +computed olds, news
  translations: ->
    return @news if Ember.isBlank @olds
    @concatByLocale @news, @olds

  concatByLocale: Apiv1.ArrayEx.replaceConcat (newT, oldT) ->
    newT.get("locale") is oldT.get("locale")
  