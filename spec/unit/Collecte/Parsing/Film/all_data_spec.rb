#
# Ce test permet de tester toutes les données enregistrées
# dans le pstore du film, de façon très détaillée.
#
# Ce test se fait sur le dossier 4 qui doit contenir toutes les
# sortes de données (brins, notes, personnages, relations). S'il
# doit être modifié (ce qui est possible), lancer toujours l'intégralité
# des tests pour vérifier sa conformité.
#
describe 'Data enregistrées pour le film' do
  before(:all) do
    @dosdata = remove_folder_data_of folder_test_4
    parse_collecte(folder_test_4)
  end
  let(:pstore_file) { @pstore_file ||= collecte.film.pstore_file }

  describe 'le dossier data' do
    it 'existe' do
      expect(File.exist? collecte.data_folder).to eq true
    end
  end
  describe 'le pstore du film' do
    it 'existe' do
      expect(File.exist? pstore_file).to eq true
    end
  end
  describe 'les données du pstore du film contiennent' do
    let(:data) { @data ||= begin
      hdata = Hash.new
      PStore.new(pstore_file).transaction do |ps|
        ps.roots.each do |k|
          hdata.merge!(k => ps[k])
        end
      end
      hdata
    end }
    # ---------------------------------------------------------------------
    #   Les données des SCÈNES
    # ---------------------------------------------------------------------

    it '7 données de scènes' do
      expect(data).to have_key :scene
      expect(data[:scene][:items].count).to eq 7
    end

    shared_examples_for "une scène" do
      it "avec des données correctes" do
        log "data scène : #{data_scene.inspect}"
        data_expected.each do |k, expected|
          if expected.instance_of?(Hash)
            expected.each do |subk, subexpected|
              # puts "[#{k.inspect}][#{subk.inspect}] = #{subexpected.inspect}"
              expect(data_scene[k][subk]).to eq subexpected
            end
          else
            # puts "#{k.inspect} = #{expected.inspect}"
            expect(data_scene[k]).to eq expected
          end
        end
      end
    end

    describe 'la première scène' do
      it_behaves_like "une scène" do
        let(:data_scene){ data[:scene][:items][1] }
        let(:data_expected){
          {
            id: 1, numero: 1,
            decors_ids: [1],
            :effet=>"JOUR",
            brins_ids: [1],
            personnages_ids: ['joe'],
            paragraphes:[],
            horloge: {
              real_time: 0, end_time: 100,
              horloge:'0:00:30',
              duree: 70
            },
            resume: {
              raw: 'Première scène dans brin 1 seulement avec [PERSO#joe]. b1',
              personnages_ids: ['joe'],
              brins_ids: [1],
              scene_id: 1,
            },
          }
        }
      end
    end

    describe 'la scène 2' do
      it_behaves_like "une scène" do
        let(:data_scene){ data[:scene][:items][2] }
        let(:data_expected){
          {
          	:id=>2,
          	:numero=>2,
          	:line=>4,
          	:horloge=>{
          		:horloge=>"0:01:40",
          		:time=>100,
          		:real_time=>70,
          		:end_time=>200,
          		:real_end_time=>170,
          		:duree=>100
          		},
          	:resume=>{
          		:raw=>"Deuxième scène de [PERSO#joe] et d'[PERSO#andre] dans brin 2 et 1. b1",
          		:only_str=>"Deuxième scène de [PERSO#joe] et d'[PERSO#andre] dans brin 2 et 1.",
          		:personnages_ids=>["joe", "andre"],
          		:notes_ids=>[],
          		:brins_ids=>[1],
          		:scene_id=>2,
          		:scenes_ids=>nil,
          		:horloge=>nil
          		},
          	:effet=>"NUIT",
          	:effet_alt=>nil,
          	:lieu=>"EXT.",
          	:lieu_alt=>nil,
          	:decors_ids=>[2],
          	:fonction=>nil,
          	:brins_ids=>[1, 2],
          	:personnages_ids=>["joe", "andre"],
          	:paragraphes=>[
          		{
          			:raw=>"Le premier paragraphe appartient au brin 2. b2 (1)",
          			:only_str=>"Le premier paragraphe appartient au brin 2.",
          			:personnages_ids=>[],
          			:notes_ids=>[1],
          			:brins_ids=>[2],
          			:scene_id=>2,
          			:scenes_ids=>nil,
          			:horloge=>nil
          		}
          	],
          	:notes_ids=>[1],
          	:stt_points_ids=>nil
          }
        }
      end
    end

    describe 'la scène 3' do
      it_behaves_like "une scène" do
        let(:data_scene){ data[:scene][:items][3] }
        let(:data_expected){
          {
          	:id=>3,
          	:numero=>3,
          	:line=>9,
          	:horloge=>{
          		:horloge=>"0:03:20",
          		:time=>200,
          		:real_time=>170,
          		:end_time=>293,
          		:real_end_time=>263,
          		:duree=>93
          	},
          	:resume=>{
          		:raw=>"Troisième scène avec [PERSO#andre] et [PERSO#jan] dans brin 1 et 3. b1 b3",
          		:only_str=>"Troisième scène avec [PERSO#andre] et [PERSO#jan] dans brin 1 et 3.",
          		:personnages_ids=>["andre", "jan"],
          		:notes_ids=>[],
          		:brins_ids=>[1, 3],
          		:scene_id=>3,
          		:scenes_ids=>nil,
          		:horloge=>nil
          	},
          	:effet=>"JOUR",
          	:effet_alt=>nil,
          	:lieu=>"INT.",
          	:lieu_alt=>"EXT.",
          	:decors_ids=>[1, 2],
          	:fonction=>nil,
          	:brins_ids=>[1, 3],
          	:personnages_ids=>["andre", "jan"],
          	:paragraphes=>[],
          	:notes_ids=>nil,
          	:stt_points_ids=>nil
          }
        }
      end
    end

    describe 'la scène 4' do
      it_behaves_like "une scène" do
        let(:data_scene){ data[:scene][:items][4] }
        let(:data_expected){
          {
          	:id=>4,
          	:numero=>4,
          	:line=>12,
          	:horloge=>{
          		:horloge=>"0:04:53",
          		:time=>293,
          		:real_time=>263,
          		:end_time=>443,
          		:real_end_time=>413,
          		:duree=>150
          	},
          	:resume=>{
          		:raw=>"Quatrième scène dans brins 1, 2, 3, 4, 6. b1 b6",
          		:only_str=>"Quatrième scène dans brins 1, 2, 3, 4, 6.",
          		:personnages_ids=>[],
          		:notes_ids=>[],
          		:brins_ids=>[1, 6],
          		:scene_id=>4,
          		:scenes_ids=>nil,
          		:horloge=>nil
          	},
          	:effet=>"NUIT",
          	:effet_alt=>nil,
          	:lieu=>"INT.",
          	:lieu_alt=>nil,
          	:decors_ids=>[1],
          	:fonction=>nil,
          	:brins_ids=>[1, 6, 3, 4, 2],
          	:personnages_ids=>["joe", "jan"],
          	:paragraphes=>[
          		{
          			:raw=>"Paragraphe 1 de quatrième scène. (2)(3)",
          			:only_str=>"Paragraphe 1 de quatrième scène.",
          			:personnages_ids=>[],
          			:notes_ids=>[2, 3],
          			:brins_ids=>[],
          			:scene_id=>4,
          			:scenes_ids=>nil,
          			:horloge=>nil
          		},
          		{
          			:raw=>"Paragraphe 2 de quatrième scène appartient au brin 3. b3",
          			:only_str=>"Paragraphe 2 de quatrième scène appartient au brin 3.",
          			:personnages_ids=>[],
          			:notes_ids=>[],
          			:brins_ids=>[3],
          			:scene_id=>4,
          			:scenes_ids=>nil,
          			:horloge=>nil
          		},
          		{
          			:raw=>"Paragraphe 3 de quatrième scène avec [PERSO#joe] et [PERSO#jan].",
          			:only_str=>"Paragraphe 3 de quatrième scène avec [PERSO#joe] et [PERSO#jan].",
          			:personnages_ids=>["joe", "jan"],
          			:notes_ids=>[],
          			:brins_ids=>[],
          			:scene_id=>4,
          			:scenes_ids=>nil,
          			:horloge=>nil
          		},
          		{
          			:raw=>"Paragraphe 4 de quatrième scène appartient au brin 4. b4",
          			:only_str=>"Paragraphe 4 de quatrième scène appartient au brin 4.",
          			:personnages_ids=>[],
          			:notes_ids=>[],
          			:brins_ids=>[4],
          			:scene_id=>4,
          			:scenes_ids=>nil,
          			:horloge=>nil
          		},
          		{
          			:raw=>"Paragraphe 5 de quatrième scène appartient au brin 2. b2",
          			:only_str=>"Paragraphe 5 de quatrième scène appartient au brin 2.",
          			:personnages_ids=>[],
          			:notes_ids=>[],
          			:brins_ids=>[2],
          			:scene_id=>4,
          			:scenes_ids=>nil,
          			:horloge=>nil
          		}
          	],
          	:notes_ids=>[2, 3],
          	:stt_points_ids=>nil
          }
        }
      end
    end

    describe 'la scène 5' do
      it_behaves_like "une scène" do
        let(:data_scene){ data[:scene][:items][5] }
        let(:data_expected){
          {
          	:id=>5,
          	:numero=>5,
          	:line=>22,
          	:horloge=>{
          		:horloge=>"0:07:23",
          		:time=>443,
          		:real_time=>413,
          		:end_time=>705,
          		:real_end_time=>675,
          		:duree=>262
          	},
          	:resume=>{
          		:raw=>"[PERSO#joe] joue dans la cinquième scène dans brin 1 et 3. b1 b3 (5)",
          		:only_str=>"[PERSO#joe] joue dans la cinquième scène dans brin 1 et 3.",
          		:personnages_ids=>["joe"],
          		:notes_ids=>[5],
          		:brins_ids=>[1, 3],
          		:scene_id=>5,
          		:scenes_ids=>nil,
          		:horloge=>nil
          	},
          	:effet=>"JOUR",
          	:effet_alt=>nil,
          	:lieu=>"INT.",
          	:lieu_alt=>nil,
          	:decors_ids=>[1],
          	:fonction=>nil,
          	:brins_ids=>[1, 3],
          	:personnages_ids=>["joe"],
          	:paragraphes=>[],
          	:notes_ids=>[5],
          	:stt_points_ids=>nil
          }
        }
      end
    end

    describe 'la scène 6' do
      it_behaves_like "une scène" do
        let(:data_scene){ data[:scene][:items][6] }
        let(:data_expected){
          {
          	:id=>6,
          	:numero=>6,
          	:line=>26,
          	:horloge=>{
          		:horloge=>"0:11:45",
          		:time=>705,
          		:real_time=>675,
          		:end_time=>915,
          		:real_end_time=>885,
          		:duree=>210
          	},
          	:resume=>{
          		:raw=>"[PERSO#joe] et [PERSO#andre] sont dans la sixième scène qui n'appartient à aucun brin.",
          		:only_str=>"[PERSO#joe] et [PERSO#andre] sont dans la sixième scène qui n'appartient à aucun brin.",
          		:personnages_ids=>["joe", "andre"],
          		:notes_ids=>[],
          		:brins_ids=>[],
          		:scene_id=>6,
          		:scenes_ids=>nil,
          		:horloge=>nil
          	},
          	:effet=>"NUIT",
          	:effet_alt=>nil,
          	:lieu=>"EXT.",
          	:lieu_alt=>nil,
          	:decors_ids=>[2],
          	:fonction=>nil,
          	:brins_ids=>nil,
          	:personnages_ids=>["joe", "andre"],
          	:paragraphes=>[],
          	:notes_ids=>nil,
          	:stt_points_ids=>nil
          }
        }
      end
    end

    describe 'la scène 7' do
      it_behaves_like "une scène" do
        let(:data_scene){ data[:scene][:items][7] }
        let(:data_expected){
          {
          	:id=>7,
          	:numero=>7,
          	:line=>29,
          	:horloge=>{
          		:horloge=>"0:15:15",
          		:time=>915,
          		:real_time=>885,
          		:end_time=>2700,
          		:real_end_time=>2670,
          		:duree=>1785
          	},
          	:resume=>{
          		:raw=>"Septième scène dans le brin 2 seulement. b2",
          		:only_str=>"Septième scène dans le brin 2 seulement.",
          		:personnages_ids=>[],
          		:notes_ids=>[],
          		:brins_ids=>[2],
          		:scene_id=>7,
          		:scenes_ids=>nil,
          		:horloge=>nil
          	},
          	:effet=>"JOUR",
          	:effet_alt=>nil,
          	:lieu=>"INT.",
          	:lieu_alt=>nil,
          	:decors_ids=>[1],
          	:fonction=>nil,
          	:brins_ids=>[2],
          	:personnages_ids=>["andre", "jan"],
          	:paragraphes=>[
          		{
          			:raw=>"Premier paragraphe de la 7e scène avec [PERSO#andre].",
          			:only_str=>"Premier paragraphe de la 7e scène avec [PERSO#andre].",
          			:personnages_ids=>["andre"],
          			:notes_ids=>[],
          			:brins_ids=>[],
          			:scene_id=>7,
          			:scenes_ids=>nil,
          			:horloge=>nil
          		}, {
          			:raw=>"Second paragraphe de la 7e scène avec [PERSO#jan]. (4)",
          			:only_str=>"Second paragraphe de la 7e scène avec [PERSO#jan].",
          			:personnages_ids=>["jan"],
          			:notes_ids=>[4],
          			:brins_ids=>[],
          			:scene_id=>7,
          			:scenes_ids=>nil,
          			:horloge=>nil
          		}
          	],
          	:notes_ids=>[4],
          	:stt_points_ids=>nil
          }
        }
      end
    end

  end
end
