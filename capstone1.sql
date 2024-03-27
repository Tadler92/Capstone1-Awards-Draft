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
    img_url TEXT DEFAULT 'https://i.ibb.co/FxkBTLm/Empty-Profile-Pic.jpg'
    -- img_url TEXT DEFAULT 'https://photos.google.com/photo/AF1QipMFokgzHFd_LX1T6H1nhb0bH5wEH29fg2TVfONv'
);

CREATE TABLE groups
(
    id SERIAL PRIMARY KEY,
    group_name VARCHAR(20) NOT NULL UNIQUE,
    password TEXT DEFAULT NULL,
    is_private BOOLEAN DEFAULT FALSE
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

CREATE TABLE groups_users
(
    id SERIAL PRIMARY KEY,
    group_id INTEGER REFERENCES groups ON DELETE CASCADE,
    user_id INTEGER REFERENCES users ON DELETE CASCADE,
    is_admin BOOLEAN DEFAULT FALSE
);

CREATE TABLE group_users_films
(
    id SERIAL PRIMARY KEY,
    group_user_id INTEGER REFERENCES groups_users ON DELETE CASCADE,
    film_id INTEGER REFERENCES films ON DELETE CASCADE
);

CREATE TABLE categories_shows
(
    id SERIAL PRIMARY KEY,
    category_id INTEGER REFERENCES categories ON DELETE CASCADE,
    award_show_id INTEGER REFERENCES award_shows ON DELETE CASCADE
);

CREATE TABLE points
(
    id SERIAL PRIMARY KEY,
    category_show_id INTEGER REFERENCES categories_shows ON DELETE CASCADE,
    nom_or_win TEXT,
    points INTEGER
);

CREATE TABLE nom_points
(
    id SERIAL PRIMARY KEY,
    category_show_id INTEGER REFERENCES categories_shows ON DELETE CASCADE,
    points INTEGER
);

CREATE TABLE win_points
(
    id SERIAL PRIMARY KEY,
    category_show_id INTEGER REFERENCES categories_shows ON DELETE CASCADE,
    points INTEGER
);

CREATE TABLE films_points
(
    id SERIAL PRIMARY KEY,
    film_id INTEGER REFERENCES films ON DELETE CASCADE,
    points_id INTEGER REFERENCES points ON DELETE CASCADE
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


INSERT INTO films (title, year)
VALUES
('Poor Things', 2023),
('Anatomy of a Fall', 2023),
('Anyone but You', 2023),
('Wonka', 2023),
('Oppenheimer', 2023),
('Barbie', 2023),
('The Iron Claw', 2023),
('Leave the World Behind', 2023),
('Wish', 2023),
('The Boys in the Boat', 2023),
('American Fiction', 2023),
('The Holdovers', 2023),
('Past Lives', 2023),
('May December', 2023),
('Bottoms', 2023),
('Saltburn', 2023),
('No One Will Save You', 2023),
('The Hunger Games: The Ballad of Songbirds and Snakes', 2023),
('Napoleon', 2023),
('The Creator', 2023),
('The Exorcist: Believer', 2023),
('Rebel Moon', 2023),
('The Super Mario Bros. Movie', 2023),
('Spider-Man: Across the Spider-Verse', 2023),
('Guardians of the Galaxy Vol. 3', 2023),
('Killers of the Flower Moon', 2023),
('Maestro', 2023),
('The Zone of Interest', 2023),
('Nyad', 2023),
('Rustin', 2023),
('The Color Purple', 2023),
('Mission: Impossible - Dead Reckoning Part One', 2023),
('Godzilla Minus One', 2023);

INSERT INTO users (first_name, last_name, username, email, password)
VALUES
('Trevor', 'Duhon', 'Tadler', 'sithlord789@yahoo.com', 'hello!!!:)'),
('Kyle', 'Duhon', 'RaidenStorm', 'lightninglover@yahoo.com', 'KA-chow!!'),
('Kellie', 'Viola', 'KVoila', 'KellsBells@yahoo.com', 'PurpsNurps1'),
('Haley', 'Anslem', 'handslamy', 'handslamy@yahoo.com', 'LGBTcutie');

INSERT INTO groups (group_name)
VALUES
('The OGsss'),
('GURLLLIEESSS');

INSERT INTO award_shows (show_name)
VALUES
('Academy Awards'),
('Golden Globes'),
('Razzies'),
('SAG Awards'),
('DGA Awards'),
('WGA Awards'),
('Critics Choice Awards');

INSERT INTO categories (category_name)
VALUES
('Best Picture'),
('Best Director'),
('Best Actress'),
('Best Actor'),
('Best Animated Feature'),
('Best Supporting Actress'),
('Best Supporting Actor'),
('Best Original Screenplay'),
('Best Adapted Screenplay'),
('Best Documentary'),
('Best Original Score'),
('Best Original Song'),
('Best International Feature Film'),
('Worst Picture'),
('Worst Actor'),
('Worst Actress'),
('Worst Director');

INSERT INTO categories_shows (category_id, award_show_id)
VALUES
(1, 1),
(2, 1),
(3, 1),
(4, 1),
(5, 1),
(6, 1),
(7, 1),
(8, 1),
(2, 2),
(3, 4),
(4, 4),
(2, 7),
(3, 7),
(4, 7);

INSERT INTO points (category_show_id, points, nom_or_win)
VALUES
(1, 8, 'nom'),
(1, 8, 'win'),
(2, 6, 'nom'),
(2, 6, 'win'),
(9, 4, 'nom'),
(9, 4, 'win'),
(12, 4, 'nom'),
(12, 4, 'win'),
(3, 6, 'nom'),
(3, 6, 'win'),
(10, 4, 'nom'),
(10, 4, 'win'),
(13, 4, 'nom'),
(13, 4, 'win'),
(4, 6, 'nom'),
(4, 6, 'win'),
(11, 4, 'nom'),
(11, 4, 'win'),
(14, 4, 'nom'),
(14, 4, 'win'),
(5, 6, 'nom'),
(5, 6, 'win'),
(6, 4, 'nom'),
(6, 4, 'win'),
(7, 4, 'nom'),
(7, 4, 'win'),
(8, 4, 'nom');
(8, 4, 'win');

INSERT INTO nom_points (category_show_id, points)
VALUES
(1, 8),
(2, 6),
(9, 4),
(12, 4),
(3, 6),
(10, 4),
(13, 4),
(4, 6),
(11, 4),
(14, 4),
(5, 6),
(6, 4),
(7, 4),
(8, 4);

INSERT INTO win_points (category_show_id, points)
VALUES
(1, 8),
(2, 6),
(9, 4),
(12, 4),
(3, 6),
(10, 4),
(13, 4),
(4, 6),
(11, 4),
(14, 4),
(5, 6),
(6, 4),
(7, 4),
(8, 4);

INSERT INTO films_points (film_id, points_id)
VALUES
(1, 1),
(2, 1),
(5, 1),
(6, 1),
(5, 2),
(1, 3),
(5, 3),
(5, 4),
(1, 5),
(26, 5),
(1, 6),
(5, 7),
(11, 7),
(5, 8),
(15, 15),
(11, 15);
(11, 16);

INSERT INTO films_noms (film_id, nom_points_id)
VALUES
(1, 1),
(2, 1),
(5, 1),
(6, 1),
(1, 2),
(5, 2),
(1, 3),
(26, 3),
(5, 4),
(11, 4),
(15, 8),
(11, 8);

INSERT INTO films_wins (film_id, win_points_id)
VALUES
(5, 1),
(5, 2),
(1, 3),
(5, 4),
(11, 8);

INSERT INTO groups_users (group_id, user_id, is_admin)
VALUES
(1, 1, TRUE),
(1, 2, FALSE),
(1, 3, FALSE),
(1, 4, FALSE),
(2, 3, TRUE),
(2, 4, FALSE);

INSERT INTO group_users_films (group_user_id, film_id)
VALUES
(1, 1),
(1, 11),
(3, 5),
(3, 26),
(2, 15),
(4, 22),
(4, 18),
(2, 2),
(5, 6),
(6, 25);






-- INSERT INTO win_points (category_id, points)
-- VALUES
-- (1, 8),
-- (1, 6),
-- (2, 6),
-- (2, 4),
-- (3, 6),
-- (3, 4),
-- (4, 6),
-- (4, 4),
-- (5, 6),
-- (6, 4),
-- (7, 4),
-- (6, 3),
-- (7, 3),
-- (8, 4),
-- (8, 3),
-- (9, 4),
-- (9, 3),
-- (10, 3);







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