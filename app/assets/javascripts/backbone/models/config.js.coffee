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
  
  createCampaign: ->
    config = this
    config.updateStatus "Fetching campaigns", 10
    @fetchCampaigns ->
      config.updateStatus "Merging campaigns", 40
      config.createSplit (result)->
        config.updateStatus "Finished", 100
        config.set 'web_url', result
        config.trigger 'create:finished'
        
    
  
  fetchCampaigns: (cb)->
    done = 2
    $([@get('pickA'),@get('pickB')]).each ->
      campaign = this
      Mailchimp.API.call 'campaignContent', {cid: campaign.id, for_archive: false}, (content)->
        campaign.set 'content', content
        done--
        if done is 0 then cb()
      
      
  
  createSplit: (cb)->
    config = this
    @split = new Chimpenstein.Models.Campaign
      type: 'absplit'
      options:
        list_id: @get('pickA').get('list_id')
        title: "A-B Split Combination :: It's ALIVE!!"
        subject: @get('pickA').get('subject')
        from_email: @get('pickA').get('from_email')
        from_name: @get('pickA').get('from_name')
        to_name: @get('pickA').get('to_name')
      content:
        html: @generateHTMLContent()
        text: @generateTextContent()
      type_opts:
        split_test: 'subject'
        pick_winner: 'opens'
        subject_a: @get('pickA').get('subject')
        subject_b: @get('pickB').get('subject')
    @split.create (id)->
      config.updateStatus 'Cleaning up', 80
      Mailchimp.API.call 'campaigns', {filters: {campaign_id: id}}, (res) ->
        web_id = res.data[0].web_id
        cb("https://#{Chimpenstein.dc}.admin.mailchimp.com/campaigns/wizard/absplit?id=#{web_id}")
        
  
  generateHTMLContent: ->
    pickA = $(@get('pickA').get('content').html
              .replace(/<body/, "<div class='body'")
              .replace(/html/, "div class='html'")
              .replace(/head/, "div class='head'")
              .replace(/\/body/, "\/div")
              .replace(/\/head/, "\/div")
              .replace(/\/html/, "\/div"))
    pickB = $(@get('pickB').get('content').html
              .replace(/<body/, "<div class='body'")
              .replace(/html/, "div class='html'")
              .replace(/head/, "div class='head'")
              .replace(/\/body/, "\/div")
              .replace(/\/head/, "\/div")
              .replace(/\/html/, "\/div"))
              
    Chimpenstein.pickA = pickA
    Chimpenstein.pickB = pickB

    """
    <html> 
    <head>
      *|GROUP:A|*
      #{pickA.find('.head').html()}
      *|END:GROUP|*
    
      *|GROUP:B|*
      #{pickB.find('.head').html()}
      *|END:GROUP|*
    </head>
    
    *|GROUP:A|*
      <body style="#{pickA.find('.body').attr('style')}">
      #{pickA.find('.body').html()}
      </body>
    *|END:GROUP|*
    
    *|GROUP:B|*
      <body style="#{pickB.find('.body').attr('style')}">
      #{pickB.find('.body').html()}
      </body>
    *|END:GROUP|*
    
    </html>
    """
  generateTextContent: ->
    """
    *|GROUP:A|*
    #{@get('pickA').get('content').text}
    *|END:GROUP|*
    *|GROUP:B|*
    #{@get('pickB').get('content').text}
    *|END:GROUP|*
    """
    
  
  updateStatus: (message,percentage)->
    @trigger 'status:updated', message, percentage
