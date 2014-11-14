class Apiv1.SelectLocaleComponent extends Ember.Component
  classNames: ['select-locale']
  attributeBindinds: ['class']
  KnownLanguages: Apiv1.Translation.KnownLanguages
    
  +computed I18n.locale
  locale: (key, value) -> 
    if arguments.length > 1 && I18n.locale? && I18n.locale isnt value
      I18n.changeLocale value
    I18n.locale

  +computed KnownLanguages
  locales: -> _.keys @KnownLanguages

  +computed locales.@each
  localeLanguages: ->
    _.map @locales, (locale) =>
      language: @KnownLanguages[locale] || locale
      id: locale