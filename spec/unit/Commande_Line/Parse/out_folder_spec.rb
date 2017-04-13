describe 'Test de la ligne de commande hors du dossier de collecte' do
  before(:each) do
    @collecte = Collecte.new(folder_test_1)
    FileUtils.rm_rf(@collecte.data_folder) if File.exist?(@collecte.data_folder)
  end

  let(:collecte) { @collecte }

  context 'sans indiquer le path du fichier ni commande' do
    it 'ne crée par le dossier data' do
      `collecte`
      expect(File.exist? collecte.data_folder).to eq false
    end
  end

  context 'en indiquant la commande (parse) mais pas le path du dossier collecte' do
    it 'produit une erreur' do
      res = `collecte parse`
      expect(res.strip).to eq "### ERREUR : Le dossier courant (`#{File.expand_path('.')}`) n’est pas un dossier de collecte."
    end
  end
  context 'avec seulement `collecte parse` mais dans un dossier de collecte' do
    it 'parse correctement les fichiers' do
      fdata = File.join(folder_test_1,'data')
      FileUtils.rm_rf(fdata) if File.exist?(fdata)
      expect(File.exist? fdata).to eq false
      Dir.chdir(folder_test_1) do
        res = `collecte parse`
        expect(res.nil_if_empty).to eq nil
      end
      expect(File.exist? fdata).to eq true
    end
  end

  context 'en indiquant un dossier qui n’existe pas' do
    it 'produit une erreur' do
      res = `collecte parse bad/folder/collecte`
      expect(res.strip).to eq '### ERREUR : Le dossier de collecte `bad/folder/collecte` est introuvable…'
    end
  end
end
