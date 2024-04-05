const baseURL = 'http://localhost:5000';

let $winsCell = $('.wins-cell');

for (let cell of $winsCell) {
  if (cell.innerText === '') {
    // console.log(cell, 'Should be 0');
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

// $logoutBtn.on('click', async function logout(e) {
//   e.preventDefault()
//   await axios.post(`${baseURL}/logout`);
// });

// $joinGroupBtn.on('click', async function (e) {
//   e.preventDefault();

//   let $joiner = $(e.target).closest('button');
//   console.log($joiner);
//   console.log($joiner.attr('data-group_id'));
//   console.log($joiner.attr('data-user_id'));

//   let groupID = $joiner.attr('data-group_id');
//   let userID = $joiner.attr('data-user_id');

//   await axios.post(`${baseURL}/groups/${groupID}/join-group`)
// });
// $leaveGroupBtn.on('click', async function (e) {
//   e.preventDefault();

//   let $leaver = $(e.target).closest('button');

//   let groupID = $leaver.attr('data-group_id');
//   let userID = $leaver.attr('data-user_id');
//   let $user = $(`#user-${userID}`);

//   await axios.post(`${baseURL}/groups/${groupID}/users/${userID}/leave-group`);

//   $user.remove();
// });
// $removeFilmBtn.on('click', async function (e) {
//   e.preventDefault();
//   let $film = $(e.target).closest('tr');
//   console.log("Here's the film ->", $film);
//   console.log("Film attributes ->", $film[0].attributes);
//   console.log("Film data ->", $film[0].attributes[1]);
//   console.log("Film id ->", $film[0].attributes[1].value);
//   console.log("Film id ->", $film.attr('data-film_id'));
//   console.log("Groupuser id ->", $film.attr('data-groupuser_id'));

//   let filmID = $film.attr('data-film_id');
//   let guID = $film.attr('data-groupuser_id');

//   await axios.post(`${baseURL}/groupusers/${guID}/films/${filmID}/undraft`);
//   $film.remove();
// });

// function createUserHTML(user) {
//   let html = `
//   <div data-user_id=${user.id}>
//     <li>
//       ${user.username} - ${user.first_name} - ${user.last_name}
//       <button class="delete-button">X</button>
//     </li>
//     <img class="user-img" src="${user.img_url}" alt="${user.username} cupcake">
//   </div>`;

//   return html;
// }



// async function showMembers() {
//   const resp = await axios.get(`${baseURL}/api`);
//   console.log(resp);
//   console.log(resp.data);
//   console.log(resp.data.groups);
//   // console.log(resp.data.group.users);

//   // for (let user of resp.data.groups) {
//   //   let apiUser = $(createUserHTML(user));
//   //   $('#user-list').append(apiUser);
//   // }
// };




// $(showMembers);