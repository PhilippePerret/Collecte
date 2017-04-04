describe 'Test du parsing des personnages' do
  before(:all) do
    @collecte = Collecte.new(folder_test_1)
    # On purge le dossier `data` et le dossier `parsing`
    FileUtils.rm_rf @collecte.parsing_folder
    FileUtils.rm_rf @collecte.data_folder
    expect(@collecte.film.personnages.count).to eq 0
    # On procède au parse des brins
    expect{@collecte.parse}.not_to raise_error
  end

  let(:collecte) { @collecte }
  let(:film) { @film ||= collecte.film }

  describe 'Méthode #parse_personnages' do
    it 'répond' do
      expect(collecte).to respond_to :parse_personnages
    end
    it 'dispatche les personnages dans le film' do
      expect(film.personnages.count).to be > 0
    end
    it 'dispatche correctement les personnages définis' do
      code = File.read(film.personnages.collecte_file)
      personnages = Hash.new
      code.split(RC*2).each do |bloc|
        hperso = Hash.new
        bloc.split(RC).each do |line|
          prop, value = line.strip.split(':')
          prop = prop.downcase.to_sym
          prop = :id if prop == :personnage
          hperso.merge!(prop => value.nil_if_empty)
        end

        # Dans le film
        iperso = film.personnages[hperso[:id]]
        expect(iperso).not_to eq nil
        expect(iperso).to be_instance_of Film::Personnage
        [
          :id, :prenom, :nom, :pseudo, :fonction, :description
        ].each do |prop|
          expected =
            if prop == :pseudo && hperso[:pseudo].nil?
              "#{hperso[:prenom]} #{hperso[:nom]}".strip
            else
              hperso[prop]
            end
          expect(iperso.send(prop)).to eq expected
        end
      end
    end
    it 'créer le dossier `data` dans le dossier de collecte' do
      expect(File.exist? collecte.data_folder).to eq true
    end
    it 'produit le fichier data/personnages.msh dans le dossier de collecte' do
      expect(File.exist? collecte.film.personnages.marshal_file).to eq true
    end
  end
end
