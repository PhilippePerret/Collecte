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
    it 'calcule les statistiques pour tout le film' do
      expect(stats.nombre_scenes).to eq 8
      # 8 scènes
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
    it 'calcule les statistiques dans ce temps' do
      expect(stats.nombre_scenes).to eq 4
    end
  end
end
