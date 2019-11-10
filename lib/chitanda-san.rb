require 'dotenv/load'
require_relative 'chitanda-san/syoboi_calendar/client'
require_relative 'chitanda-san/syoboi_calendar/parser'
require_relative 'chitanda-san/notifier/slack'
require_relative 'chitanda-san/message'

module ChitandaSan
  def self.run
    client = ChitandaSan::SyoboiCalendar::Client.new
    response = client.get
    items = ChitandaSan::SyoboiCalendar::Parser.parse(response.body)
    message = ChitandaSan::Message.create items
    notifier = ChitandaSan::Notifier::Slack.new
    notifier.post message
  end
end

ChitandaSan.run
