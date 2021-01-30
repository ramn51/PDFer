class PdferMailer < ApplicationMailer
  default from: PDFER_CONSTANTS['developer_email']
  layout 'mailer'

  def logger_email(user = PDFER_CONSTANTS['developer_email'], incident_time, specific_error)
    @user = user
    @time_of_incident = incident_time
    @error = specific_error
    attachments['production.log'] = File.read(Rails.root.join('log', "#{Rails.env}.log"))
    mail(to: @user, subject: 'PDFer Error logger notification')
  end
end
