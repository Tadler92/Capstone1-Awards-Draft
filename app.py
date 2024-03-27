from flask import Flask, request, render_template, redirect, flash, session, jsonify, g
from flask_debugtoolbar import DebugToolbarExtension
from sqlalchemy.exc import IntegrityError, PendingRollbackError

from models import db, connect_db, text, User, Group, Film, AwardShow, Category, GroupUser, GroupUserFilm
from forms import AddUserForm, LoginForm, GroupForm, PrivateGroupForm, DraftFilmInGroupForm
from secret import api_key, CURR_USER_KEY
from funcs import login_session, logout_session, award_show_category_list, film_in_group_lst

import requests
import json
# from funcs import add_tags_to_db, add_tags_to_lst, tag_lst, lst_to_str


app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql:///awards_draft'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
app.config['SQLALCHEMY_ECHO'] = True

app.config['SECRET_KEY'] = "chickenzarecool21837"
app.config['DEBUG_TB_INTERCEPT_REDIRECTS'] = False
debug = DebugToolbarExtension(app)

connect_db(app)
# db.create_all()



######################################################################
# Signup, Login, and Logout routes:


@app.before_request
def add_user_to_g():
    """If logged in, add current user to Flask global."""

    if CURR_USER_KEY in session:
        g.user = User.query.get(session[CURR_USER_KEY])


@app.route('/')
def homepage():
    """Shows homepage (which will have a list of groups)"""

    groups = Group.query.all()

    return render_template('index.html', groups=groups)


@app.route('/signup', methods=['GET', 'POST'])
def signup():
    """Shows signup form and signs up a user.
    
    Will add user to DB. Redirects to ______.
    
    Presents form if form not valid.
    
    If a user already has a username in the DB, we'll flash a message and re-present the form"""

    form = AddUserForm()

    if form.validate_on_submit():
        try:
            user = User.signup(
                first=form.first_name.data,
                last=form.last_name.data,
                username=form.username.data,
                email=form.email.data,
                password=form.password.data,
                img=form.img_url.data or User.img_url.default.arg
            )
            db.session.commit()

        except IntegrityError:
            flash('Username already taken', 'danger')
            return render_template('signup.html', form=form)
        
        login_session(user)
        
        flash('Thank you for your interest and for signing up!', 'success')
        return redirect('/how-to-play')  # complete this route!
    
    else:
        return render_template('signup.html', form=form)
    

@app.route('/login', methods=['GET', 'POST'])
def login():
    """Logs in a user."""

    form = LoginForm()

    if form.validate_on_submit():
        user = User.authenticate(form.username.data,
                                 form.password.data)
        
        if user:
            login_session(user)
            flash(f'Welcome Back, {user.username}!', 'success')
            return redirect(f'users/{user.id}')
        
        flash('Username or Password incorrect. Please try again.', 'danger')

    return render_template('login.html', form=form)


@app.route('/logout')
def logout():
    """Logs out a user."""

    logout_session()

    flash('You have successfully logged out!', 'success')
    return redirect('/login')




######################################################################
# User routes:



@app.route('/users/<int:user_id>')
def show_user_info(user_id):
    """Shows info for a specific user such as:
    
    1) name
    2) username
    3) drafted films
    4) groups
    
    """

    user = User.query.get_or_404(user_id)

    return render_template('user_info.html', user=user)


@app.route('/users/delete', methods=['POST'])
def delete_user():
    """Deletes a user"""

    if not g.user:
        flash('Unauthorized Action!', 'danger')
        return redirect('/')
    
    logout_session()

    db.session.delete(g.user)
    db.session.commit()

    flash('Successfully deleted profile', 'info')
    return redirect('/signup')





######################################################################
# Group routes:


@app.route('/groups/add', methods=['GET', 'POST'])
def create_new_group():
    """Shows a form for a user to create a new group"""

    form = GroupForm()

    if form.validate_on_submit():
        group_name = form.group_name.data,
        password = form.password.data

        if password:
            try:
                group = Group.make_private(
                    group_name=group_name,
                    password=password
                )
                # group.users.append(g.user)
                groupuser = GroupUser(group_id=group.id,
                                      user_id=g.user.id,
                                      is_admin=True)
                group.usergroups.append(groupuser)

                db.session.add(group, groupuser)
                db.session.commit()

            except IntegrityError:
                db.session.rollback()
                flash("Group name already taken", 'danger')
                return render_template('create_group.html', form=form)

        else:
            try:
                group = Group(group_name=group_name, password=None)
                # group.users.append(g.user)
                groupuser = GroupUser(group_id=group.id,
                                      user_id=g.user.id,
                                      is_admin=True)
                group.usergroups.append(groupuser)

                db.session.add(group, groupuser)
                db.session.commit()

            except IntegrityError:
                db.session.rollback()
                flash("Group name already taken", 'danger')
                return render_template('create_group.html', form=form)

        # db.session.add(group)
        # db.session.commit()

        flash(f'Successfully created group {group.group_name}!', 'success')
        return redirect(f'/groups/{group.id}')
    
    else:
        return render_template('create_group.html', form=form)


@app.route('/groups/<int:group_id>')
def show_group_info(group_id):
    """Shows info for a specific groups, such as:
    1) Group name
    2) users in group
    3) points users have
    4) films users drafted and the film's points
    
    """

    group = Group.query.get_or_404(group_id)

    return render_template('group_info.html', group=group)


