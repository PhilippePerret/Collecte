describe 'Parsing des décors du film' do
  before(:all) do
    parse_collecte(folder_test_6)
  end

  let(:donnee_decors) { @donnee_decors ||= begin
    film.pstore.transaction do |ps|
      ps[:decor]
    end
  end }
  let(:saved_decors) { @saved_decors ||= donnee_decors[:items] }

  describe 'Le parse du film' do
    it 'parse les décors' do
      expect(film.decors).not_to eq nil
    end
    it 'enregistre les décors dans le pstore du film' do
      d = donnee_decors
      puts "Donnée décors : #{d.inspect}"
      expect(d).not_to eq nil
      expect(d).to have_key :items
      expect(d[:items]).to be_instance_of Hash
    end
    describe 'enregistre dans le pstore du film' do
      it 'le bon nombre de décors' do
        expect(saved_decors.count).to eq 9
      end
    end
  end
end
