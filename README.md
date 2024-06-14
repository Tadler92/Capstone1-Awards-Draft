# README:

The title of my application is simply called `The Movie Awards Draft`. Click here to view the site: `https://awards-draft.onrender.com`.

### Description:

This website allows users to make and/or join groups to compete with other users by drafting films they think will get lots of awards nominations and wins. The more wins and nominations a film receives at various award shows, the more points given to the film and subsequently to the user who drafted the film in the group.

### Implemented Features:

- **Responsive page design** ~ I made sure to give my website a responsive design that way a user could visit the site on either a computer with a large screen or on a device with a smaller screen (like a tablet or cell phone) and it would look good and presentable to them.

- **Web security** ~ Only users with accounts can draft films on this site, so to protect a users profile information, I made sure to add a level of security to it. I also made it possible for users to make groups they create "private" with the addition of a password that is needed to join (since some people might just want to create a group to draft films by themselves, or have only their specific friends join the group).

- **About Page** ~ Knowing that many users likely wouldn't know what exactly this site is or how points and film drafting would work, I created an "About Page" and "How to Play" page to help explain things to a user. There is also an "explainer" card that pops up when a user joins/creates a group for the first time.

- **Easy Navigation** ~ I made sure to make navigating through the site as easy and "self-explanitory" as possible. I have a navbar with links to various pages on the site, as well as links throughout the site to different pages (for example: links to the groups a user is in appear in the user's profile page, and links to a user's profile will appear in group pages).

