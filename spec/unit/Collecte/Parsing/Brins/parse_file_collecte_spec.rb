describe 'Parsing du collecte des brins' do
  before(:all) do
    @collecte = Collecte.new(folder_test_1)
    # On purge le dossier `data` et le dossier `parsing`
    FileUtils.rm_rf @collecte.data_folder
    expect(@collecte.film.brins.count).to eq 0
    # On procède au parse des brins
    expect{@collecte.parse}.not_to raise_error
  end

  let(:collecte) { @collecte }
  let(:film) { @film ||= collecte.film }

  describe 'Méthode #parse_brins' do
    it 'répond' do
      expect(collecte).to respond_to :parse_brins
    end
    it 'dispatche les brins dans le film' do
      expect(film.brins.count).to be > 0
    end
    it 'créer le dossier `data` dans le dossier de collecte' do
      expect(File.exist? collecte.data_folder).to eq true
    end
    it 'produit le fichier data/brins.msh dans le dossier de collecte' do
      expect(File.exist? collecte.film.brins.marshal_file).to eq true
    end
  end
end
