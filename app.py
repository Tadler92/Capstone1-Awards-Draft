import os
from flask import Flask, request, render_template, redirect, flash, session, jsonify, g, url_for
from flask_debugtoolbar import DebugToolbarExtension
from sqlalchemy.exc import IntegrityError, PendingRollbackError
from flask_cors import CORS

from models import db, connect_db, text, User, Group, Film, AwardShow, Category, GroupUser, GroupUserFilm, Year, ShowYear, CategoryShowPoint, Image
from forms import AddUserForm, LoginForm, GroupForm, PrivateGroupForm, DraftFilmInGroupForm, EditProfileForm, EditGroupForm
from secret import api_key, CURR_USER_KEY
from funcs import login_session, logout_session, award_show_category_list, film_in_group_lst, merge_choices

# from werkzeug.utils import secure_filename
# from flask_uploads import configure_uploads, IMAGES, UploadSet

import requests
import json
# from funcs import add_tags_to_db, add_tags_to_lst, tag_lst, lst_to_str
UPLOAD_FOLDER = '/static/photos'
ALLOWED_EXTENSIONS = {'png', 'jpg', 'jpeg'}


app = Flask(__name__)
CORS(app)
app.config['SQLALCHEMY_DATABASE_URI'] = (
    os.environ.get('DATABASE_URL', 'postgresql:///awards_draft'))
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
app.config['SQLALCHEMY_ECHO'] = True
app.config['SEND_FILE_MAX_AGE_DEFAULT'] = 0

# app.config['ACCESS-CONTROL-ALLOW'] = True
# app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER
# images = UploadSet('images', IMAGES)
# configure_uploads(app, images)

app.config['SECRET_KEY'] = "chickenzarecool21837"
# app.config['DEBUG_TB_INTERCEPT_REDIRECTS'] = False
# debug = DebugToolbarExtension(app)

connect_db(app)
# db.create_all()
yr = Year.query.order_by(Year.curr_year.desc()).first()  # gives us 2024
prev_yr = yr.curr_year - 1  # gives us 2023


@app.context_processor
def override_url_for():
    return dict(url_for=dated_url_for)

def dated_url_for(endpoint, **values):
    if endpoint == 'static':
        filename = values.values.get('filename', None)
        if filename:
            file_path = os.path.join(app.root_path, endpoint, filename)
            values['q'] = int(os.stat(file_path).st_mtime)

    return url_for(endpoint, **values)



######################################################################
# Signup, Login, and Logout routes:


@app.before_request
def add_user_to_g():
    """If logged in, add current user to Flask global."""

    if CURR_USER_KEY in session:
        g.user = User.query.get(session[CURR_USER_KEY])
        # print('*************Request', request.endpoint)

    else:
        g.user = None

    # elif request.endpoint != 'login':
    # elif request.endpoint not in ['login', 'signup', 'homepage', 'how-to-play']:
    #     print('*************Request', request.endpoint)
    #     flash('Must be logged in first!', 'danger')
    #     return redirect(url_for('login'))

    db.session.rollback()


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
        return redirect(url_for('how_to_play'))  # complete this route!
    
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
            return redirect(url_for('show_user_info', user_id=user.id))
        
        flash('Username or Password incorrect. Please try again.', 'danger')

    return render_template('login.html', form=form)


@app.route('/logout')
def logout():
    """Logs out a user."""

    # logout_session()

    # flash('You have successfully logged out!', 'success')
    return render_template('logout_form.html')
    # return redirect(url_for('logout_user'))




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
    # if CURR_USER_KEY not in session:
    #     flash('Must be logged in first!', 'danger')
    #     return redirect(url_for('login'))


    user = User.query.get_or_404(user_id)

    return render_template('user_info.html', user=user)


@app.route('/users/edit-profile', methods=['GET', 'POST'])
def edit_profile():
    """Allows current user to edit their profile"""

    if not g.user:
        flash('Unauthorized Action!', 'danger')
        return redirect(url_for('homepage'))
    
    user = g.user
    form = EditProfileForm(obj=user)

    if form.validate_on_submit():
    
        # print(form.img_url.data)
        # filename = images.save(form.img_url.data)
        # print(f'Filename: {filename}')
        
        try:
            user.first_name = form.first_name.data
            user.last_name = form.last_name.data
            user.username = form.username.data
            user.email = form.email.data
            user.img_url = form.img_url.data

            db.session.commit()


            flash('Profile successfully edited!', 'success')
            return redirect(url_for('show_user_info', user_id=user.id))
        
        except IntegrityError:
            db.session.rollback()
            flash('Username already taken', 'danger')
            return render_template('edit_user_info.html', form=form, user_id=user.id)
    
    return render_template('edit_user_info.html', form=form, user_id=user.id)