- **User-friendly Forms** ~ Like with navigating through the site, I wanted to make the forms as easy to fill out as possible, so each form (whether it's for signing up, logging in, creating a group, or selecting a film to draft) has labels that correspond to inputs, telling the users what information they need to input or select before submitting the form, and if invalid information is submitted, the form lets the user know so they can try again.

- **Accessibility** ~ Not wanting to leave anyone out from being able to participate in the fun of this entertaining little draft competition, I made sure to add as much accessibility into my code as possible; from having alt-text for images to linking a label to a corresponding input.

- \*Future Feature ~ in the process of setting up a search feature so that a user can search for a specific group to join (or just check if the group name already exists), rather than needing to scroll through all of the listed groups on the group page.

### Walk Through Site Use:

When a user comes to the website's Home page, they'll have 2 options, to either "Sign Up" or "Log In". If it's the user's first time on the site, they'll need to sign up.

_Signing Up_ ~

- After a user signs up, they'll be directed to the "How to Play" page, which will explain to them exactly how to draft films and compete with others; it will also give them a suggestion on how to draft films in their group (meaning the draft order), but in reality, they can draft films however they like (taking turns, one person drafting all their films at once, etc.).

- In the explanation of how to do things, there will be links that will direct a user to the groups page (both to look for groups to join, or to take them directly to creating their own group), as well as links taking them to their profile page. They can also get to any of those pages using links that are in the navbar.

_Logging In_ ~

- After a user logs in, they'll be taken directly to their profile page with a "Welcome Back" message. From here, they have lots of options from editing their profile if they so wish, to navigating to the groups they are already in (if they are already in groups) to check their progress, or they can navigate to the groups page to join more groups. They can also delete their profile from here if they so wish.

Once the user has navigated to the Groups page (no matter what path they took to reach it), they'll see a list of all the groups on the site; from that list, they can click on a group's name to navigate to the group's page (currently working on a feature to include a search feature so that users can search for specific groups/names rather than needing to scroll to find the group they want). A user can also click a button to create their own group.

_Creating a Group_ ~

- If a user decides they want to create their own group, they'll be directed to a page with the form to fill out an create the group. The most necessary information they'll need to provide is the group name, but they can also enter 2 option input information:

  - Group Profile Picture ~ this will be a select field with 4 possible options. If no option is selected, the group will automatically be given the first profile picture option.

  - Group Password ~ if a user wants to make the group they are creating "private", so that no one or only people they want to join can join, then they can type a password into the password field. If they provide a password, then anyone who wants to join the group will have to enter the same password before being added to that group.

- Upon submitting the "Create Group" form, the user will be redirected to the created group's page.

On a specific group's page, a user will see the group's chosen picture, the list of members and their drafted films (if they selected any films) along with the points each film has, a bar graph showing a visual of which user has the most points total in the group, and a button to join the group.

When the user clicks the "Join Group" button, if it is a private group, they'll need to enter the correct password to join, if it's a public group, they'll be automatically added to the group. Once added, the user will see a card pop up that explains how to go about drafting a film, and when they are done reading the explainer, they can click to close the card and click the draft button next to their name to draft a film.

_Drafting a Film_ ~

- When the user clicks the "Draft Film" button, they'll be redirected to the draft film page which has a simple select field with all the options of films to draft that correspond to the current Awards Season (meaning, only films released in 2023 will appear in 2024 because only 2023 films are eligible for the 2024 awards shows). The user can select any film that they see in the drop down options.

- If a user in the group has already selected a film the user wants to draft, the film will not appear in the select options (example: if the user wants to select _Barbie_, but someone in the group already drafted that film, the user will not see _Barbie_ in their selectable options). Once the user has selected the film they want to draft, they can click the draft button and they'll be redirected back to their group page and the drafted film will no longer be selectable by any other member.

Back on the group page upon drafting a film, the user will see their drafted film listed under their name along with any points it has received; if the film does have points, they'll also see a bar on the graph with their name next to it showing how many points total they have and how they rank compared to others in the group. If the user no longer wants the film they drafted for some reason, then they can click the "Remove Film" button next to the film they drafted, and that will make the film selectable for all members again; another way of making a user's drafted films selectable again, is for the user to click the "Leave Group" button, but doing so would also remove the user from the group.

Speaking of leaving groups, if the user is the creator of the group, he/she will see a "Remove User" button next to each member's name, so at any point that the creator/admin user wants, they can remove a user from the group. To know who the group creator/admin is, all users will see "Admin" next to the creator's name.

Now, if a user wants to view specific information about the points a film has, they can click the name of the film, and they will be directed to that film's page.

On a specific film's page, the user will see the film's title, rating, and poster. Under the poster, will be a table listing all the Awards shows the film was nominated at (that this website tracks specifically), as well as the category(s) it was nominated in and the amount of points it's receiving for a nomination and win. If the film wasn't nominated for at any of the tracked Awards shows, then it will have an empty table with no points.

In order to go back to any of the previous pages that the user was on before, they can click the links in the navbar (which will direct them to Home, Groups, or Profile pages).

Finally, at any point that the user wants, they can click the "Logout" button in the the navbar to log out of their profile, and upon doing so, they'll be asked if they're sure they want to log out, if yes, they'll be redirected to the login page.

### Link to API I am using for this Project:

- `https://www.omdbapi.com/`
- Some notes about using this api ~
  This API is specifically giving me information on the individual film pages (i.e.: Poster, Title, Rating), that's really all I'm currently using it for, but when I implement my way of adding new films to my database, I'll be using an API similar to this that will allow me to make searches based off of years; the only reason I didn't use that API to begin with is because it cost money to use.

  For all of my Awards shows and points data, that was essentially my own personally created "API" (I put it in quotes because it's just the data I put into my database, but I'm currently working on separating it out to make my own actually API for that information that I can make calls to).

### Technology Stack Used to Create Site:

This website uses the following stack ~

- Python (main programming language of site)
- HTML
- CSS/Bootstrap
- Font Awesome
- JavaScript (language used to create graph on group pages)
- Jinja (used to help set up HTML templates)
- Flask (server)
- SQLAlchemy (used through flask to connect to database)
- WTForms (used through flask to make forms more easily written)
- Bcrypt
- PostgreSQL (database)

### Additional Information:

As mentioned above, I'm in the process of adding a "Search Groups" feature to the site so that users can find groups more easily on the Groups page.

I'm also looking at implementing a way of adding the next year's batch of eligible films to my database through the use of a one click button, so that I won't have to type each new film into the database by hand and making the route to that button/form protected so that only me or someone that might join my "team" can access it.

Finally, the project I'm currently working to implement and get set up on the site is a way of getting drafted films to appear immediately on the page without need to refresh the page.
