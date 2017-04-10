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

  context 'avec l’option :debug à true' do
    before(:all) do
      @collecte = Collecte.new(folder_test_2)
      File.unlink(@collecte.log_file.path) if File.exist?(@collecte.log_file.path)
      expect(File.exist? @collecte.log_file.path).not_to eq true
      @collecte.parse(debug: true)

    end
    it 'crée et ouvre le fichier log.html' do
      expect(File.exist? Log.html_file.path).to eq true
    end
  end

  context 'en cas d’erreur et sans :debug à true' do
    before(:all) do
      @collecte = Collecte.new(folder_test_error_1)
      p = Log.html_file.path
      File.unlink(p) if File.exist?(p)
      expect(File.exist?(p)).not_to eq true
      @collecte.parse
    end
    let(:code) { @code ||= File.read(Log.html_file.path) }
    it 'construit et ouvre quand même le fichier journal' do
      expect(File.exist?(Log.html_file.path)).to eq true
    end
    it 'le journal contient le bon code' do
      expect(code).to have_tag('div.error', text: /L’intitulé de la scène 2 est mal formaté/)
    end
  end
end
