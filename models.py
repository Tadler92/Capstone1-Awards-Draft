from flask_sqlalchemy import SQLAlchemy
from flask_bcrypt import Bcrypt
from sqlalchemy import text
from sqlalchemy.orm import backref

bcrypt = Bcrypt()
db = SQLAlchemy()

def connect_db(app):
    db.app = app
    db.init_app(app)
    app.app_context().push()


class User(db.Model):
    __tablename__ = 'users'

    id = db.Column(db.Integer,
                   primary_key=True,
                   autoincrement=True)
    first_name = db.Column(db.String(25),
                           nullable=False)
    last_name = db.Column(db.String(25),
                          nullable=False)
    username = db.Column(db.String(15),
                         nullable=False,
                         unique=True)
    email = db.Column(db.Text,
                      nullable=False)
    password = db.Column(db.Text,
                         nullable=False)
    img_url = db.Column(db.Text,
                          nullable=False,
                          default='https://i.ibb.co/FxkBTLm/Empty-Profile-Pic.jpg')
    
    usergroups = db.relationship('GroupUser', backref='user', cascade='all, delete-orphan')

    # groups = db.relationship('Group', secondary='groups_users', backref='users', cascade='all, delete-orphan', single_parent=True)
    
    def __repr__(self):
        """Will represent the returned object as <User id=<id> first_name=<first_name> last_name=<last_name>>"""

        u = self
        return f"<User id={u.id} first_name={u.first_name} last_name={u.last_name}"
       
    def _get_full_name(self):
        """Returns the user's name as a full name (first and last name) in one string"""

        u = self
        return f'{u.first_name} {u.last_name}'
    
    full_name = property(
        fget=_get_full_name,
        doc="Returns the user's name as a full name (first and last name) in one string"
    )

    # def in_group(self, group):
    #     """Checks to see if user is in a group"""

    #     group_list = [group for group in self.groups]

    @classmethod
    def signup(cls, first, last, username, email, password, img):
        """Signs up a user and hashes their password before adding it to our system"""

        hashed_pwd = bcrypt.generate_password_hash(password).decode('UTF-8')

        user = User(
            first_name=first,
            last_name=last,
            username=username,
            email=email,
            password=hashed_pwd,
            img_url=img
        )

        db.session.add(user)
        return user
    
    @classmethod
    def authenticate(cls, username, password):
        """Find user with `username` and `password`.

        This is a class method (call it on the class, not an individual user.)
        It searches for a user whose password hash matches this password
        and, if it finds such a user, returns that user object.

        If can't find matching user (or if password is wrong), returns False.
        """

        user = cls.query.filter_by(username=username).first()

        if user:
            is_auth = bcrypt.check_password_hash(user.password, password)
            if is_auth:
                return user

        return False
    

class Group(db.Model):
    __tablename__ = 'groups'

    id = db.Column(db.Integer,
                   primary_key=True,
                   autoincrement=True)
    group_name = db.Column(db.String(20),
                           nullable=False,
                           unique=True)
    password = db.Column(db.Text
                         )
    is_private = db.Column(db.Boolean, 
                           nullable=False, 
                           default=False)
    
    # user_id = db.Column(db.Integer,
    #                     db.ForeignKey('users.id', ondelete='CASCADE'),
    #                     nullable=False
    #                     )
    
    usergroups = db.relationship('GroupUser', backref='group', cascade='all, delete-orphan')
    
    users = db.relationship('User', secondary='groups_users', backref='groups')

    def has_user(self, other_user):
        """Checks to see if a user is in this group"""

        found_user_list = [user for user in self.users if user == other_user]

        return len(found_user_list) == 1
    
    @classmethod
    def make_private(cls, group_name, password):
        """Makes a created group private and hashes the submitted password before adding it to our system"""

        hashed_pwd = bcrypt.generate_password_hash(password).decode('UTF-8')

        group = Group(
            group_name=group_name,
            password=hashed_pwd,
            is_private=True
        )
        # group.users.append(g.user)

        # db.session.add(group)
        return group
    
    @classmethod
    def join_private(cls, group_name, password):
        """Find a group with `group_name` and `password`.

        This is a class method (call it on the class, not an individual group.)
        It searches for a group whose password hash matches this password
        and, if it finds such a group, returns that group object.

        If can't find matching group (or if password is wrong), returns False.
        """

        group = cls.query.filter_by(group_name=group_name).first()

        if group:
            is_auth = bcrypt.check_password_hash(group.password, password)
            if is_auth:
                return group

        return False
    

class Year(db.Model):
    __tablename__ = 'years'

    id = db.Column(db.Integer,
                   primary_key=True,
                   autoincrement=True)
    curr_year = db.Column(db.Integer)


class Film(db.Model):
    __tablename__ = 'films'

    id = db.Column(db.Integer,
                   primary_key=True,
                   autoincrement=True)
    title = db.Column(db.Text,
                      nullable=False)
    year_id = db.Column(db.Integer,
                        db.ForeignKey('groups.id', ondelete='SET NULL'))
    
    filmnoms = db.relationship('FilmNom', backref='nominated_film')
    filmwins = db.relationship('FilmWin', backref='winning_film')

    groupuserfilms = db.relationship('GroupUserFilm', backref='chosen_film')

    def __repr__(self):
        """Will represent the returned object as <User id=<id> title=<title> year=<year>>"""

        u = self
        return f"<Film id={u.id} title={u.title} year={u.year}"
    

    def _total_points(self):
        """Returns the total sum of all points a film receives"""

        pts_lst = []
        total = 0

        for nompt in self.nom_points:
            pts_lst.append(nompt.points)

        print(pts_lst)
        for point in pts_lst:
            total += point

        return total
    
    total_points = property(
        fget=_total_points,
        doc="Returns the total sum of all points a film receives"
    )

    

