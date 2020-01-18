module ChitandaSan
  module SyoboiCalendar
    module Repositories
      class Rss2
        def get_items
          response = client.rss2
          body = response.body['rss']['channel']['item'].map do |item|
            splitted_item = item['title'].split('##')
            ChitandaSan::SyoboiCalendar::Models::Rss2.new(splitted_item)
          end

          body
        end

        private

        def client
          @client ||= ChitandaSan::SyoboiCalendar::Client.new
        end
      end
    end
  end
end
