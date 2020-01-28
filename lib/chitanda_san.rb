require 'active_support/time'
require_relative 'chitanda-san/syoboi_calendar/client'
require_relative 'chitanda-san/syoboi_calendar/connection'
require_relative 'chitanda-san/syoboi_calendar/programs'
require_relative 'chitanda-san/syoboi_calendar/models/rss2'
require_relative 'chitanda-san/syoboi_calendar/repositories/rss2'
require_relative 'chitanda-san/notifier/slack'

module ChitandaSan
  def self.run
    start_date = Time.now.change({hour: 19}).strftime('%Y%m%d%H%M')
    end_date = Time.now.tomorrow.change({hour: 3}).strftime('%Y%m%d%H%M')

    repository = ChitandaSan::SyoboiCalendar::Repositories::Rss2.new

    all_programs = repository.get_items(start_date: start_date, end_date: end_date, days: 1)
    programs = ChitandaSan::SyoboiCalendar::Programs.new(all_programs)
    ChitandaSan::Notifier::Slack.new.post(programs.filter.to_message)
  end
end