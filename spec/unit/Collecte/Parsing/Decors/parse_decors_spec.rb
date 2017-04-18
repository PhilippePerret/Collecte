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
      # puts "Donnée décors : #{d.inspect}"
      expect(d).not_to eq nil
      expect(d).to have_key :items
      expect(d[:items]).to be_instance_of Hash
    end
    describe 'enregistre dans le pstore du film' do
      it 'le bon nombre de décors' do
        # puts "saved_decors : #{saved_decors.inspect}"
        expect(saved_decors.count).to eq 6
      end
      describe 'les bonnes données associées à' do
        {
          1 => {decors_ids: [1], decor: 'MAISON DE JOE', sous_decor: 'GARAGE', lieu: 'I'},
          2 => {decors_ids: [2], decor: 'MAISON DE JAN', sous_decor: nil, lieu: 'I'},
          3 => {decors_ids: [3], decor: 'JARDIN', sous_decor: nil, lieu: 'E'},
          4 => {decors_ids: [4], decor: 'MAISON DE JOE', sous_decor: 'SALON', lieu: 'I'},
          5 => {decors_ids: [3], lieu: 'E'},
          6 => {decors_ids: [4], lieu: 'E'},
          7 => {decors_ids: [3,5], decor_alt:'MAISON DE JOE', lieu_alt:'I'},
          8 => {decors_ids: [6], decor: 'ABRIBUS', lieu:'E'}
        }.each do |sid, sdata|
          it "La scène #{sid} avec #{sdata.inspect}" do
            s = film.scenes[sid]
            expect(s.decors_ids).to eq sdata[:decors_ids]
            did = sdata[:decors_ids].first
            decor = film.decors[did]
            if sdata[:decor]
              expect(sdata[:decor]).to eq decor.decor
              expect(sdata[:sous_decor]).to eq decor.sous_decor
              expect(sdata[:lieu]).to eq decor.lieu
            end
            if sdata[:decors_ids].count > 1
              did = sdata[:decors_ids].last
              decor = film.decors[did]
              expect(sdata[:decor_alt]).to eq decor.decor
              expect(sdata[:sous_decor_alt]).to eq decor.sous_decor
              expect(sdata[:lieu_alt]).to eq decor.lieu
            end
          end
        end
      end
    end
  end
end
