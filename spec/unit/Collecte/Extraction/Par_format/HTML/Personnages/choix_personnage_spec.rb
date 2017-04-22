
describe 'Extraction des brins quelques personnages' do
  before(:all) do
    @dosext = remove_folder_extraction_of folder_test_5
    parse_collecte(folder_test_5)
  end

  # Retourne le path du fichier du brin du personnage
  # d'identifiant +perso_id+
  def path_fichier_brin_de perso_id
    File.join(@dosext, "full_brin_#{perso_id}.html")
  end

  describe 'L’export d’un seul personnage (jan)' do
    before(:all) do
      @dosext = remove_folder_extraction_of folder_test_5
      collecte.extract(as: :brin_personnage, personnage: 'jan')
    end
    it 'produit le fichier brin du personnage' do
      fpath = path_fichier_brin_de 'jan'
      expect(File.exist? fpath).to eq true
    end
    it 'ne produit pas les fichiers brins des autres personnages' do
      ['joe', 'trois', 'quatre'].each do |pid|
        fpath = path_fichier_brin_de pid
        expect(File.exist? fpath).to eq false
      end
    end
  end
  describe 'L’export de plusieurs personnages (trois et quatre)' do
    before(:all) do
      @dosext = remove_folder_extraction_of folder_test_5
      collecte.extract(as: :brin_personnage, personnages: ['trois', 'quatre'])
    end
    it 'produit le fichier brin de trois' do
      fpath = path_fichier_brin_de('trois')
      expect(File.exist? fpath).to eq true
    end
    it 'produit le fichier brin de quatre' do
      fpath = path_fichier_brin_de('quatre')
      expect(File.exist? fpath).to eq true
    end
    it 'ne produit pas les fichiers des autres personnages' do
      ['joe', 'jan'].each do |pid|
        fpath = path_fichier_brin_de(pid)
        expect(File.exist? fpath).to eq false
      end
    end
  end
end
