let $winsCell = $('.wins-cell');

for (let cell of $winsCell) {
  if (cell.innerText === '') {
    // console.log(cell, 'Should be 0');
    cell.innerText = '0'
  }
}

let $groupTables = $('#user-groups table');
let $joinGroupBtn = $('.join-group');
let $draftFilmBtn = $('.draft-film');
let $filmColumns = $('.film-column');

if ($groupTables.length >= 8){
  // $joinGroupBtn.disabled = true;
  $joinGroupBtn.addClass('disable-click');
} else {
  // $joinGroupBtn.disabled = false;
  $joinGroupBtn.removeClass('disable-click');
}

for (let table of $groupTables) {
  if (table.childNodes[3].childNodes.length >= 17) {
    $draftFilmBtn.addClass('disable-click');
  } else {
    $draftFilmBtn.removeClass('disable-click');
  }
}