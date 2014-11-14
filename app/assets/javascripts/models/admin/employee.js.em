class Apiv1.AdminEmployee extends DS.Model
  personName: DS.attr "string"
  employeeTitle: DS.attr "string"
  email: DS.attr "string"
  phoneNumber: DS.attr "string"
  pictures: DS.attr "files"