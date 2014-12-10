class Apiv1.Contact extends DS.Model
  name: DS.attr "string"
  phone: DS.attr "string"
  email: DS.attr "string"
  address: DS.attr "string"
  madePrimaryAt: DS.attr "string"
  deletedAt: DS.attr "date"
  createdAt: DS.attr "date"
  updatedAt: DS.attr "date"

  user: DS.belongsTo "user", async: true