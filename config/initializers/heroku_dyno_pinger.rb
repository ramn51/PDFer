require 'rufus/scheduler'
scheduler = Rufus::Scheduler.new

if Rails.env.production?
  scheduler.every '40m' do
    require 'net/http'
    require 'uri'
    Net::HTTP.get_response(URI.parse(ENV['HOSTNAME']))
  end
end

# For any changes with scheduler interval set it with either a ENV variable or directly.
# heroku config:add HOSTNAME=url.of.the.app ensure to run this.
