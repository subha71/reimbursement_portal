OmniAuth.config.allowed_request_methods = [:post, :get]
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, 
    AppConfig.google['client_id'],
    AppConfig.google['client_secret'],
    {
      scope: 'email,profile',
      prompt: 'select_account',
      image_aspect_ratio: 'square',
      image_size: 50,
      access_type: 'offline'
    }
end