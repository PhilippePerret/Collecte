describe 'Fichier statistiques' do
  let(:collecte) { @collecte }
  let(:extracteur) { @extracteur ||= collecte.extractor }
  let(:code) { @code ||= extracteur.final_file.read }
  let(:stats) { @stats ||= collecte.film.stats }
  context 'sans laps de temps défini' do
    before(:all) do
      @collecte = Collecte.new(folder_test_5)
      @collecte.parse
      @collecte.extract(as: :statistiques)
    end
    describe 'les statistiques' do
      it 'considèrent qu’il y a 8 scènes' do
        expect(stats.nombre_scenes).to eq 8
      end
      it 'considèrent la scène 7 comme la plus longue' do
        expect(stats.longest_scene.numero).to eq 7
      end
      it 'considèrent la scène 8 comme la plus courte' do
        expect(stats.shortest_scene.numero).to eq 8
      end
      it 'considèrent qu’il y a 4 personnages' do
        expect(stats.nombre_personnages).to eq 4
      end
      it 'considèrent qu’il y a 5 brins' do
        expect(stats.nombre_brins).to eq 5
      end
    end
  end
  context 'avec un laps de temps défini' do
    before(:all) do
      @collecte = Collecte.new(folder_test_5)
      @collecte.parse
      @collecte.extract(
          as: :statistiques,
          from_time: '0:0', to_time: '25:0'
        )
    end
    describe 'les statistiques' do
      it 'considèrent qu’il y a 4 scènes seulement' do
        # puts "Avec la limite\n------------"
        # stats.scenes.each do |scene|
        #   puts "Scene ##{scene.numero} durée #{scene.duree}"
        # end
        expect(stats.nombre_scenes).to eq 4
      end
      it 'considèrent la scène 4 comme la plus longue' do
        expect(stats.longest_scene.numero).to eq 4
      end
      it 'considèrent la scène 1 comme la plus courte' do
        expect(stats.shortest_scene.numero).to eq 1
      end
      it 'considèrent qu’il y a 2 personnages' do
        expect(stats.nombre_personnages).to eq 2
      end
      it 'considèrent qu’il y a 3 brins' do
        expect(stats.nombre_brins).to eq 3
      end
    end
  end
end
