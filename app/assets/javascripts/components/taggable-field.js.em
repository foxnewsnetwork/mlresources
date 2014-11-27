class Apiv1.TaggableFieldComponent extends Ember.Component
  tags: []
  classNames: ['taggable-field']
  attributeBindings: ["class"]
  text: ""

  +observer tags.@each.id, tags.@each.taxonName
  fixTextOnTagChange: ->
    tokenFromTags = @batchTokenify @tags
    @appendMissingText tokenFromTags
    @dropUnwantedText tokenFromTags

  +computed text
  existingTextTokens: ->
    Apiv1.TagParser.parse(@text).tagTokens()

  appendMissingText: (texts) ->
    missing = _.difference texts, @existingTextTokens
    @text = [@text.trim(), missing.join(" ").trim()].join " "

  dropUnwantedText: (texts)->
    stuffToRemove = _.difference @existingTextTokens, texts
    for str in stuffToRemove
      @text = @text.split(str).join("")

  batchTokenify: (tags) ->
    return [] if Ember.isBlank tags
    tags.map Apiv1.TagParser.tokenifyTaxon
