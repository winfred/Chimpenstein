class MailchimpProxyController < ApplicationController

  def api
    data = JSON.parse request.body.read
    render json: current_user.api.send(data['method'],data['params'])
  end

end