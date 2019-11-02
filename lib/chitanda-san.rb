require 'active_support/time'
require 'faraday'
require 'rss'
require 'slack-notifier'
require 'dotenv/load'

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
START_DATE = Time.current.strftime('%Y%m%d1300')
END_DATE = Time.current.tomorrow.strftime('%Y%m%d0300')

params = {
    start: START_DATE,
    end: END_DATE,
    days: DAYS,
    titlefmt: TITLE_FORMAT,
}
response = Faraday.get(ENDPOINT, params)
rss = RSS::Parser.parse(response.body, false, true)
categories = {1 => '[TV]', 8 => '[映]'}
programs = rss.items.map{|item|
  splitted = item.title.split('##')
  {
      Cat: splitted[0].to_i,
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

# カテゴリー: アニメ・映画, 地域: 東京
}.select{|item|
  (item[:Cat] == 1 || item[:Cat] == 8) && item[:ChGID] == 1
}.map{|item|
  start_date = Time.at(item[:StTimeU].to_i).strftime('%m/%d(%a) %H:%M')
  end_date = Time.at(item[:EdTimeU].to_i).strftime('%m/%d(%a) %H:%M')
  category = categories[item[:Cat].to_i]
  "#{category} #{start_date} - #{end_date} #{item[:ChName]} / *#{item[:Title]} #{item[:Count]}話*"
}
message = "*わたし、今日のテレビアニメが気になります！*\n" + programs.join("\n")

notifier = Slack::Notifier.new ENV['SLACK_INCOMING_WEBHOOK_URL'], channel: ENV['SLACK_CHANNEL']
notifier.post text: message, icon_emoji: ENV['SLACK_ICON_EMOJI'], username: ENV['SLACK_USERNAME']
