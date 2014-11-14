class Apiv1.Translation extends DS.Model
  locale: DS.attr "string"
  key: DS.attr "string"
  translatedText: DS.attr "string"

  +computed key
  peersHash: ->
    return unless @key
    @store.find("translation", key: @key).reduce @reducer, {}
  
  reducer: (output, translation) -> 
    output[translation.get("locale")] = translation
    output

  +computed locale
  language: ->
    Apiv1.Translation.KnownLanguages[@locale] || "Unknown Language for #{@locale}"

Apiv1.Translation.KnownLanguages =
  "ar": "العربية"
  "id": "Bahasa Indonesia"
  "ms": "Bahasa Melayu"
  "ca": "Català"
  "da": "Dansk"
  "de": "Deutsch"
  "en": "English"
  "es": "Español"
  "el": "Eλληνικά"
  "fr": "Français"
  "it": "Italiano"
  "hu": "Magyar"
  "nl": "Nederlands"
  "no": "Norsk"
  "pl": "Polski"
  "pt": "Português"
  "fi": "Suomi"
  "sv": "Svenska"
  "tr": "Türkçe"
  "is": "Íslenska"
  "cs": "Čeština"
  "ru": "Русский"
  "th": "ภาษาไทย"
  "zh-CN": "中文 (简体)"
  "zh-TW": "中文 (繁體)"
  "ja": "日本語"
  "ko": "한국어"