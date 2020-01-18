require './lib/chitanda-san/syoboi_calendar/client'
require './lib/chitanda-san/syoboi_calendar/models/rss2'
require './lib/chitanda-san/syoboi_calendar/repositories/rss2'
require './lib/chitanda-san/syoboi_calendar/parser'
require './lib/chitanda-san/message'

desc "syoboi calendar api call test"
task :syoboi_calendar_api do
  repository = ChitandaSan::SyoboiCalendar::Repositories::Rss2.new
  puts ChitandaSan::Message.create repository.get_items
end

task :client do
  repository = ChitandaSan::SyoboiCalendar::Repositories::Rss2.new
  repository.get_items.each do |item|
    puts item.title
  end
end
