let $winsCell = $('.wins-cell');

for (let cell of $winsCell) {
  if (cell.innerText === '') {
    // console.log(cell, 'Should be 0');
    cell.innerText = '0'
  }
}