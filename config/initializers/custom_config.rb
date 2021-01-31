require 'rails/tasks'
# Load the app constants.
PDFER_CONSTANTS = YAML.load_file("#{Rails.root}/config/pdfer_constants.yml")[Rails.env]
# remove log file on server start/restart for dev and test
Rake::Task['log:clear'].invoke if Rails.env.development? || Rails.env.test?
