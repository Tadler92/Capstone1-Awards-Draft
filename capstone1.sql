DROP DATABASE IF EXISTS awards_draft;

CREATE DATABASE awards_draft;

\c awards_draft

-- Create tables
CREATE TABLE users
(
    id SERIAL PRIMARY KEY,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    username VARCHAR(15) NOT NULL UNIQUE,
    email TEXT NOT NULL,
    password TEXT NOT NULL,
    img_url TEXT DEFAULT 'https://photos.google.com/photo/AF1QipMFokgzHFd_LX1T6H1nhb0bH5wEH29fg2TVfONv'
);

CREATE TABLE groups
(
    id SERIAL PRIMARY KEY,
    group_name VARCHAR(20) NOT NULL UNIQUE,
    password TEXT DEFAULT NULL,
);

CREATE TABLE films
(
    id SERIAL PRIMARY KEY,
    title TEXT,
    year INTEGER
);

CREATE TABLE award_shows
(
    id SERIAL PRIMARY KEY,
    show_name TEXT NOT NULL
);

CREATE TABLE categories
(
    id SERIAL PRIMARY KEY,
    category_name TEXT
);

CREATE TABLE users_films
(
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users ON DELETE CASCADE,
    film_id INTEGER REFERENCES films ON DELETE CASCADE
);

CREATE TABLE groups_users
(
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES groups ON DELETE CASCADE,
    film_id INTEGER REFERENCES users ON DELETE CASCADE
);

CREATE TABLE categories_shows
(
    id SERIAL PRIMARY KEY,
    category_id INTEGER REFERENCES categories ON DELETE CASCADE,
    award_show_id INTEGER REFERENCES award_shows ON DELETE CASCADE
);

CREATE TABLE nom_points
(
    id SERIAL PRIMARY KEY,
    category_id INTEGER REFERENCES categories ON DELETE CASCADE,
    points INTEGER
);

CREATE TABLE win_points
(
    id SERIAL PRIMARY KEY,
    category_id INTEGER REFERENCES categories ON DELETE CASCADE,
    points INTEGER
);

CREATE TABLE films_noms
(
    id SERIAL PRIMARY KEY,
    film_id INTEGER REFERENCES films ON DELETE CASCADE,
    nom_points_id INTEGER REFERENCES nom_points ON DELETE CASCADE
);

CREATE TABLE films_wins
(
    id SERIAL PRIMARY KEY,
    film_id INTEGER REFERENCES films ON DELETE CASCADE,
    win_points_id INTEGER REFERENCES win_points ON DELETE CASCADE
);







-- CREATE TABLE movies
-- (
--   id SERIAL PRIMARY KEY, 
--   title TEXT NOT NULL,
--   release_year INTEGER,
--   runtime INTEGER,
--   rating TEXT
-- );

-- INSERT INTO movies
-- (title, release_year, runtime, rating)
-- VALUES
-- ('Star Wars: The Force Awakens', 2015, 136, 'PG-13'),
-- ('Avatar', 2009, 160, 'PG-13'),
-- ('Black Panther', 2018, 140, 'PG-13'),
-- ('Jurassic World', 2015, 124, 'PG-13'),
-- ('Marvels The Avengers', 2012, 142, 'PG-13')