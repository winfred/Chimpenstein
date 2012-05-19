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
      @$('.createCampaign').removeClass('invisible')
    

  render: ->
    $(@el).html(@template(campaigns: @options.campaigns.toJSON()))
    @addAll()
    @showConfig()
    @$('#spin').spin
      lines: 17
      length: 30
      width: 5
      radius: 40
      rotate: 85
      color: '#000'
      speed: 1
      trail: 84
      shadow: true
      hwaccel: false
      className: 'spinner'
      zIndex: 2e9
      top: 'auto'
      left: '50%'
    @$('.spinner').attr 'style', "position: relative; z-index: 2000000000; top: -120px; left: 50%;"
    
    return this
