class User < ActiveRecord::Base
  attr_accessible :apikey, :email, :name, :uid
  attr_accessible :uid, :name, :email, :apikey

  def api
    @api ||= Mailchimp::API.new(apikey)
  end
  
  def self.create_with_omniauth(auth)
    create! do |user|
      user.apikey = "#{auth['credentials']['token']}-#{auth['extra']['metadata']['dc']}"
      user.uid = auth['uid']
      if auth['info']
         user.name = "#{auth['info']['first_name']} #{auth['info']['last_name']}" || ""
         user.email = auth['info']['email'] || ""
      end
    end
  end
  
end

