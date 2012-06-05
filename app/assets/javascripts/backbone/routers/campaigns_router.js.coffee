class Chimpenstein.Routers.CampaignsRouter extends Backbone.Router
  initialize: (options) ->


  routes:
    "step_one" : "stepOne"
    "step_two" : "stepTwo"
    "step_three": "stepThree"
    ".*"        : "stepTwo"
    
  stepOne: ->
    @view = new Chimpenstein.Views.Campaigns.StepOneView()
    $("#campaigns").html(@view.render().el)
    
  stepTwo: ->
    campaigns = @campaigns = new Chimpenstein.Collections.CampaignsCollection()
    Chimpenstein.config = @config = new Chimpenstein.Models.Config()
    Mailchimp.API.call 'campaigns', {filters: {status: "save,paused", type: 'regular'},limit: 100}, (data) ->
      campaigns.reset data.data
      $('#spin').data('spinner').spin()
    @view = new Chimpenstein.Views.Campaigns.StepTwoView(campaigns: @campaigns, config: @config)
    $('#campaigns').html(@view.render().el)
    
  stepThree: ->
    #TODO: enforce @config has pickA and pickB
    @view = new Chimpenstein.Views.Campaigns.StepThreeView(config: @config)
    $('#campaigns').html(@view.render().el)
    @config.createCampaign()