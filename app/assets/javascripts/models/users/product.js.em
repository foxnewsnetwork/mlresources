class Apiv1.UsersProduct extends DS.Model
  sku: DS.attr "string"
  material: DS.attr "string"
  price: DS.attr "string"
  amount: DS.attr "string"
  quality: DS.attr "string"
  place: DS.attr "string"
  others: DS.attr "string"
  
  taxons: DS.attr "strings"
  attachments: DS.attr "files"
  pictures: DS.attr "files"