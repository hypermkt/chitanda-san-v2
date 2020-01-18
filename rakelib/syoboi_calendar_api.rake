require './lib/chitanda-san/syoboi_calendar/client'
require './lib/chitanda-san/syoboi_calendar/parser'
require './lib/chitanda-san/message'

desc "syoboi calendar api call test"
task :syoboi_calendar_api do
  client = ChitandaSan::SyoboiCalendar::Client.new
  response = client.get
  items = ChitandaSan::SyoboiCalendar::Parser.parse(response.body)

  puts ChitandaSan::Message.create items
end
