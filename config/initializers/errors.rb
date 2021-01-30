SMTP_SERVER_ERRORS = [
    IOError,
    Net::SMTPAuthenticationError,
    Net::SMTPServerBusy,
    Net::SMTPUnknownError,
    TimeoutError,
]

SMTP_CLIENT_ERRORS = [Net::SMTPFatalError, Net::SMTPSyntaxError].freeze

SMTP_ERRORS = SMTP_SERVER_ERRORS.concat(SMTP_CLIENT_ERRORS)

SMTP_CLIENT_ERROR_FLASH = 'The email address supplied is invalid. Please
  check for spelling mistakes.'.freeze
SMTP_SERVER_ERROR_FLASH = 'We encountered an internal issue while attempting
  to deliver this email. Please try again in a few minutes.'.freeze