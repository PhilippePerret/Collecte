# encoding: UTF-8

# Dossier de collecte test 1
def folder_test_1
  @folder_test_1 ||= File.join(MAIN_FOLDER, 'spec', 'asset', 'folder_test_1')
end
def folder_test_2
  @folder_test_2 ||= File.join(MAIN_FOLDER, 'spec', 'asset', 'folder_test_2')
end
def folder_test_3
  @folder_test_3 ||= File.join(MAIN_FOLDER, 'spec', 'asset', 'folder_test_3')
end
def folder_test_4
  @folder_test_4 ||= File.join(MAIN_FOLDER, 'spec', 'asset', 'folder_test_4')
end
def folder_test_5
  @folder_test_5 ||= File.join(MAIN_FOLDER, 'spec', 'asset', 'folder_test_5')
end
def folder_test_6
  @folder_test_6 ||= File.join(MAIN_FOLDER, 'spec', 'asset', 'folder_test_6')
end
def folder_test_error_1
  @folder_test_error_1 ||= File.join(MAIN_FOLDER, 'spec', 'asset', 'folder_test_error_1')
end


# Détruit le dossier contenant les fichiers exportés et
# retourne son path (qui peut servir aux fichiers tests
# appelant)
def remove_folder_extraction_of dossier
  dos = File.join(dossier,'extraction')
  FileUtils.rm_rf(dos) if File.exist? dos
  dos
end

def remove_folder_data_of dossier
  dos = File.join(dossier,'data')
  FileUtils.rm_rf(dos) if File.exist? dos
  dos
end
