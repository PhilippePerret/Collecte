describe 'Ecarts avec le PFA' do
  let(:collecte)  { @collecte }
  let(:extrateur) { @extracteur ||= collecte.extractor }
  let(:stats)     { @stats      ||= collecte.film.stats }
  let(:code)      { @code       ||= extracteur.final_file.read }
  context 'sans donnée structure' do
    before(:all) do

    end
    it 'ne donne pas de données PFA' do
      pending
    end
  end

  context 'avec des données structure' do
    before(:all) do
      @collecte = Collecte.new(folder_test_5)
      @collecte.parse
      @collecte.extract(as: :statistiques)
    end
    it 'donne des données PFA' do
      expect(stats.data_pfa).not_to eq nil
      puts "stats.data_pfa = #{stats.data_pfa.inspect}"
    end
  end
end
