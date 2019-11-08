require 'slack-notifier'
require 'dotenv/load'

module ChitandaSan
  module Notifier
    class Slack
      def client
        ::Slack::Notifier.new ENV['SLACK_INCOMING_WEBHOOK_URL'], channel: ENV['SLACK_CHANNEL']
      end

      def post(message)
        client.post text: message, icon_emoji: ENV['SLACK_ICON_EMOJI'], username: ENV['SLACK_USERNAME']
      end
    end
  end
end


