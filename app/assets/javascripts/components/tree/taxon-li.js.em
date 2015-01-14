class Apiv1.TreeTaxonLiComponent extends Ember.Component
  tagName: 'li'
  classNames: ['tree-taxon-li']
  classNameBindings: ['isSelected:selected', 'isExpanded:expanded']
  adminMode: false

  +computed taxon, activeTaxons.@each, isExpandable
  isExpanded: (key, expand) -> 
    return false unless @isExpandable
    if arguments.length > 1
      @expansionCoefficient = expand
    if Ember.isBlank @expansionCoefficient
      @expansionCoefficient = @isExpandable and @activeTaxons.contains @taxon
    @expansionCoefficient

  +computed taxon.hasChildren
  isExpandable: -> @get("taxon.hasChildren")

  +computed taxon.hasChildren
  isSelectable: -> not @get("taxon.hasChildren")

  +computed taxon, activeTaxons.@each, isSelectable
  isSelected: (key, select) ->
    return false unless @isSelectable
    if arguments.length > 1
      @selectionCoefficient = select
    if Ember.isBlank @selectionCoefficient
      @selectionCoefficient = @isSelectable and @activeTaxons.contains @taxon
    @selectionCoefficient

  +computed adminMode
  adminModeReasonable: ->
    @adminMode && @taxon.id

  toggleExpansion: ->
    if @isExpanded
      @unexpandMe()
    else
      @expandMe()

  toggleSelection: ->
    if @isSelected
      @unselectMe()
    else
      @selectMe()

  unexpandMe: ->
    @isExpanded = false
    @sendAction "unselect", @taxon

  expandMe: ->
    @isExpanded = true
    @sendAction "select", @taxon

  unselectMe: ->
    @isSelected = false
    @sendAction "unselect", @taxon

  selectMe: ->
    @isSelected = true
    @sendAction "select", @taxon

  +computed activeTaxons.@each.presentation
  activeTaxonPresentations: ->
    @activeTaxons.mapBy "presentation"

  actions:
    killTaxon: ->
      @taxon.destroyRecord().then -> Apiv1.Flash.register "success", "taxon destroyed", 2000

    interactWithTaxon: ->
      return if @tempLocked
      if @taxon.hasChildren
        @toggleExpansion()
      else
        @toggleSelection()

    select: (taxon) ->
      @sendAction "select", taxon

    unselect: (taxon) ->
      @sendAction "unselect", taxon