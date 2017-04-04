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
  it 'produit un dossier `parsing`' do
    expect(collecte).to respond_to :parsing_folder
    expect(collecte.parsing_folder).to eq File.join(folder_test, 'parsing')
    expect(File.exist? collecte.parsing_folder).to eq true
  end
end
