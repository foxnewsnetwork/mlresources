class Apiv1.TypeAheadComponent extends Ember.TextField with Apiv1.TypeAheadBuilderMixin
  +observer selection
  selectionObserver: ->
    if Ember.isEmpty @get 'selection'
      @typeahead.val('')
    else
      s = @get("selection").get @get "name"
      @typeahead.val s

  didInsertElement: ->
    @_super()
    if $.isFunction @get("data").then
      @get("data").then (data) => @initializeTypeahead data
    else
      @initializeTypeahead @get "data"

  