
let $winsCell = $('.wins-cell');

for (let cell of $winsCell) {
  if (cell.innerText === '') {
    cell.innerText = '0'
  }
}

let $groupTables = $('#user-groups table');
let $joinGroupBtn = $('.join-group');
let $leaveGroupBtn = $('.leave-group');
let $draftFilmBtn = $('.draft-film');
let $removeFilmBtn = $('.remove-film-button');
let $filmColumns = $('.film-column');
let $logoutBtn = $('.signout');

if ($groupTables.length >= 8){
  $joinGroupBtn.addClass('disable-click');
} else {
  $joinGroupBtn.removeClass('disable-click');
}

for (let table of $groupTables) {
  if (table.childNodes[3].childNodes.length >= 17) {
    $draftFilmBtn.addClass('disable-click');
  } else {
    $draftFilmBtn.removeClass('disable-click');
  }
}