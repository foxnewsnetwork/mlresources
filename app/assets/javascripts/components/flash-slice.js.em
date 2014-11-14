class Apiv1.FlashSliceComponent extends Ember.Component
  classNames: ['flash-slice']
  classNameBindings: ['isNotice:notice', 'isWarning:warning', 'isSuccess:success']

  +computed flash.severity
  isNotice: ->
    @get("flash.severity") is "notice"
  +computed flash.severity
  isWarning: ->
    @get("flash.severity") is "warning"
  +computed flash.severity
  isSuccess: ->
    @get("flash.severity") is "success"
    
  +computed flash.severity
  iconClass: ->
    return "fa-info-circle" if @get("flash.severity") is "notice"
    return "fa-exclamation-triangle" if @get("flash.severity") is "warning"
    return "fa-smile-o" if @get("flash.severity") is "success"
    "fa-flag"
  +computed flash.message
  message: ->
    @get "flash.message"

  didInsertElement: ->
    if @get("flash.type") is "ephemeral"
      destroy = _.bind @destroy, @
      _.delay destroy, @get('flash.expiration')
  actions:
    dismiss: ->
      @flash.dismiss()
      @destroy()