class Apiv1.User extends DS.Model
  email: DS.attr "string"
  userRank: DS.attr "string"
  companyName: DS.attr "string"
  phoneNumber: DS.attr "string"
  address: DS.attr "string"
  aboutMe: DS.attr "string"
  password: DS.attr "string"
  passwordConfirmation: DS.attr "string"
  latitude: DS.attr "number"
  longitude: DS.attr "number"

  +computed userRank
  isAdmin: -> @userRank is "admin"

  +computed userRank, isAdmin
  rank: ->
    return "admin" if @isAdmin
    "regular user"

  +computed latitude, longitude
  coordinates: ->
    [@latitude, @longitude]