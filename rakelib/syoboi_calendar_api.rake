require 'active_support/time'
require './lib/chitanda-san/syoboi_calendar/client'
require './lib/chitanda-san/syoboi_calendar/models/rss2'
require './lib/chitanda-san/syoboi_calendar/repositories/rss2'
require './lib/chitanda-san/syoboi_calendar/programs'

desc "syoboi calendar api call test"
task :syoboi_calendar_api do
  start_date = Time.now.change({hour: 19}).strftime('%Y%m%d%H%M')
  end_date = Time.now.tomorrow.change({hour: 3}).strftime('%Y%m%d%H%M')
  repository = ChitandaSan::SyoboiCalendar::Repositories::Rss2.new
  all_programs = repository.get_items(start_date: start_date, end_date: end_date, days: 1)
  programs = ChitandaSan::SyoboiCalendar::Programs.new(all_programs)
  puts programs.filter.to_message
end

task :client do
  start_date = Time.now.change({hour: 19}).strftime('%Y%m%d%H%M')
  end_date = Time.now.tomorrow.change({hour: 3}).strftime('%Y%m%d%H%M')
  repository = ChitandaSan::SyoboiCalendar::Repositories::Rss2.new
  repository.get_items(start_date: start_date, end_date: end_date, days: 1).each do |item|
    puts item.title
  end
end
