require 'rspec'
require_relative '../../../../lib/chitanda-san/syoboi_calendar/parser'

RSpec.describe 'ChitandaSan::SyoboiCalendar::Parser' do
  describe '#get' do
    context '正常系' do
      let!(:rss) do
        rss = <<"EOS"
<rss xmlns:dc="http://purl.org/dc/elements/1.1/" version="2.0">
<channel>
<title>しょぼいカレンダー</title>
<description>しょぼいカレンダー</description>
<link>http://cal.syoboi.jp/</link>
<dc:language>ja</dc:language>
<pubDate>Fri, 08 Nov 2019 23:12:25 +0900</pubDate>
<item>
  <title>
  1##0##7##107##HOGEチャンネル##アニメ作品タイトル##15##話のタイトル##1572663600##1572665100
  </title>
  <link>http://cal.syoboi.jp/tid/5359#503710</link>
  <description/>
  <pubDate>2019-11-02T12:00:00+09:00</pubDate>
</item>
</channel>
</rss>
EOS
      end

      before do
        @parsed_items = ChitandaSan::SyoboiCalendar::Parser.parse(rss)
      end

      it { expect(@parsed_items.count).to eq 1 }
      it { expect(@parsed_items[0][:Cat]).to eq 1 }
      it { expect(@parsed_items[0][:CatName]).to eq '[TV]' }
      it { expect(@parsed_items[0][:Flag]).to eq 0 }
      it { expect(@parsed_items[0][:ChGID]).to eq 7 }
      it { expect(@parsed_items[0][:ChID]).to eq 107 }
      it { expect(@parsed_items[0][:ChName]).to eq 'HOGEチャンネル' }
      it { expect(@parsed_items[0][:Title]).to eq 'アニメ作品タイトル' }
      it { expect(@parsed_items[0][:Count]).to eq 15 }
      it { expect(@parsed_items[0][:SubTitleA]).to eq '話のタイトル' }
      it { expect(@parsed_items[0][:StTimeU]).to eq 1572663600 }
      it { expect(@parsed_items[0][:EdTimeU]).to eq 1572665100 }
    end
  end
end