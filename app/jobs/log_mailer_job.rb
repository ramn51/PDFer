class LogMailerJob < ApplicationJob
  queue_as :default

  def perform(user = PDFER_CONSTANTS['developer_email'], time, error)
    # Send mail of log file
    PdferMailer.logger_email(user, time, error).deliver_now
    logger.info "Logger mail has been sent to #{user}"
  rescue *SMTP_SERVER_ERRORS => error
    logger.error "Error occured in sending mail #{error}"

  end
end
