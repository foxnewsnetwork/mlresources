class Apiv1.AdminTranslationsIndexController extends Ember.ObjectController
  locales: ["", "af", "sq", "ar", "be", "bg", "ca", "zh-CN", "zh-TW", "hr", "cs", "da", "nl", "en", "et", "tl", "fi", "fr", "gl", "de", "el", "iw", "hi", "hu", "is", "id", "ga", "it", "ja", "ko", "la", "lv", "lt", "mk", "ms", "mt", "no", "fa", "pl", "pt", "ro", "ru", "sr", "sk", "sl", "es", "sw", "sv", "th", "tr", "uk", "vi", "cy", "yi"]
  queryParams: ["locale"]
  locale: ''

  +computed model.translations
  translations: -> 
    @model.translations

  +volatile
  missingTranslations: ->
    translations = _.map I18n.missingKeys, (value, key) => 
      if Ember.isBlank I18n.lookup key
        @store.createRecord "translation",
          key: key
          translatedText: value
          locale: I18n.locale

    _.reject translations, Ember.isBlank