require 'active_support/time'
require_relative 'chitanda-san/syoboi_calendar/client'
require_relative 'chitanda-san/syoboi_calendar/connection'
require_relative 'chitanda-san/syoboi_calendar/models/rss2'
require_relative 'chitanda-san/syoboi_calendar/repositories/rss2'
require_relative 'chitanda-san/notifier/slack'
require_relative 'chitanda-san/message'

module ChitandaSan
  def self.run
    start_date = Time.now.change({hour: 19}).strftime('%Y%m%d%H%M')
    end_date = Time.now.tomorrow.change({hour: 3}).strftime('%Y%m%d%H%M')

    repository = ChitandaSan::SyoboiCalendar::Repositories::Rss2.new
    message = ChitandaSan::Message.create repository.get_items(start_date: start_date, end_date: end_date, days: 1)

    notifier = ChitandaSan::Notifier::Slack.new
    notifier.post message
  end
end