require 'rufus/scheduler'
scheduler = Rufus::Scheduler.new

# every day 5 minutes after midnight clear the log
if Rails.env.production?
  scheduler.cron '5 0 * * *' do
    require 'rails/rake'
    Rake::Task['log:clear'].invoke
  end
end
