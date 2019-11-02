require 'dotenv/load'
require_relative 'chitanda-san/syoboi_calendar/client'
require_relative 'chitanda-san/syoboi_calendar/parser'
require_relative 'chitanda-san/notifier/slack'

module ChitandaSan
  def self.run
    client = ChitandaSan::SyoboiCalendar::Client.new
    response = client.get
    items = ChitandaSan::SyoboiCalendar::Parser.parse(response.body)

    programs = items.select{|item|
      (item[:Cat] == 1 || item[:Cat] == 8) && item[:ChGID] == 1
    }.map{|item|
      start_date = Time.at(item[:StTimeU].to_i).strftime('%m/%d(%a) %H:%M')
      end_date = Time.at(item[:EdTimeU].to_i).strftime('%m/%d(%a) %H:%M')
      "#{item[:CatName]} #{start_date} - #{end_date} #{item[:ChName]} / *#{item[:Title]} #{item[:Count]}話*"
    }
    message = "*わたし、今日のテレビアニメが気になります！*\n" + programs.join("\n")

    notifier = ChitandaSan::Notifier::Slack.new
    notifier.post(message)
  end
end

ChitandaSan.run
