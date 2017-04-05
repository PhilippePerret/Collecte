# encoding: UTF-8

# Dossier de collecte test 1
def folder_test_1
  @folder_test_1 ||= File.join(MAIN_FOLDER, 'spec', 'asset', 'folder_test_1')
end
def folder_test_2
  @folder_test_2 ||= File.join(MAIN_FOLDER, 'spec', 'asset', 'folder_test_2')
end
