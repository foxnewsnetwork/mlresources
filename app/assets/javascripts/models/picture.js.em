class Apiv1.Picture extends DS.Model
  createdAt: DS.attr "date"
  updatedAt: DS.attr "date"
  picUrl: DS.attr "string"
  thumbUrl: DS.attr "string"
  picFileName: DS.attr "string"
  picContentType: DS.attr "string"
  picFileSize: DS.attr "string"
  picUpdatedAt: DS.attr "date"

  product: DS.belongsTo "product"