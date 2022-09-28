class ApplicationMailer < ActionMailer::Base
  default from: Rails.application.credentials.mailjet[:mailjet_sender]

  layout 'mailer'
end

