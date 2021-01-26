class PdferMailer < ApplicationMailer
  default from: "ramnarayanan51@gmail.com"
  layout 'mailer'

  def sample_email(user)
    @user = user
    attachments['production.log'] = File.read(Rails.root.join('log', 'development.log'))
    mail(to: @user, subject: 'Sample Email')
  end
end
