class Apiv1.Offer extends DS.Model
  priceTerms: DS.attr "string"
  fromCompany: DS.attr "string"
  phoneNumber: DS.attr "string"
  contactPerson: DS.attr "string"
  companyAddress: DS.attr "string"
  senderEmail: DS.attr "string"
  message: DS.attr "string"
  status: DS.attr "string"
  createdAt: DS.attr "date"
  updatedAt: DS.attr "date"
  deletedAt: DS.attr "date"
  product: DS.belongsTo "product", async: true