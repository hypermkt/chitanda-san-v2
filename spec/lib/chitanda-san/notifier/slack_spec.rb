require 'rspec'
require_relative '../../../../lib/chitanda-san/notifier/slack'

RSpec.describe 'ChitandaSan::Notifier::Slack' do
  describe '#post' do
    let!(:mock) do
      mock = double('slack_notifier')
      allow(mock).to receive(:post)
      mock
    end
    let!(:client) do
      client = ChitandaSan::Notifier::Slack.new
      allow(client).to receive(:client).and_return(mock)
      client
    end

    before { @res = client.post text: 'hoge', icon_emoji: 'hoge', username: 'hoge' }

    it { expect(@res).to be_nil }
  end
end