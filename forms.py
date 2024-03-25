from flask_wtf import FlaskForm
from wtforms import StringField, PasswordField
from wtforms.validators import InputRequired, DataRequired, Email, Length

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