class Chimpenstein.Models.Config extends Backbone.Model
  paramRoot: 'config'
  
  defaults:
    pickA: new Chimpenstein.Models.Campaign(title: "Nothing Selected")
    pickB: new Chimpenstein.Models.Campaign(title: "Nothing Selected")
  
  isReadyToCreate: ->
    if @get('pickA').get('title') isnt "Nothing Selected" and @get('pickB').get('title') isnt "Nothing Selected"
      true
    else 
      false