class AwardShow(db.Model):
    __tablename__ = 'award_shows'

    id = db.Column(db.Integer,
                   primary_key=True,
                   autoincrement=True)
    show_name = db.Column(db.Text,
                      nullable=False)
    
    showcategories = db.relationship('CategoryShow', backref='award_show')
    
    categories = db.relationship('Category', secondary='categories_shows', backref='award_shows')
    

class Category(db.Model):
    __tablename__ = 'categories'

    id = db.Column(db.Integer,
                   primary_key=True,
                   autoincrement=True)
    category_name = db.Column(db.Text,
                      nullable=False)
    
    showcategories = db.relationship('CategoryShow', backref='category')

    

class GroupUser(db.Model):
    """Maps a group with a user
    
    (group_id=Integer, user_id=Integer, is_admin=Boolean[Default=False])"""

    __tablename__ = 'groups_users'

    id = db.Column(db.Integer, primary_key=True, autoincrement=True)

    group_id = db.Column(db.Integer, db.ForeignKey('groups.id', ondelete='cascade'), primary_key=True, nullable=False)

    user_id = db.Column(db.Integer, db.ForeignKey('users.id', ondelete='cascade'), primary_key=True, nullable=False)

    is_admin = db.Column(db.Boolean, nullable=False, default=False)

    groupuserfilms = db.relationship('GroupUserFilm', backref='group_user')
    
    films = db.relationship('Film', secondary='group_users_films', backref='groups_users')


class CategoryShow(db.Model):
    """Maps an award show with a category"""

    __tablename__ = 'categories_shows'

    id = db.Column(db.Integer, primary_key=True, autoincrement=True)

    category_id = db.Column(db.Integer, db.ForeignKey('categories.id', ondelete='CASCADE'), primary_key=True, nullable=False)

    award_show_id = db.Column(db.Integer, db.ForeignKey('award_shows.id', ondelete='CASCADE'), primary_key=True, nullable=False)

    nompoints = db.relationship('NomPoint', backref='nomed_category_show')
    winpoints = db.relationship('WinPoint', backref='won_category_show')


class NomPoint(db.Model):
    """Maps a category with nom points"""

    __tablename__ = 'nom_points'

    id = db.Column(db.Integer, primary_key=True, autoincrement=True)

    category_show_id = db.Column(db.Integer, db.ForeignKey('categories_shows.id', ondelete='CASCADE'), primary_key=True, nullable=False)

    points = db.Column(db.Integer, nullable=False)

    filmnoms = db.relationship('FilmNom', backref='nom_point')
    
    films = db.relationship('Film', secondary='films_noms', backref='nom_points')


class WinPoint(db.Model):
    """Maps a category with win points"""

    __tablename__ = 'win_points'

    id = db.Column(db.Integer, primary_key=True, autoincrement=True)

    category_show_id = db.Column(db.Integer, db.ForeignKey('categories_shows.id', ondelete='CASCADE'), primary_key=True, nullable=False)

    points = db.Column(db.Integer, nullable=False)

    filmwins = db.relationship('FilmWin', backref='win_point')
    
    films = db.relationship('Film', secondary='films_wins', backref='win_points')


class FilmNom(db.Model):
    """Maps a film with a nomination"""

    __tablename__ = 'films_noms'

    id = db.Column(db.Integer, primary_key=True, autoincrement=True)

    film_id = db.Column(db.Integer, db.ForeignKey('films.id', ondelete='CASCADE'), primary_key=True, nullable=False)

    nom_points_id = db.Column(db.Integer, db.ForeignKey('nom_points.id', ondelete='CASCADE'), primary_key=True, nullable=False)

    def __repr__(self):
        """Will represent the returned object as <User id=<id> title=<title> year=<year>>"""

        u = self
        return f"<FilmNom id={u.id} film_id={u.film_id} nom_points_id={u.nom_points_id}"


class FilmWin(db.Model):
    """Maps a film with a win"""

    __tablename__ = 'films_wins'

    id = db.Column(db.Integer, primary_key=True, autoincrement=True)

    film_id = db.Column(db.Integer, db.ForeignKey('films.id', ondelete='CASCADE'), primary_key=True, nullable=False)

    win_points_id = db.Column(db.Integer, db.ForeignKey('win_points.id', ondelete='CASCADE'), primary_key=True, nullable=False)


class GroupUserFilm(db.Model):
    """Maps a film with a user in a group"""

    __tablename__ = 'group_users_films'

    id = db.Column(db.Integer, primary_key=True, autoincrement=True)

    group_user_id = db.Column(db.Integer, db.ForeignKey('groups_users.id', ondelete='CASCADE'), primary_key=True, nullable=False)

    film_id = db.Column(db.Integer, db.ForeignKey('films.id', ondelete='CASCADE'), primary_key=True, nullable=False)