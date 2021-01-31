class ApplicationMailer < ActionMailer::Base
  default from: PDFER_CONSTANTS['developer_email']
  layout 'mailer'
end
