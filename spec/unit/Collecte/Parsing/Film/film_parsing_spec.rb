describe 'Film au cours du parsing' do

  after(:all) do
    # Après le test de cette feuille, on repasse toujours
    # dans le mode de données pstore
    Film::MODE_DATA_SAVE = :pstore
    Film::MODE_DATA_LOAD = :pstore
  end

  let(:collecte) { @collecte }
  let(:film) { @film || collecte.film }
  let(:data) { @data ||= film.donnee_totale }

  context 'avec un parsing au format Marshal' do
    before(:all) do
      Film::MODE_DATA_SAVE = :marshal
      Film::MODE_DATA_LOAD = :marshal
      @collecte = Collecte.new(folder_test_1)
      FileUtils.rm_rf(@collecte.data_folder)
      # ===> parse <===
      @collecte.parse
    end
    it 'créer un fichier Marshal' do
      expect(File.exist? film.marshal_file).to eq true
    end
    it 'ne crée pas un fichier PStore' do
      expect(File.exist? film.pstore_file).to eq false
    end
  end
  context 'avec un parsing au format PStore' do
    before(:all) do
      Film::MODE_DATA_SAVE = :pstore
      Film::MODE_DATA_LOAD = :pstore
      @collecte = Collecte.new(folder_test_1)
      FileUtils.rm_rf(@collecte.data_folder)
      # ===> parse <===
      @collecte.parse
    end
    it 'NE crée PAS un fichier Marshal' do
      expect(File.exist? film.marshal_file).to eq false
    end
    it 'crée un fichier PStore' do
      expect(File.exist? film.pstore_file).to eq true
    end
  end

  context 'avec un parsing sans information générale' do
    before(:all) do
      Film::MODE_DATA_SAVE = :pstore
      Film::MODE_DATA_LOAD = :pstore
      @collecte = Collecte.new(folder_test_1)
      FileUtils.rm_rf(@collecte.data_folder)
      # ===> parse <===
      @collecte.parse
    end
    describe 'Le fichier `film.pstore`' do
      it 'est produit' do
        expect(File.exist? film.pstore_file).to eq true
      end
      it 'ne définit pas l’id du film' do
        expect(data[:id]).to eq nil
      end
    end
  end
  # /sans information générale

  context 'avec un fichier définissant les métadonnées' do
    before(:all) do
      @collecte = Collecte.new(folder_test_2)
      # ===> parse <===
      @collecte.parse
    end
    describe 'le fichier `film.msh`' do
      it 'est produit' do
        expect(File.exist? film.marshal_file).to eq true
      end
      it 'définit l’identifiant du film' do
        expect(data[:id]).not_to eq nil
      end
      it 'met la bonne valeur dans l’id du film' do
        expect(data[:id]).to eq 'Everest2016'
      end
      it 'définit le titre du film' do
        expect(data[:titre]).to eq 'Éverest'
      end
    end
    describe 'le fichier `film.pstore`' do
      it 'est produit' do
        expect(File.exists? film.pstore_file).to eq true
      end
    end
    describe 'l’instance Film' do
      it 'définit @id' do
        expect(film.id).to eq 'Everest2016'
      end
      it 'définit @titre' do
        expect(film.titre).to eq 'Éverest'
      end
    end
    describe 'l’instance Collecte' do
      it 'définit la liste des auteurs' do
        expect(collecte.auteurs).to eq ['Phil', 'Benoit']
      end
      it 'définit la date de début de collecte' do
        expect(collecte.debut).to eq '25/4/2017'
      end
      it 'définit la date de fin de la collecte' do
        expect(collecte.fin).to eq '30/4/2017'
      end
    end
    # /avec un fichier de métadonnées
  end

  describe 'Le fichier film.msh' do
    before(:all) do
      @collecte = Collecte.new folder_test_2
      @collecte.parse
    end
    let(:totale) { @totale ||= film.donnee_totale }
    it 'existe' do
      expect(File.exist? film.marshal_file).to eq true
    end
    it 'contient les données scènes' do
      expect(totale).to have_key :scenes
    end
    it 'contient les données personnages' do
      expect(totale).to have_key :personnages
    end
    it 'contient les données brins' do
      expect(totale).to have_key :brins
    end
    it 'contient les données notes' do
      expect(totale).to have_key :notes
    end
    it 'contient les données des décors' do
      expect(totale).to have_key :decors
    end
    it 'contient toutes les scènes' do
      expect(totale[:scenes][:items].count).to eq 4
    end
    it 'contient tous les brins' do
      expect(totale[:brins][:items].count).to eq 5
    end
    it 'contient tous les personnages' do
      expect(totale[:personnages][:items].count).to eq 2
    end
    it 'contient toutes les notes' do
      expect(totale[:notes][:items].count).to eq 6
    end
  end
end
