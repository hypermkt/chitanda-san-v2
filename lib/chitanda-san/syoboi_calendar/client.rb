require './lib/chitanda-san/syoboi_calendar/constants'
require './lib/chitanda-san/syoboi_calendar/connection'
require './lib/chitanda-san/syoboi_calendar/endpoints/rss2'

module ChitandaSan
  module SyoboiCalendar
    class Client
      include ChitandaSan::SyoboiCalendar::Constants
      include ChitandaSan::SyoboiCalendar::Connection
      include ChitandaSan::SyoboiCalendar::Endpoints::Rss2

      def initialize
        @base_url = ChitandaSan::SyoboiCalendar::Constants::BASE_URL
      end
    end
  end
end
