var current_perso_id = null;
var current_note_id  = null;
var current_brin_id  = null;

function personnage(perso_id){
  return document.getElementById('fiche-personnage-'+perso_id);
}
function ShowPersonnage(perso_id){
  var same_fiche = perso_id == current_perso_id;
  if(current_perso_id){HidePersonnage(perso_id)}
  if(false == same_fiche){
    personnage(perso_id).classList = 'fiche personnage';
    current_perso_id = perso_id;
  }
  return false;
}
function HidePersonnage(perso_id){
  personnage(perso_id).classList = 'fiche personnage hidden';
  current_perso_id = null;
  return false;
}

function note(note_id){
  return document.getElementById('fiche-note-'+note_id);
}
function ShowNote(note_id){
  var same_fiche = note_id == current_note_id;
  if(current_note_id){HideNote(current_note_id)}
  if(false == same_fiche){
    note(note_id).classList = 'fiche note';
    current_note_id = note_id;
  }
  return false;
}
function HideNote(note_id){
  note(note_id).classList = 'fiche note hidden';
  current_note_id = null;
  return false;
}
function brin(brin_id){
  return document.getElementById('fiche-brin-'+brin_id);
}
function ShowBrin(brin_id){
  var same_fiche = brin_id == current_brin_id;
  if(current_brin_id){HideBrin(current_brin_id)}
  if(false == same_fiche){
    brin(brin_id).classList = 'fiche brin';
    current_brin_id = brin_id;
  }
  return false;
}
function HideBrin(brin_id){
  brin(brin_id).classList = 'fiche brin hidden';
  current_brin_id = null;
  return false;
}
