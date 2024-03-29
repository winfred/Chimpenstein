class Chimpenstein.Models.Campaign extends Backbone.Model
  paramRoot: 'campaign'

  defaults:
    title: null
    type: null
  
  create: (cb)->
    Mailchimp.API.call 'campaignCreate', @toJSON(), (data)->
      cb(data)
    , (res,error) ->
      #because MC returns a non-JSON string for the id
      cb(res.responseText)
  
  getPreview: (cb)->
    Mailchimp.API.call 'campaignContent', {cid: @get('id'), for_archive: false}, (preview) ->
      cb(preview.html)

class Chimpenstein.Collections.CampaignsCollection extends Backbone.Collection
  model: Chimpenstein.Models.Campaign
  url: '/campaigns'
