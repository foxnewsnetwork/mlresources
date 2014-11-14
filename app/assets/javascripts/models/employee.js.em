class Apiv1.Employee extends DS.Model
  personName: DS.attr "string"
  employeeTitle: DS.attr "string"
  email: DS.attr "string"
  phoneNumber: DS.attr "string"
  mugShot: DS.attr "string"

  +computed email, phoneNumber
  roughSummary: ->
    "email - #{@email} , phone - #{@phoneNumber}"

  +computed mugShot
  mugUrl: -> @get("mugShot") || "assets/table-booths/411.png"

  +computed email
  emailTo: -> "mailto:#{@email}"