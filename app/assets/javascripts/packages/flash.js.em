class Apiv1.Flash extends Ember.Object
  flashStack: []
  +computed flashStack.@each
  stack: -> @flashStack
  dismiss: (message) ->
    @flashStack.removeObject message

  register: (severity, message, expiration) ->
    if arguments.length > 2
      m = Apiv1.Flash.ExpiringMessage.create
        severity: severity
        message: message
        expiration: expiration
    else
      m = Apiv1.Flash.Message.create
        severity: severity
        message: message
    @flashStack.pushObject m
  
Apiv1.Flash.instance = Apiv1.Flash.create()
Apiv1.Flash.register = _.bind Apiv1.Flash.instance.register, Apiv1.Flash.instance

class Apiv1.Flash.Message extends Ember.Object
  type: "vanilla"
  severity: "info"
  dismiss: ->
    Apiv1.Flash.instance.dismiss @


class Apiv1.Flash.ExpiringMessage extends Apiv1.Flash.Message
  type: "ephemeral"
  severity: "info"
  expiration: 10000
  init: ->
    dismiss = _.bind @dismiss, @
    _.delay dismiss, @expiration
