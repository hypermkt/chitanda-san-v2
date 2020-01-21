module ChitandaSan
  module SyoboiCalendar
    module Endpoints
      module Rss2
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

        def rss2
          start_date = Time.current.strftime('%Y%m%d1900')
          end_date = Time.current.tomorrow.strftime('%Y%m%d0300')
          params = {
            start: start_date,
            end: end_date,
            days: DAYS,
            titlefmt: TITLE_FORMAT,
          }

          get('/rss2.php', params)
        end
      end
    end
  end
end
