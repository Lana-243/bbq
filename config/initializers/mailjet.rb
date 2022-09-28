Mailjet.configure do |config|
  config.api_key = Rails.application.credentials.mailjet[:mailjet_api_key]
  config.secret_key = Rails.application.credentials.mailjet[:mailjet_secret_key]
  config.api_version = 'v3.1'
end
