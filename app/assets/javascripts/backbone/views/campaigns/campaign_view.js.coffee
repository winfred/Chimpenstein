Chimpenstein.Views.Campaigns ||= {}

class Chimpenstein.Views.Campaigns.CampaignView extends Backbone.View
  template: JST["backbone/templates/campaigns/campaign"]

  events:
    "click .pickA" : "pickA"
    "click .pickB" : "pickB"
    "click .popup-preview": "showPreview"

  tagName: "tr"
  
  attributes:
    class: 'popper'
    'data-content': "Clicking on the name of the campaign will open up a handy popup preview."
    'data-original-title': "Popup Preview"
    'data-placement': 'top'

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
    
  showPreview: (e)->
    w = window.open("","previewWindow","menubar=0,toolbar=0,location=0,width=800,height=600")
    w.document.open()
    @model.getPreview (html) ->
      w.document.write(html)
      w.document.close()



  render: ->
    $(@el).html(@template(@model.toJSON() ))
    $(@el).popover()
    return this
