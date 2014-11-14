class Apiv1.FormForComponent extends Ember.Component
  classNames: ['form-for']
  formData: ->
    @$("form").serializeArray()

  processNewData: ->
    _.partial _.foldl, @formData(), (memo, next) ->
      memo.set next.name, next.value
      memo
  updatedModel: ->
    @processNewData()(@model || new Ember.Object())
  
  +observer errors
  displayErrors: ->
    @resetErrorFields()
    @explainErrorFields()

  resetErrorFields: ->
    @$(".input-section").removeClass "error"
    @$("small.error").remove()

  explainErrorFields: ->
    _.map @errors, (errors, field) =>
      @$(".input-section[attr-name=#{field}]").addClass("error").append("<small class='error'>#{errors}</small>")
      

  actions:
    submit: ->
      @sendAction "submit", @updatedModel()