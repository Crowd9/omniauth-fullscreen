Rails.application.config.middleware.use OmniAuth::Builder do
  provider :fullscreen, ENV['FULLSCREEN_KEY'], ENV['FULLSCREEN_SECRET']
end
