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
    unless @expansionCoefficient?
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
    unless @selectionCoefficient?
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

  expandMe: ->
    @isExpanded = true

  unselectMe: ->
    @activeTaxons ||= []
    @activeTaxons.removeObject @taxon
    @isSelected = false

  selectMe: ->
    @activeTaxons ||= []
    @activeTaxons.addObject @taxon
    @isSelected = true

  actions:
    killTaxon: ->
      @taxon.destroyRecord().then -> Apiv1.Flash.register "success", "taxon destroyed", 2000

    interactWithTaxon: ->
      if @taxon.hasChildren
        @toggleExpansion()
      else
        @toggleSelection()