Chimpenstein.Views.Campaigns ||= {}

class Chimpenstein.Views.Campaigns.CampaignView extends Backbone.View
  template: JST["backbone/templates/campaigns/campaign"]

  events:
    "click .pickA" : "pickA"
    "click .pickB" : "pickB"

  tagName: "tr"

  pickA: (e) ->
    @toggleSelected(e.currentTarget, 'A')
    @options.config.set pickA: @model
    return false
    
  pickB: (e) ->
    @toggleSelected(e.currentTarget, 'B')
    @options.config.set pickB: @model
    return false
  
  toggleSelected: (elem, split)->
    $("a.pick#{split}.disabled").removeClass('disabled')
    @$("a.pick#{split}").addClass('disabled')


  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
