from flask import session
from secret import CURR_USER_KEY

# import itertools

def login_session(user):
    """When user logs in, adds their id to session."""

    session[CURR_USER_KEY] = user.id


def logout_session():
    """When user logs out, removes their id from session."""

    if CURR_USER_KEY in session:
        del session[CURR_USER_KEY]


def award_show_category_list(film):
    """Function that takes a film as a parameter, then returns a dictionary that shows the Award shows and Categories that a film has"""

    award_shows = []
    categories = []

    for cat_show in film.category_show_points:
        if cat_show.nom_or_win == 'nom':
            award_shows.append(cat_show.showyear.award_show.show_name)

            categories.append(cat_show.category.category_name)

    print(award_shows)
    print(categories)

    awards_categories = [(award_shows[i], categories[i]) for i in range(0, len(award_shows))]

    award_cat_dict = {k: [v for k1, v in awards_categories if k1 == k] for k, v in awards_categories}

    return award_cat_dict


def film_in_group_lst(group):
    """Function that takes in a group and returns a list of all the films that are drafted in that group"""

    film_lst = []

    for ug in group.usergroups:
        for film in ug.films:
            film_lst.append(film.id)

    return film_lst



def merge_choices(choices):
    """Function that turns information gotten from a db into a list of tuples with those choices"""

    ids = [0]
    titles = ['-- Choose an option --']
    for choice in choices:
        ids.append(choice[0])
        titles.append(choice[1])

    merged_choices = [(ids[i], titles[i]) for i in range(0, len(ids))]

    return merged_choices



# def user_film_dict(group):
#     """Function that takes a group as a parameter, then returns a dictionary that shows the films that a user has"""

#     users = []
#     films = []

#     for groupuser in group.usergroups:
#         award_shows.append(nomination.nomed_category_show.award_show.show_name)

#         categories.append(nomination.nomed_category_show.category.category_name)
#     # for nomination in film.nom_points:
#     #     award_shows.append(nomination.nomed_category_show.award_show.show_name)

#     #     categories.append(nomination.nomed_category_show.category.category_name)

#     print(award_shows)
#     print(categories)

#     awards_categories = [(award_shows[i], categories[i]) for i in range(0, len(award_shows))]

#     award_cat_dict = {k: [v for k1, v in awards_categories if k1 == k] for k, v in awards_categories}

#     return award_cat_dict