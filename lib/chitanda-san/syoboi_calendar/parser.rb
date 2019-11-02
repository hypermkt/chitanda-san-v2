require 'rss'

module ChitandaSan
  module SyoboiCalendar
    class Parser
      def self.parse(body)
        rss = RSS::Parser.parse(body, false, true)

        categories = {1 => '[TV]', 8 => '[映]'}
        programs = rss.items.map{|item|
          splitted = item.title.split('##')
          {
              Cat: splitted[0].to_i,
              CatName: categories[splitted[0].to_i],
              Flag: splitted[1].to_i,
              ChGID: splitted[2].to_i,
              ChID: splitted[3].to_i,
              ChName: splitted[4],
              Title: splitted[5],
              Count: splitted[6].to_i,
              SubTitleA: splitted[7],
              StTimeU: splitted[8].to_i,
              EdTimeU: splitted[9].to_i,
          }
        }

        programs
      end
    end
  end
end
