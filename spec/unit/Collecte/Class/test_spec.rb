describe 'Mode test' do
  after(:all) do
    Collecte.set_mode_test true
  end
  context 'en mode test' do
    before(:all) do
      Collecte.set_mode_test true
    end
    it 'Collecte est en mode test' do
      expect(Collecte).to be_mode_test
    end
  end
  context 'hors mode test' do
    before(:all) do
      Collecte.set_mode_test false
    end
    it 'Collecte n’est pas en mode test' do
      expect(Collecte).not_to be_mode_test
    end
  end
end
