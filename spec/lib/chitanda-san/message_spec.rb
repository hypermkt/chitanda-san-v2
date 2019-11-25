require 'rspec'
require_relative '../../../lib/chitanda-san/message'

RSpec.describe 'ChitandaSan::Message' do
  describe '#create' do
    context '正常系' do
      let!(:expected) do
"*わたし、今日のテレビアニメが気になります！*
[TV] 11/02(Sat) 12:00 - 11/02(Sat) 12:25 Hogeチャンネル / *タイトル 10話*"
      end
      before do
        items = [
          { Cat: 1, CatName: '[TV]', ChGID: 1, Flag: 0, ChID: 1, ChName: 'Hogeチャンネル', Title: 'タイトル', Count: 10, SubTitleA: '話のタイトル', StTimeU: 1572663600, EdTimeU: 1572665100 }
        ]
        @result = ChitandaSan::Message.create items
      end
      it { expect(@result).to eq expected }
    end
    context '映画のある日' do
      let!(:expected) do
"*わたし、今日のテレビアニメが気になります！*
[映] 11/22(Fri) 21:00 - 11/22(Fri) 22:54 Fugaテレビ / *タイトル劇場版*
[TV] 11/22(Fri) 22:00 - 11/22(Fri) 22:30 Hogeチャンネル / *タイトル 10話*"
      end
      before do
        items = [
          { Cat: 8, CatName: '[映]', ChGID: 1, Flag: 8, ChID: 4, ChName: 'Fugaテレビ', Title: 'タイトル劇場版', Count: 0, SubTitleA: '', StTimeU: 1574424000, EdTimeU: 1574430840 },
          { Cat: 1, CatName: '[TV]', ChGID: 1, Flag: 0, ChID: 1, ChName: 'Hogeチャンネル', Title: 'タイトル', Count: 10, SubTitleA: '話のタイトル', StTimeU: 1574427600, EdTimeU: 1574429400 }
        ]
        @result = ChitandaSan::Message.create items
      end
      it { expect(@result).to eq expected }
    end
  end
end
