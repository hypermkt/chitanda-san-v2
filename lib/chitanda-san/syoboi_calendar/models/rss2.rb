module ChitandaSan
  module SyoboiCalendar
    module Models
      class Rss2
        attr_reader :category_id, :category_name, :flag, :channel_group_id, :channel_name, :title, :count, :subtitle, :start_timestamp, :end_timestamp

        CATEGORIES = {1 => '[TV]', 8 => '[映]'}

        def initialize(item)
          @category_id = item[0].to_i
          @category_name = CATEGORIES[item[0].to_i]
          @flag = item[1].to_i
          @channel_group_id = item[2].to_i
          @channel_id = item[3].to_i
          @channel_name = item[4]
          @title = item[5]
          @count = item[6].to_i
          @subtitle = item[7]
          @start_timestamp = item[8].to_i
          @end_timestamp = item[9].to_i
        end
      end
    end
  end
end
