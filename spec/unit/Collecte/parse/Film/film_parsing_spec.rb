describe 'Film au cours du parsing' do

  let(:collecte) { @collecte }
  let(:film) { @film || collecte.film }
  let(:data) { @data ||= film.donnee_totale }

  context 'avec un parsing sans information générale' do
    before(:all) do
      @collecte = Collecte.new(folder_test_1)
      # ===> parse <===
      @collecte.parse
    end
    describe 'Le fichier `film.msh`' do
      it 'est produit' do
        expect(File.exist? film.marshal_file).to eq true
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
