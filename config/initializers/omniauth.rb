Rails.application.config.middleware.use OmniAuth::Builder do
  provider :mailchimp, '384373877895', '51918a815c64ee2bf209c2fb717262b8'
end
