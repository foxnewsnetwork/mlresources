class Apiv1.TrSpanComponent extends Ember.Component
  tagName: "span"
  classNames: ["i18n-translated-span"]
  opts: {}
  +computed I18n.locale, key, opts
  translated: ->
    return "" if Ember.isBlank I18n.locale
    Ember.assert "Translations require string keys, not null", @key?
    if tld = I18n.lookup @key, @opts
      delete I18n.missingKeys[@key] if I18n.missingKeys?
      tld
    else
      I18n.missingKeys ||= {}
      I18n.missingKeys[@key] ||= @en
      @en

  +computed en
  key: ->
    Apiv1.StringEx.keyify @en