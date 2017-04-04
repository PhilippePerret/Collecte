describe 'String' do
  describe '#h2s' do
    it 'répond' do
      expect('subject').to respond_to :h2s
    end
    [
      ['0', 0],
      ['120', 120],
      ['1:00', 60],
      [':30', 30],
      ['02:05', 125],
      ['1:20:30', 4830],
      ['01:02:03', 3723]
    ].each do |h,s|
      it "'#{h}'.h2s retourne #{s}" do
        expect(h.h2s).to eq s
      end
    end
  end
end
