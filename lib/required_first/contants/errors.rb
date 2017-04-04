# encoding: UTF-8
#
# CONSTANTES D'ERREUR
# 

# Erreur générée lorsque les données sont mal définies dans
# un bloc de code. Par exemple lorsque l'ID manque sur la
# première ligne du brin dans son fichier de collecte
class BadBlocData < StandardError; end
