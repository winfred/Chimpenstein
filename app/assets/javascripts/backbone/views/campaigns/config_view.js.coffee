Chimpenstein.Views.Campaigns ||= {}

class Chimpenstein.Views.Campaigns.ConfigView extends Backbone.View
  template: JST["backbone/templates/campaigns/config"]

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
