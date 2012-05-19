Chimpenstein.Views.Campaigns ||= {}

class Chimpenstein.Views.Campaigns.StepTwoView extends Backbone.View
  template: JST["backbone/templates/campaigns/step_two"]
  
  initialize: () ->
    console.log @options
    @options.campaigns.on('reset', @addAll)
    @options.config.on('change', @showConfig, this)

  addAll: () =>
    @options.campaigns.each(@addOne)

  addOne: (campaign) =>
    view = new Chimpenstein.Views.Campaigns.CampaignView({model : campaign, config: @options.config})
    @$("tbody").append(view.render().el)
    
  showConfig: ->
    view = new Chimpenstein.Views.Campaigns.ConfigView({model: @options.config})
    @$(".config").html(view.render().el)
    if @options.config.isReadyToCreate()
      @$('.createCampaign').show()
    

  render: ->
    $(@el).html(@template(campaigns: @options.campaigns.toJSON()))
    @addAll()
    @showConfig()
    
    return this
