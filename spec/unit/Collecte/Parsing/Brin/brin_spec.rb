describe 'Parsing d’un brin' do
  before(:all) do
    @collecte = Collecte.new(folder_test_1)
    @film = @collecte.film
    # Il faut charger le module de parsing
    Collecte.load_module 'parsing'
  end

  describe 'Film::Brin#parse' do
    before(:each) do

    end
    let(:brin) { @brin ||= Film::Brin.new(@film) }
    it 'répond' do
      expect(brin).to respond_to :parse
    end
    context 'avec toutes les données' do
      it 'parse correctement le brin' do
        brin.parse("12#{RC}Libellé du brin#{RC}Description du brin")
        expect(brin.id).to eq 12
        expect(brin.libelle.only_str).to eq 'Libellé du brin'
        expect(brin.description.only_str).to eq 'Description du brin'
      end
    end
    context 'sans la description' do
      it 'parse correctement le brin' do
        brin.parse("13#{RC}Un libellé sans description")
        expect(brin.id).to eq 13
        expect(brin.libelle.only_str).to eq 'Un libellé sans description'
        expect(brin.description).to eq nil
      end
    end
    context 'avec un mauvais ID' do
      it 'produit une erreur de parsing' do
        expect{brin.parse("BAD#{RC}Libellé")}.to raise_error(BadBlocData)
      end
    end
    context 'avec seulement un ID sans libellé ni description' do
      it 'produit une erreur de parsing' do
        expect{brin.parse("12")}.to raise_error(BadBlocData)
      end
    end
  end
end
