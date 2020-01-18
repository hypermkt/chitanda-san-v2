require_relative 'chitanda-san/syoboi_calendar/client'
require_relative 'chitanda-san/syoboi_calendar/connection'
require_relative 'chitanda-san/syoboi_calendar/models/rss2'
require_relative 'chitanda-san/syoboi_calendar/repositories/rss2'
require_relative 'chitanda-san/notifier/slack'
require_relative 'chitanda-san/message'

module ChitandaSan
  def self.run
    repository = ChitandaSan::SyoboiCalendar::Repositories::Rss2.new
    message = ChitandaSan::Message.create repository.get_items

    notifier = ChitandaSan::Notifier::Slack.new
    notifier.post message
  end
end