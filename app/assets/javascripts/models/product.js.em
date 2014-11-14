class Apiv1.Product extends DS.Model
  sku: DS.attr "string"
  material: DS.attr "string"
  price: DS.attr "string"
  amount: DS.attr "string"
  place: DS.attr "string"
  quality: DS.attr "string"
  others: DS.attr "string"
  showcaseOrder: DS.attr "number"
  createdAt: DS.attr "date"
  updatedAt: DS.attr "date"
  attachments: DS.hasMany "attachment", async: true
  pictures: DS.hasMany "picture", async: true
  taxons: DS.hasMany "taxon", async: true

  +computed material, price, amount, place, sku
  roughSummary: ->
    "#{@price || 'no price'} #{@material || 'unknown material'} #{@amount || 'unknown quantity'} @ #{@place || 'unknown place'} - #{@sku || 'no sku'}"


  +computed id, sku, material, price, amount, place, quality, others, showcaseOrder, taxonIds
  coreAttributes: ->
    id: @get("id")
    sku: @get("sku")
    material: @get("material")
    price: @get("price")
    amount: @get("amount")
    place: @get("place")
    quality: @get("quality")
    others: @get("others")
    showcaseOrder: @get("showcaseOrder")

  +computed showcaseOrder
  hasShowOrder: -> not Ember.isBlank @showcaseOrder
