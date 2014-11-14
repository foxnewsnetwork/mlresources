mixin Apiv1.TypeAheadBuilderMixin
  typeaheadOpts:
    hint: true
    highlight: true
    minLength: 1

  initializeTypeahead: (data) ->
    @typeahead = @$().typeahead @typeaheadOpts, @generateTypeaheadParams data
    @typeahead.on "typeahead:selected", (e, item) => 
      @set "selection", item.emberObject
    @typeahead.on "typeahead:autocompleted", (e, item) => @set "selection", item.emberObject
    if @get "selection"
      @typeahead.val @get "selection.presentation"

  bloodhoundSource: (data)->
    b = new Bloodhound @bloodOptionsMaker data
    b.initialize()
    b

  generateTypeaheadParams: (data) ->
    name: @$().attr('id') || "typeahead"
    limit: @get("limit") || 5
    displayKey: "presentation"
    source: @bloodhoundSource(data).ttAdapter()
    
  localizeData: (data) ->
    data.map _.bind(@transformItem2Datum, @)

  transformItem2Datum: (item) ->
    value: item.get(@get("name"))
    name: item.get(@get("name"))
    presentation: item.get('presentation') || item.get(@get("name"))
    emberObject: item

  bloodOptionsMaker: (data) ->
    datumTokenizer: @_datumTokenizer
    queryTokenizer: Bloodhound.tokenizers.whitespace
    local: @localizeData data

  _datumTokenizer: (datum) ->
    datum.presentation.split /[\s\-_:\+]+/