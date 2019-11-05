require 'faraday'
require 'active_support/time'

module ChitandaSan
  module SyoboiCalendar
    class Client
      ENDPOINT = 'http://cal.syoboi.jp/rss2.php'.freeze
      DAYS = 1.freeze

      # Cat: カテゴリ値
      # Flag: フラグ値
      # ChGID: チャンネルグループID
      # ChID: チャンネルID
      # ChName: チャンネル名
      # Title: 完全なタイトル
      # Count: 回数 = 話数
      # SubTitleA: サブタイトル
      # StTimeU: 開始時間 (Unix Epoch)
      # EdTimeU: 終了時間 (Unix Epoch)
      TITLE_FORMAT = "$(Cat)##$(Flag)##$(ChGID)##$(ChID)##$(ChName)##$(Title)##$(Count)##$(SubTitleA)##$(StTimeU)##$(EdTimeU)".freeze

      def client
        Faraday.new
      end

      def get
        start_date = Time.current.strftime('%Y%m%d1300')
        end_date = Time.current.tomorrow.strftime('%Y%m%d0300')

        params = {
            start: start_date,
            end: end_date,
            days: DAYS,
            titlefmt: TITLE_FORMAT,
        }

        client.get(ENDPOINT, params)
      end
    end
  end
end
