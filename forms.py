from flask_wtf import FlaskForm
from wtforms import StringField, PasswordField, SelectField, FileField, SubmitField
from wtforms.validators import InputRequired, DataRequired, Email, Length, Optional

class AddUserForm(FlaskForm):
    """Form for adding users."""

    first_name = StringField('First Name', validators=[InputRequired(), Length(max=25)])
    last_name = StringField('Last Name', validators=[InputRequired(), Length(max=25)])
    username = StringField('Username', validators=[InputRequired(), Length(max=15)])
    email = StringField('E-mail', validators=[InputRequired(), Email()])
    password = PasswordField('Password', validators=[InputRequired(), Length(min=6)])
    img_url = StringField('(Optional) Image URL')


class LoginForm(FlaskForm):
    """Form for users to login"""

    username = StringField('Username', validators=[DataRequired()])
    password = PasswordField('Password', validators=[Length(min=6)])


class GroupForm(FlaskForm):
    """Form for a user to create a group"""

    group_name = StringField('Group Name', validators=[InputRequired(), Length(max=20)])
    image_id = SelectField('Group Image', coerce=int)
    password = PasswordField('(Optional) Add a Password to Make Your Group Private', validators=[Optional(), Length(min=6)])
    


class PrivateGroupForm(FlaskForm):
    """Form to authenticate a user joining a private group"""

    password = PasswordField('Password', validators=[Length(min=6)])


class DraftFilmInGroupForm(FlaskForm):
    """Form for a user to draft a film once they are in a group"""

    film = SelectField('Film to Draft', coerce=int)


class EditProfileForm(FlaskForm):
    """Form for a user to edit their profile"""

    first_name = StringField('First Name', validators=[DataRequired(), Length(max=25)])
    last_name = StringField('Last Name', validators=[DataRequired(), Length(max=25)])
    username = StringField('Username', validators=[DataRequired(), Length(max=15)])
    email = StringField('E-mail', validators=[DataRequired(), Email()])
    img_url = StringField('(Optional) Image URL')
    # img_url = FileField('(Optional) Image')


class EditGroupForm(FlaskForm):
    """Form for admin user to edit their group"""

    group_name = StringField('Group Name', validators=[DataRequired(), Length(max=20)])
    image_id = SelectField('Group Image', coerce=int)


class LogoutForm(FlaskForm):
    """Form for user to logout"""

    button = SubmitField('Logout')