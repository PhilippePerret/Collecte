describe 'Parsing du collecte des scènes' do
  before(:all) do
    @collecte = Collecte.new(folder_test_1)
    # On purge le dossier `data`
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
      p = File.join(collecte.data_folder, 'scenes.msh')
      expect(File.exist? p).to eq true
    end
  end

  describe 'le fichier film.pstore' do
    # let(:datam) { @datam ||= Marshal.load(File.read collecte.film.scenes.marshal_file) }
    let(:datam) { @datam ||= PStore.new(collecte.film.pstore_file).transaction do |ps|
      ps[:scene]
    end }
    it 'existe' do
      expect(File.exist? collecte.film.pstore_file).to eq true
    end
    it 'définit le bon nombre de scènes' do
      expect(datam[:items].count).to eq 3
    end
    it 'définit correctement la première scène' do
      dscenes = datam[:items]
      scene1 = dscenes[1]
      expect(scene1).not_to eq nil
      {
        numero:   1,
        lieu:     'INT.',
        effet:    'JOUR', decors_ids: [1],
        line:     1,
        stt_points_ids: [:inc_pert, :inc_dec]
      }.each do |prop, expected|
        expect(scene1[prop]).to eq expected
      end
      {
        raw:      'Résumé de la première scène.',
        scene_id: 1,
        only_str:   'Résumé de la première scène.',
        brins_id: nil,
        notes_ids: []
      }.each do |prop, expected|
        expect(scene1[:resume][prop]).to eq expected
      end
    end

    describe 'troisième scène' do
      let(:scene3) { @scene3 ||= datam[:items][3] }
      it 'définit bien la scène' do
        expect(scene3).not_to eq nil
        {
          id: 3, numero: 3,
          effet:'JOUR', effet_alt: nil,
          decors_ids: [1,2],
          line: 12
        }.each do |prop, expected|
          expect(scene3[prop]).to eq expected
        end
        {
          horloge: '0:03:20', time: 200, real_time: 170,
          end_time: 230, real_end_time: 200, duree: 30
        }.each do |prop, expected|
          expect(scene3[:horloge][prop]).to eq expected
        end
      end

      it 'définit bien les paragraphes' do
        # Les paragraphes
        paragraphes = scene3[:paragraphes]
        expect(paragraphes).not_to eq nil
        expect(paragraphes.count).to eq 2
        parag1 = paragraphes[0]
        # puts "paragraphe 1 : #{parag1.inspect}"
        {
          raw: 'Paragraphe 1 de troisième. Avec première note. (1)',
          only_str: 'Paragraphe 1 de troisième. Avec première note.',
          notes_ids: [1],
          scene_id: 3
        }.each do |prop, expected|
          expect(parag1[prop]).to eq expected
        end
        parag2 = paragraphes[1]
        # puts "Paragraphe 2 : #{parag2.inspect}"
        {
          raw:    'Paragraphe 2 de troisième. Avec deuxième brin. b2',
          only_str: 'Paragraphe 2 de troisième. Avec deuxième brin.',
          brins_ids: [2],
          scene_id: 3
        }.each do |prop, expected|
          expect(parag2[prop]).to eq expected
        end
      end

      it 'définit bien les notes' do
        note1 = film.notes[1]
        {
          id: 1,
        }.each do |prop, expected|
          expect(note1.send(prop)).to eq expected
        end
        {
          raw: "La première note."
        }.each do |prop, expected|
          expect(note1.content.send(prop)).to eq expected
        end
      end
    end

  end
end
