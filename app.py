from flask import Flask, request, render_template, redirect, flash, session, jsonify, g
from flask_debugtoolbar import DebugToolbarExtension
from sqlalchemy.exc import IntegrityError

from models import db, connect_db, text, User, Group, Film, AwardShow, Category, GroupUser
from forms import AddUserForm, LoginForm
from secret import api_key, CURR_USER_KEY
from funcs import login_session, logout_session

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





######################################################################
# Group routes:




######################################################################
# Film routes:



@app.route('/films/<int:film_id>')
def show_film_info(film_id):
    """Shows info for a specific film"""

    film = Film.query.get_or_404(film_id)
    award_shows = AwardShow.query.all()

    resp = requests.get(f'http://www.omdbapi.com?apikey={api_key}&t={film.title}')

    # print('********', resp, '*********')

    omdb_dict = json.loads(resp.text)
    # print('********', omdb_dict, '*********')
    # print('********', omdb_dict['Title'], '*********')

    title = omdb_dict['Title']
    rating = omdb_dict['Rated']
    poster_url = omdb_dict['Poster']

    return render_template ('film.html', title=title, rating=rating, poster=poster_url, film=film, award_shows=award_shows)





######################################################################
# Homepage and error page routes:




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