var curfid = null;

function ShowPersonnage(oid){return TraiteFiche(oid, 'personnage')}
function ShowNote(oid){return TraiteFiche(oid, 'note')}
function ShowBrin(oid){return TraiteFiche(oid, 'brin')}

function TraiteFiche(oid, otype){
  var fid = 'fiche-'+otype+'-'+oid;
  var other_fiche = fid != curfid;
  if(curfid){HideCurFiche()}
  if(other_fiche){ShowFiche(fid, otype)}
  return false;
}

// Retourne la fiche d'identifiant +fid+
function DOMObject(fid){return document.getElementById(fid)}

function ShowFiche(fid, ftype){
  DOMObject(fid).classList='fiche '+ftype;
  curfid=fid;
}

// Masque la fiche courante
function HideCurFiche(){
  var obj = document.getElementById(curfid);
  obj.classList=obj.classList+' hidden';
  curfid=null;
  return false;//pour la croix de fermeture
}