@app.route('/users/logout', methods=['POST'])
def logout_user():
    """Logs a user out; making the logout a post route instead of a normal get route based on what some have said is a better way of doing things..."""

    if not g.user:
        flash('Unauthorized Action!', 'danger')
        return redirect(url_for('homepage'))

    logout_session()

    flash('You have successfully logged out!', 'success')
    return redirect(url_for('login'))


@app.route('/users/delete', methods=['POST'])
def delete_user():
    """Deletes a user"""

    if not g.user:
        flash('Unauthorized Action!', 'danger')
        return redirect(url_for('homepage'))
    
    user = User.query.get_or_404(g.user.id)
    for ug in user.usergroups:
        if ug.is_admin:
            db.session.delete(Group.query.get_or_404(ug.group_id))
    
    logout_session()

    db.session.delete(g.user)
    db.session.commit()

    flash('Successfully deleted profile', 'info')
    return redirect(url_for('signup'))





######################################################################
# Group routes:


@app.route('/groups')
def show_groups():
    """Shows a list of groups on the page"""

    groups = Group.query.all()

    return render_template('groups.html', groups=groups)


@app.route('/groups/add', methods=['GET', 'POST'])
def create_new_group():
    """Shows a form for a user to create a new group"""

    if CURR_USER_KEY not in session:
        flash('Must be logged in first!', 'danger')
        return redirect(url_for('login'))

    form = GroupForm()

    choices = db.session.query(Image.id, Image.image).all()
    
    form.image_id.choices = merge_choices(choices)

    if form.validate_on_submit():
        group_name = form.group_name.data,
        password = form.password.data
        image_id = form.image_id.data
        if image_id == 0:
            image_id += 1

        if password:
            try:
                group = Group.make_private(
                    group_name=group_name,
                    password=password,
                    image_id=image_id
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
                group = Group(group_name=group_name, password=None, image_id=image_id)
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
        return redirect(url_for('show_group_info', group_id=group.id))
    
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


@app.route('/groups/<int:group_id>/join-group', methods=['POST'])
def join_group(group_id):
    """Adds the currently logged in user to a group"""

    if not g.user:
        flash('Must be logged in first!', 'danger')
        return redirect(url_for('login'))
    
    group = Group.query.get_or_404(group_id)

    if group.is_private:
        return redirect(url_for('private_auth_form', group_id=group.id))

    else:
        if len(group.users) >= 8:
            flash('Sorry, this group is full.', 'warning')
            return redirect(url_for('show_groups'))
        
        else:
            group.users.append(g.user)    
            db.session.commit()

        return redirect(url_for('show_group_info', group_id=group.id))
    

@app.route('/groups/<int:group_id>/join-private', methods=['GET', 'POST'])
def private_auth_form(group_id):
    """Adds a currently logged in user to a private group"""

    if not g.user:
        flash('Must be logged in first!', 'danger')
        return redirect(url_for('login'))
    
    group = Group.query.get_or_404(group_id)

    form = PrivateGroupForm()

    if form.validate_on_submit():
        pgroup = Group.join_private(group.group_name, form.password.data)

        if pgroup:
            if len(group.users) >= 8:
                flash('Sorry, this group is full.', 'warning')
                return redirect(url_for('show_groups'))
        
            else:
                group.users.append(g.user)    
                db.session.commit()

            return redirect(url_for('show_group_info', group_id=group.id))
        
        flash('Incorrect Password. Please try again.', 'danger')

    return render_template('private_group_form.html', form=form)


@app.route('/groups/<int:group_id>/users/<int:user_id>/leave-group', methods=['POST'])
def leave_group(group_id, user_id):
    """Removes the currently logged in user from a group"""

    if not g.user:
        flash('Must be logged in first!', 'danger')
        return redirect(url_for('login'))

    group = Group.query.get_or_404(group_id)
    
    if g.user.id == user_id:
        group.users.remove(g.user)    
        db.session.commit()
    else:
        user = User.query.get_or_404(user_id)
        group.users.remove(user)
        db.session.commit()

    print('********* REMOVED USER **********')
    return redirect(url_for('show_group_info', group_id=group.id))


@app.route('/groups/<int:group_id>/edit-group', methods=['GET', 'POST'])
def edit_group(group_id):
    """Allows the admin user to edit the group"""

    if not g.user:
        flash('Unauthorized Action!', 'danger')
        return redirect(url_for('homepage'))
    
    group = Group.query.get_or_404(group_id)
    form = EditGroupForm(obj=group)

    choices = db.session.query(Image.id, Image.image).all()
    
    form.image_id.choices = merge_choices(choices)

    if form.validate_on_submit():
        try:
            group.group_name = form.group_name.data
            group.image_id = form.image_id.data

            db.session.commit()

            flash('Profile successfully edited!', 'success')
            return redirect(url_for('show_group_info', group_id=group.id))
        
        except IntegrityError:
            db.session.rollback()
            flash('Username already taken', 'danger')
            return render_template('edit_group_info.html', form=form, group_id=group.id)
    
    return render_template('edit_group_info.html', form=form, group_id=group.id)


@app.route('/groups/<int:group_id>/delete', methods=['POST'])
def delete_group(group_id):
    """Deletes a user"""

    if not g.user:
        flash('Unauthorized Action!', 'danger')
        return redirect(url_for('homepage'))
    
    group = Group.query.get_or_404(group_id)
    
    db.session.delete(group)
    db.session.commit()

    flash('Successfully deleted group', 'info')
    return redirect(url_for('show_groups'))





######################################################################
# Film routes:



@app.route('/films/<int:film_id>')
def show_film_info(film_id):
    """Shows info for a specific film"""

    film = Film.query.get_or_404(film_id)
    # award_shows = AwardShow.query.all()
    awards_dict = award_show_category_list(film)
    print('********', awards_dict, '*********')
    

    resp = requests.get(f'http://www.omdbapi.com?apikey={api_key}&t={film.title}&y={film.year.curr_year}')

    # print('********', resp, '*********')

    omdb_dict = json.loads(resp.text)
    # print('********', omdb_dict, '*********')
    # print('********', omdb_dict['Title'], '*********')

    title = omdb_dict['Title']
    rating = omdb_dict['Rated']
    poster_url = omdb_dict['Poster']

    return render_template ('film.html', title=title, rating=rating, poster=poster_url, film=film, award_shows=awards_dict)


@app.route('/groupusers/<int:groupuser_id>/films/draft', methods=['GET', 'POST'])
def draft_film(groupuser_id):
    """Route that will actually allow a user to draft a film once they are in a group"""

    if CURR_USER_KEY not in session:
        flash('Must be logged in first!', 'danger')
        return redirect(url_for('login'))

    # group = Group.query.get_or_404(gu.group_id)
    gu = db.session.query(GroupUser).filter(GroupUser.id == groupuser_id).first()
    group = Group.query.get_or_404(gu.group_id)
    form = DraftFilmInGroupForm()

    curr_in_group = film_in_group_lst(group)
    choices = (db.session.query(Film.id, Film.title).filter(Film.id.notin_(curr_in_group), Film.year_id == (yr.id - 1)).all())
    
    form.film.choices = merge_choices(choices)

    if form.validate_on_submit():
        if form.film.data == 0:
            flash('Invalid Selection! Please choose film from below.', 'danger')
            return render_template('draft_film.html', form=form, group=group, gu=gu)
        else:
            groupuser_film = GroupUserFilm(group_user_id=groupuser_id,
                                        film_id=form.film.data)
            
            db.session.add(groupuser_film)
            db.session.commit()

            return redirect(url_for('show_group_info', group_id=group.id))
    
    return render_template('draft_film.html', form=form, group=group, gu=gu)


@app.route('/groupusers/<int:gu_id>/films/<int:film_id>/undraft', methods=['POST'])
def remove_drafted_film(gu_id, film_id):
    """Removes film that a user drafted from their list so they can draft another film"""

    if CURR_USER_KEY not in session:
        flash('Must be logged in first!', 'danger')
        return redirect(url_for('login'))

    groupuserfilm = db.session.query(GroupUserFilm).filter(GroupUserFilm.group_user_id == gu_id, GroupUserFilm.film_id == film_id).first()
    
    db.session.delete(groupuserfilm)
    db.session.commit()

    flash('Successfully removed film', 'info')
    return redirect(url_for('show_group_info', group_id=groupuserfilm.group_user.group_id)) 
    # return jsonify(message="Removed film") 
    # response = jsonify(message="Removed film") 
    # response.headers.add('Access-Control-Allow-Origin', '*')  
    # return response





######################################################################
# Homepage and error page routes:


@app.route('/')
def homepage():
    """Shows homepage that users can visit without having an account"""


    return render_template('index.html')


@app.route('/how-to-play')
def how_to_play():
    """Shows page to explain how to use application after a user signs up"""
    # if CURR_USER_KEY not in session:
    #     flash('Must be logged in first!', 'danger')
    #     return redirect(url_for('login'))

    return render_template('how_to.html')


@app.route('/about')
def about():
    """Shows the about page for the website"""

    return render_template('about.html')


@app.errorhandler(404)
def page_not_found(error):
        """Shows a unique 404 page"""
        return render_template('error404.html'), 404





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