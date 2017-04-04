describe 'Fixnum' do

  describe '#s2h' do
    it 'répond' do
      expect(12).to respond_to :s2h
    end
    [
      [12, '0:00:12'],
      [60, '0:01:00'],
      [3600, '1:00:00'],
      [125, '0:02:05'],
      [4830, '1:20:30'],
      [3723, '1:02:03']
    ].each do |s, h|
      it "`#{s}.s2h` retourne « #{h} »" do
        expect(s.s2h).to eq h
      end
    end
  end
end
