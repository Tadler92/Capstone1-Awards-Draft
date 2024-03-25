from flask import session
from secret import CURR_USER_KEY

def login_session(user):
    """When user logs in, adds their id to session."""

    session[CURR_USER_KEY] = user.id


def logout_session():
    """When user logs out, removes their id from session."""

    if CURR_USER_KEY in session:
        del session[CURR_USER_KEY]