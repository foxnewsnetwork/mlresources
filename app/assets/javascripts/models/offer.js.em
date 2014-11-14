class Apiv1.Offer extends DS.Model
  price: DS.attr "number"
  priceUnit: DS.attr "string"
  incoterm: DS.attr "string"
  locationName: DS.attr "string"
  buyerCompany: DS.attr "string"
  buyerEmail: DS.attr "string"
  message: DS.attr "string"
  createdAt: DS.attr "date"
  updatedAt: DS.attr "date"

  listing: DS.belongsTo "listing"