describe 'Parsing du collecte des scènes' do
  before(:all) do
    @collecte = Collecte.new(folder_test_1)
    # On purge le dossier `data` et le dossier `parsing`
    FileUtils.rm_rf @collecte.parsing_folder
    FileUtils.rm_rf @collecte.data_folder
    expect(@collecte.film.brins.count).to eq 0
    # On procède au parse général
    expect{@collecte.parse}.not_to raise_error
  end

  let(:collecte) { @collecte }
  let(:film) { @film ||= collecte.film }

  describe 'Méthode #parse_scenes' do
    it 'répond' do
      expect(collecte).to respond_to :parse_scenes
    end
    it 'dispatche les scènes dans le film' do
      expect(film.scenes.count).to be > 2
    end
    it 'créer le dossier `data` dans le dossier de collecte' do
      expect(File.exist? collecte.data_folder).to eq true
    end
    it 'produit le fichier data/scenes.msh dans le dossier de collecte' do
      expect(File.exist? collecte.film.scenes.marshal_file).to eq true
    end
  end
end
