Chimpenstein.Views.Campaigns ||= {}

class Chimpenstein.Views.Campaigns.StepOneView extends Backbone.View
  template: JST["backbone/templates/campaigns/step_one"]

  render: ->
    $(@el).html(@template())
    return this
