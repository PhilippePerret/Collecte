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
    end
  end

  describe 'le fichier scenes.msh' do
    let(:datam) { @datam ||= Marshal.load(File.read collecte.film.scenes.marshal_file) }
    it 'existe' do
      expect(File.exist? collecte.film.scenes.marshal_file).to eq true
    end
    it 'définit le bon nombre de scènes' do
      expect(datam[:items].count).to eq 3
    end
    it 'définit correctement la première scène' do
      dscenes = datam[:items]
      scene1 = dscenes[1]
      expect(scene1).not_to eq nil
      puts "scene 1 :#{scene1.inspect}"
      {
        lieu: 'INT.',
        effet: 'JOUR', decor: 'MAISON DE JOE',

      }.each do |prop, expected|
        expect(scene1[prop]).to eq expected
      end
      {
        raw:      'Résumé de la première scène.',
        scene_id: 1,
        to_str:   'Résumé de la première scène.',
        brins_id: nil,
        notes_ids: []
      }.each do |prop, expected|
        puts "prop: #{prop.inspect}"
        expect(scene1[:resume][prop]).to eq expected
      end
    end

    it 'définit correctement la troisième scène (à trois décors)' do
      scene3 = datam[:items][3]
      puts "scène 3 : #{scene3.inspect}"
      expect(scene3).not_to eq nil
      {
        id: 3, numero: 3,
        horloge: '0:03:20',
        lieu: 'INT.', lieu_alt: 'EXIT.',
        effet:'JOUR', effet_alt: nil,
        decor: 'MAISON DE JOE', decor_alt:'JARDIN PUBLIC'
      }.each do |prop, expected|
        expect(scene3[prop]).to eq expected
      end
    end
  end
end
