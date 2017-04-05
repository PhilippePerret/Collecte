describe 'Chargement des données film' do
  before(:all) do
    @collecte = Collecte.new(folder_test_2)
    # Il faut parser les fichiers si le fichier film.msh
    # n'existe pas. Mais dans ce cas, il faut réinitialiser
    # la donnée collecte.
    File.exist?(@collecte.film.marshal_file) || begin
      @collecte.parse
      @collecte.new(folder_test_2)
    end

    # Vérifier
    expect(@collecte.film.scenes.count).to eq 0
    expect(@collecte.film.personnages.count).to eq 0
  end
  let(:collecte) { @collecte }
  let(:film) { @film ||= collecte.film }
  describe '#load_if_exist' do
    it 'répond' do
      expect(film).to respond_to :load_if_exist
    end
  end
  describe '#load' do
    before(:each) do
      @collecte = Collecte.new(folder_test_2)
      expect(@collecte.film.scenes.count).to eq 0
      expect(@collecte.film.personnages.count).to eq 0
      expect(@collecte.film.brins.count).to eq 0
      expect(@collecte.film.notes.count).to eq 0
      # =====> LOAD <=====
      @collecte.film.load
    end
    it 'répond' do
      expect(film).to respond_to :load
    end
    it 'charge les scènes' do
      expect(film.scenes.count).to eq 4
    end
    describe 'respecte les données des scènes' do
      it 'le résumé est un Film::TextObjet' do
        first_scene = film.scenes[1]
        expect(first_scene.resume).to be_instance_of Film::TextObjet
      end
      it 'l’horloge est un Film::Horloge' do
        second_scene = film.scenes[2]
        expect(second_scene.horloge).to be_instance_of Film::Horloge
      end
      it 'l’horloge contient la bonne valeur' do
        scene3 = film.scenes[3]
        expect(scene3.horloge.horloge).to eq '0:03:20'
      end
    end
    it 'charge les personnages' do
      expect(film.personnages.count).to eq 2
    end
    it 'charge les brins' do
      expect(film.brins.count).to eq 5
    end
    it 'charge les notes' do
      expect(film.notes.count).to eq 3
    end
  end
end