@app.route('/groups/join-group/<int:group_id>', methods=['POST'])
def join_group(group_id):
    """Adds the currently logged in user to a group"""

    if not g.user:
        flash('Must be logged in first!', 'danger')
        return redirect('/login')
    
    group = Group.query.get_or_404(group_id)

    if group.is_private:
        return redirect(f'/groups/join-private/{group.id}')

    else:
        if len(group.users) >= 8:
            flash('Sorry, this group is full.', 'warning')
            return redirect('/groups')
        
        else:
            group.users.append(g.user)    
            db.session.commit()

        return redirect(f'/groups/{group.id}')
    

@app.route('/groups/join-private/<int:group_id>', methods=['GET', 'POST'])
def private_auth_form(group_id):
    """Adds a currently logged in user to a private group"""

    if not g.user:
        flash('Must be logged in first!', 'danger')
        return redirect('/login')
    
    group = Group.query.get_or_404(group_id)

    form = PrivateGroupForm()

    if form.validate_on_submit():
        pgroup = Group.join_private(group.group_name, form.password.data)

        if pgroup:
            if len(group.users) >= 8:
                flash('Sorry, this group is full.', 'warning')
                return redirect('/groups')
        
            else:
                group.users.append(g.user)    
                db.session.commit()

            return redirect(f'/groups/{group.id}')
        
        flash('Incorrect Password. Please try again.', 'danger')

    return render_template('private_group_form.html', form=form)

    form = LoginForm()

    if form.validate_on_submit():
        user = User.authenticate(form.username.data,
                                 form.password.data)
        
        if user:
            login_session(user)
            flash(f'Welcome Back, {user.username}!', 'success')
            return redirect(f'users/{user.id}')
        
        flash('Username or Password incorrect. Please try again.', 'danger')

    return render_template('login.html', form=form)


@app.route('/groups/leave-group/<int:group_id>', methods=['POST'])
def leave_group(group_id):
    """Removes the currently logged in user from a group"""

    if not g.user:
        flash('Must be logged in first!', 'danger')
        return redirect('/login')
    
    group = Group.query.get_or_404(group_id)
    group.users.remove(g.user)    
    db.session.commit()

    return redirect(f'/groups/{group.id}')


@app.route('/groups/delete/<int:group_id>', methods=['POST'])
def delete_group(group_id):
    """Deletes a user"""

    if not g.user:
        flash('Unauthorized Action!', 'danger')
        return redirect('/')
    
    group = Group.query.get_or_404(group_id)
    
    db.session.delete(group)
    db.session.commit()

    flash('Successfully deleted profile', 'info')
    return redirect('/')





######################################################################
# Film routes:



@app.route('/films/<int:film_id>')
def show_film_info(film_id):
    """Shows info for a specific film"""

    film = Film.query.get_or_404(film_id)
    # award_shows = AwardShow.query.all()
    awards_dict = award_show_category_list(film)
    print('********', awards_dict, '*********')
    

    resp = requests.get(f'http://www.omdbapi.com?apikey={api_key}&t={film.title}')

    # print('********', resp, '*********')

    omdb_dict = json.loads(resp.text)
    # print('********', omdb_dict, '*********')
    # print('********', omdb_dict['Title'], '*********')

    title = omdb_dict['Title']
    rating = omdb_dict['Rated']
    poster_url = omdb_dict['Poster']

    return render_template ('film.html', title=title, rating=rating, poster=poster_url, film=film, award_shows=awards_dict)


@app.route('/<int:groupuser_id>/films/draft', methods=['GET', 'POST'])
def draft_film(groupuser_id):
    """Route that will actually allow a user to draft a film once they are in a group"""

    # group = Group.query.get_or_404(gu.group_id)
    gu = db.session.query(GroupUser).filter(GroupUser.id == groupuser_id).first()
    group = Group.query.get_or_404(gu.group_id)
    form = DraftFilmInGroupForm()

    curr_in_group = film_in_group_lst(group)
    choices = (db.session.query(Film.id, Film.title).filter(Film.id.notin_(curr_in_group)).all())
    ids = [0]
    titles = ['-- Choose a film --']
    for choice in choices:
        ids.append(choice[0])
        titles.append(choice[1])

    merged_choices = [(ids[i], titles[i]) for i in range(0, len(ids))]

    form.film.choices = merged_choices

    if form.validate_on_submit():
        groupuser_film = GroupUserFilm(group_user_id=groupuser_id,
                                       film_id=form.film.data)
        
        db.session.add(groupuser_film)
        db.session.commit()

        return redirect(f'/groups/{group.id}')
    
    return render_template('draft_film.html', form=form, group=group, gu=gu)





######################################################################
# Homepage and error page routes:


@app.route('/how-to-play')
def how_to_play():
    """Shows page to explain how to use application after a user signs up"""

    return render_template('how_to.html')





######################################################################
# Turning off caching in Flask:


@app.after_request
def add_header(req):
    """Add non-caching headers on every request."""

    req.headers["Cache-Control"] = "no-cache, no-store, must-revalidate"
    req.headers["Pragma"] = "no-cache"
    req.headers["Expires"] = "0"
    req.headers['Cache-Control'] = 'public, max-age=0'
    return req