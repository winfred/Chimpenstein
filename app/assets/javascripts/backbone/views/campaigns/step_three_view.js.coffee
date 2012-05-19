Chimpenstein.Views.Campaigns ||= {}

class Chimpenstein.Views.Campaigns.StepThreeView extends Backbone.View
  template: JST["backbone/templates/campaigns/step_three"]
  
  initialize: ->
    @options.config.on 'status:updated', @updateStatus, this
    @options.config.on 'create:finished', @showResult, this
    
  updateStatus: (message, percentage)->
    @$('.status .message').text message
    @$('.status .bar').attr('style', "width: #{percentage}%;")
      
  showResult: ->
    @$('.status .progress').removeClass 'active'
    @$('a.web_url').attr('href',@options.config.get('web_url'))
    @$('.finished').show()
    
  render: ->
    $(@el).html(@template(@options.config.toJSON() ))
    return this
