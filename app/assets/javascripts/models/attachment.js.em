class Apiv1.Attachment extends DS.Model
  createdAt: DS.attr "date"
  updatedAt: DS.attr "date"

  fileName: DS.attr "string"
  fileType: DS.attr "string"
  fileUrl: DS.attr "string"

  product: DS.belongsTo "product"