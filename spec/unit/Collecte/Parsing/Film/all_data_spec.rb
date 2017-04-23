#
# Ce test permet de tester toutes les données enregistrées
# dans le pstore du film, de façon très détaillée.
#
# Ce test se fait sur le dossier 4 qui doit contenir toutes les
# sortes de données (brins, notes, personnages, relations). S'il
# doit être modifié (ce qui est possible), lancer toujours l'intégralité
# des tests pour vérifier sa conformité.
#
# Ce test fonctionne de façon particulière dans le sens où
# il est construit à la volée, en fonction du fichier de données
# `all_data_for_test.yml` qui est placé dans le dossier. Ce
# fichier a été créé à partir d'un enregistrement valide du
# pstore et peut être actualisé n'importe quand en débloquant
# ci-dessous les lignes qui s'en chargent.
#
require 'yaml'

# Pour obtenir une donnée dans le pstore du folder test 4
def get_from_pstore_4 key, skey = nil
  getted = nil
  pstore_4.transaction do |ps|
    getted = ps[key]
  end
  skey ? getted[skey] : getted
end

def pstore_4
  @pstore_4 ||= PStore.new(pstore_file_4)
end
def pstore_file_4
  @pstore_file_4 ||= File.join(folder_test_4, 'data', 'film.pstore')
end
def yaml_file_4
  @yaml_file_4 ||= File.join(folder_test_4, 'all_data_test.yml')
end

describe 'Data enregistrées pour le film' do

  let(:dossier_data) { @dosdata }

  # Méthode qui actualise les données enregistrées du
  # film (les données "expected").Ça ne doit être fait
  # que lorsque les données de collecte sont sûres et
  # que l'enregistrement de ces données est sûr lui-aussi
  def update_all_data_test
    # Toutes les données du film se trouvent dans le
    # pstore, on s'en sert pour construire la donnée du
    # fichier YAML
    alldata = Hash.new
    PStore.new(pstore_file_4).transaction do |ps|
      ps.roots.each do |k|
        alldata.merge!(k => ps[k])
      end
    end
    File.open(yaml_file_4, 'w'){|f| f.write alldata.to_yaml}
  end

  before(:all) do
    @dosdata = remove_folder_data_of folder_test_4
    parse_collecte(folder_test_4)

    # DÉBLOQUER LES LIGNES CI-DESSOUS POUR ACTUALISER
    # LE FICHIER all_data_test.yaml
    # Ceci doit être fait si les données de collecte
    # ont été modifiées.
    # update_all_data_test

  end

  it 'le fichier YAML de toutes les données existe' do
    expect(File.exist? yaml_file_4).to eq true
  end

  # # On construit le code du test à partir du fichier des
  # # données enregistrées
  allgooddata = YAML.load_file(yaml_file_4)
  # puts "all data : #{alldata.inspect}"

  shared_examples_for "une donnée groupe" do |items, item_name|
    it "contient le bon nombre d’éléments #{item_name.inspect}" do
      expect(collection.count).to eq items.count
    end
    items.each do |item_id, item_data|
      describe "Le #{item_name} #{item_id}" do
        item_data.each do |key, expected|
          if expected.instance_of?(Hash)
            expected.each do |skey, sexpected|
              it "a une propriété #{key.inspect}#{skey.inspect} à #{sexpected.inspect}" do
                expect(collection[item_id][key][skey]).to eq sexpected
              end
            end
          else
            it "a une propriété #{key.inspect} à #{expected.inspect}" do
              expect(collection[item_id][key]).to eq expected
            end
          end
        end
      end
    end
  end

  # ---------------------------------------------------------------------
  #   MÉTADONNÉES
  # ---------------------------------------------------------------------
  describe 'Les métadonnées' do
    before(:all) do
      @metadonnees = get_from_pstore_4 :metadata
    end
    let(:metadonnees) { @metadonnees }
    allgooddata[:metadata].each do |prop, expected|
      it "la propriété #{prop.inspect} est égale à #{expected.inspect}" do
        expect(metadonnees[prop]).to eq expected
      end
    end
  end
  # ---------------------------------------------------------------------
  #   LES SCÈNES
  # ---------------------------------------------------------------------
  describe 'Les scènes' do
    before(:all) do
      @scenes = get_from_pstore_4(:scene, :items)
    end
    # it 'leur nombre est correct' do
    #   expect(allgooddata[:scene][:items].count).to eq @nombre_de_scenes
    # end
    it_behaves_like 'une donnée groupe', allgooddata[:scene][:items], 'scène' do
      let(:collection) { @scenes }
    end

  end

  # ---------------------------------------------------------------------
  #   PERSONNAGES
  # ---------------------------------------------------------------------
  describe 'Personnages' do
    before(:all) do
      @personnages = get_from_pstore_4 :personnage, :items
    end
    it_behaves_like 'une donnée groupe', allgooddata[:personnage][:items], 'personnage' do
      let(:collection) { @personnages }
    end
  end

  # ---------------------------------------------------------------------
  #   DÉCORS
  # ---------------------------------------------------------------------
  describe 'Décors' do
    before(:all) do
      @decors = get_from_pstore_4 :decor, :items
    end
    it_behaves_like 'une donnée groupe', allgooddata[:decor][:items], 'décor' do
      let(:collection) { @decors }
    end
  end


  # ---------------------------------------------------------------------
  #   BRINS
  # ---------------------------------------------------------------------
  describe 'Brins' do
    before(:all) do
      @brins = get_from_pstore_4 :brin, :items
    end
    it_behaves_like 'une donnée groupe', allgooddata[:brin][:items], 'brin' do
      let(:collection) { @brins }
    end
  end

  # ---------------------------------------------------------------------
  #   NOTES
  # ---------------------------------------------------------------------
  describe 'Notes' do
    before(:all) do
      @notes = get_from_pstore_4 :note, :items
    end
    it_behaves_like 'une donnée groupe', allgooddata[:note][:items], 'note' do
      let(:collection) { @notes }
    end
  end

end
