module ChitandaSan
  module SyoboiCalendar
    class Programs
      attr_reader :programs

      def initialize(programs)
        @programs = programs
      end

      def filter
        @programs = programs.select{|program|
          (program.category_id == 1 || program.category_id == 8) &&
            ChitandaSan::SyoboiCalendar::Constants::CHANNELS.values.include?(program.channel_id)
        }
        self
      end

      def to_message
        message = programs.map{|program|
          start_date = Time.at(program.start_timestamp.to_i).strftime('%m/%d(%a) %H:%M')
          end_date = Time.at(program.end_timestamp.to_i).strftime('%m/%d(%a) %H:%M')
          episode = if program.category_id == 1 then " #{program.count}話" else "" end
          "#{program.category_name} #{start_date} - #{end_date} #{program.channel_name} / *#{program.title}#{episode}*"
        }
        "*わたし、今日のテレビアニメが気になります！*\n" + message.join("\n")
      end
    end
  end
end
