Rails.application.config.middleware.use OmniAuth::Builder do
  provider :mailchimp, 
  (ENV['MAILCHIMP_CLIENT_KEY'] || '384373877895'), 
  (ENV['MAILCHIMP_CLIENT_SECRET'] ||'51918a815c64ee2bf209c2fb717262b8')
end
