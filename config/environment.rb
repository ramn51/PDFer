# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

Rails.logger = Logger.new("log/#{Rails.env}.log", 1, 10 * 1024 * 1024)
# config.logger = ActiveSupport::Logger.new("log/#{Rails.env}.log")
Rails.logger.level = Logger::DEBUG
Rails.logger.datetime_format = "%Y-%m-%d %H:%M:%S"

# Rails.logger.formatter = proc do | severity, time, progname, msg |
#   "#{datetime}, #{severity}: #{msg} from #{progname} \n"
# end