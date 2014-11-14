throttler = (fun) -> _.throttle fun, 1250
window.I18n.changeLocale = throttler (locale) ->
  (data) <- $.get "apiv1/i18n_translations.js?locale=#{locale}"
  Ember.set window.I18n, "translations", data.translations
  Ember.set window.I18n, "locale", data.locale  

I18n.changeLocale ""