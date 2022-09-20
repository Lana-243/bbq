class ApplicationMailer < ActionMailer::Base
  default from: Rails.application.credentials.mail[:mail_sender]

  layout 'mailer'
end

