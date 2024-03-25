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
    
    usergroups = db.relationship('GroupUser', backref='user')
    
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
    
    # user_id = db.Column(db.Integer,
    #                     db.ForeignKey('users.id', ondelete='CASCADE'),
    #                     nullable=False
    #                     )
    
    usergroups = db.relationship('GroupUser', backref='group')
    
    users = db.relationship('User', secondary='groups_users', backref='groups')


class Film(db.Model):
    __tablename__ = 'films'

    id = db.Column(db.Integer,
                   primary_key=True,
                   autoincrement=True)
    title = db.Column(db.Text,
                      nullable=False)
    year = db.Column(db.Integer,
                     nullable=False)
    

class AwardShow(db.Model):
    __tablename__ = 'award_shows'

    id = db.Column(db.Integer,
                   primary_key=True,
                   autoincrement=True)
    show_name = db.Column(db.Text,
                      nullable=False)
    

class Category(db.Model):
    __tablename__ = 'categories'

    id = db.Column(db.Integer,
                   primary_key=True,
                   autoincrement=True)
    category_name = db.Column(db.Text,
                      nullable=False)
    

class GroupUser(db.Model):
    """Maps a group with a user"""

    __tablename__ = 'groups_users'

    id = db.Column(db.Integer, primary_key=True, autoincrement=True)

    group_id = db.Column(db.Integer, db.ForeignKey('groups.id', ondelete='CASCADE'), primary_key=True, nullable=False)

    user_id = db.Column(db.Integer, db.ForeignKey('users.id', ondelete='CASCADE'), primary_key=True, nullable=False)