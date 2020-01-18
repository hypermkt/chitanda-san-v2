module ChitandaSan
  class Message
    def self.create(items)
      programs = items.select{|item|
        (item.category_id == 1 || item.category_id == 8) && item.channel_group_id == 1
      }.map{|item|
        start_date = Time.at(item.start_timestamp.to_i).strftime('%m/%d(%a) %H:%M')
        end_date = Time.at(item.end_timestamp.to_i).strftime('%m/%d(%a) %H:%M')
        episode = if item.category_id == 1 then " #{item.count}話" else "" end
        "#{item.category_name} #{start_date} - #{end_date} #{item.channel_name} / *#{item.title}#{episode}*"
      }
      "*わたし、今日のテレビアニメが気になります！*\n" + programs.join("\n")
    end
  end
end
