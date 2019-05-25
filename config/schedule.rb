# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
set :chronic_options, hours24: true

every :weekday, at: '2:00' do
  rake "attendance:populate"
  rake "attendance:generate_codes"
end

require "./config/environment.rb"
set :output, "#{path}/log/cron.log" #logs
@courses = Course.all
@courses.each do |course|
  start = course.start_time + 5.minutes
  schedule_start = start.hour.to_s + ":" + start.min.to_s
  every :weekday, at: schedule_start do
    rake "attendance:mark_absent[#{course.id}]"
  end
end
