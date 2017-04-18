describe 'La durée des décors' do
  before(:all) do
    parse_collecte(folder_test_2)
  end
  describe 'ont une propriété @duree' do
    it 'qui existe' do
      expect(film.decors.first).to respond_to :duree
    end
    it 'qui retourne la durée d’utilisation du décor' do
      {
        1 => {duree: 3*60+43},
        2 => {duree: 3*60+13}
      }.each do |did, hdecor|
        expect(film.decors[did].duree).to eq hdecor[:duree]
      end
    end
  end

end
