class Apiv1.Taxon extends DS.Model
  permalink: DS.attr "string"
  rootGenus: DS.attr "string"
  taxonName: DS.attr "string"
  explanation: DS.attr "string"
  parentId: DS.attr "string"
  firstChildAt: DS.attr "date"
  createdAt: DS.attr "date"
  updatedAt: DS.attr "date"

  +computed id, Apiv1.PreloadedTaxons.@each
  children: -> 
    Apiv1.PreloadedTaxons.filter (taxon) =>
      taxon.get("parentId") is @id

  +computed parentId
  parent: -> @parentId && @store.find("taxon", @parentId)

  +computed children.@each, children.length
  hasChildren: -> 
    @get("children.length") > 0

  +computed taxonName, rootGenus, parent.fullName
  fullName: ->
    if Ember.isBlank @parent
      "+" + [@rootGenus, @taxonName].join ":"
    else
      [@parent.fullName, @taxonName].join ":"

  +computed fullName, id
  presentation: -> 
    ["+", @taxonName, ":", @id].join ""