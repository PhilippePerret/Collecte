describe 'Le parse…' do
  let(:folder_test) { @folder_test }
  let(:collecte) { @collecte }

  before(:all) do
    @folder_test  = folder_test_1
    @collecte     = Collecte.new(@folder_test)
    @collecte.parse
  end

  it 'définit correction le dossier @folder de la collecte' do
    expect(collecte.folder).to eq folder_test
  end
  it 'produit un dossier `data`' do
    expect(collecte).to respond_to :data_folder
    expect(collecte.data_folder).to eq File.join(folder_test, 'data')
    expect(File.exist? collecte.data_folder).to eq true
  end
end
