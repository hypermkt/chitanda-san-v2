require 'rspec'
require_relative '../../../../lib/chitanda-san/syoboi_calendar/client'

RSpec.describe 'ChitandaSan::SyoboiCalendar::Client' do
  describe '#get' do
    context '正常系' do
      let!(:client) { ChitandaSan::SyoboiCalendar::Client.new }
      let!(:rss) do
        rss = <<"EOS"
<?xml version="1.0" encoding="UTF-8"?>
<rss version="2.0" xmlns:dc="http://purl.org/dc/elements/1.1/">
<channel>
  <title>しょぼいカレンダー</title>
  <description>しょぼいカレンダー</description>
  <link>http://cal.syoboi.jp/</link>
  <dc:language>ja</dc:language>
  <pubDate>Tue, 05 Nov 2019 23:02:57 +0900</pubDate>
  <item>
    <title>item title</title>
    <link>http://cal.syoboi.jp/tid/...</link>
    <description></description>
    <pubDate>2019-11-06T23:00:00+09:00</pubDate>
  </item>
</channel>
</rss>
EOS
      end
      let!(:stub_client) do
        Faraday.new do |conn|
          conn.adapter :test, Faraday::Adapter::Test::Stubs.new do |stub|
            stub.get('http://cal.syoboi.jp/rss2.php') do
              [ 200, {}, rss ]
            end
          end
        end
      end

      before do
        allow(client).to receive(:client).and_return(stub_client)
        @response = client.get
      end

      it { expect(@response.status).to eq 200 }
      it { expect(@response.status).to eq 200 }
    end
  end
end