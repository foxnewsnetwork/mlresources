class Apiv1.Session
  _instance = null
  @instance = ->
    _instance ||= new Apiv1.Session()