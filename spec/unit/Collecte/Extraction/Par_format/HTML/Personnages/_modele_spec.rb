describe 'Extraction des brins de tous les personnages' do
  before(:all) do
    @dosext = File.join(folder_test_5,'extraction')
    FileUtils.rm_rf(@dosext) if File.exist? @dosext
    parse_collecte(folder_test_5)
  end
end
