class Apiv1.Listing extends DS.Model
  permalink: DS.attr "string"
  materialName: DS.attr "string"
  priceUnit: DS.attr "string"
  askingPrice: DS.attr "number"
  quantity: DS.attr "number"
  quantityUnit: DS.attr "string"
  incoterm: DS.attr "string"
  locationName: DS.attr "string"
  otherNotes: DS.attr "string"
  timeInterval: DS.attr "string"
  createdAt: DS.attr "date"
  updatedAt: DS.attr "date"

  pictures: DS.hasMany "picture", async: true
  taxons: DS.hasMany "taxon", async: true

  +computed priceUnit, askingPrice, locationName, createdAt
  roughSummary: ->
    "#{@askingPrice} #{@priceUnit} @ #{@locationName} on #{@createdAt}"