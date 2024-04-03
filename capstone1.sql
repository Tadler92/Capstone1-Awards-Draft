DROP DATABASE IF EXISTS awards_draft;

CREATE DATABASE awards_draft;

\c awards_draft

-- Create tables
CREATE TABLE years
(
    id SERIAL PRIMARY KEY,
    curr_year INTEGER NOT NULL
);

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
    year_id INTEGER REFERENCES years ON DELETE SET NULL
);

CREATE TABLE award_shows
(
    id SERIAL PRIMARY KEY,
    show_name TEXT NOT NULL
);

CREATE TABLE shows_years
(
    id SERIAL PRIMARY KEY,
    award_show_id INTEGER REFERENCES award_shows ON DELETE CASCADE,
    year_id INTEGER REFERENCES years ON DELETE CASCADE,
    show_date DATE NOT NULL
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

-- CREATE TABLE categories_show_years
-- (
--     id SERIAL PRIMARY KEY,
--     category_id INTEGER REFERENCES categories ON DELETE CASCADE,
--     show_year_id INTEGER REFERENCES shows_years ON DELETE CASCADE
-- );

CREATE TABLE categories_show_points
(
    id SERIAL PRIMARY KEY,
    category_id INTEGER REFERENCES categories ON DELETE CASCADE,
    show_year_id INTEGER REFERENCES shows_years ON DELETE CASCADE,
    nom_or_win TEXT NOT NULL,
    points INTEGER NOT NULL
);

-- CREATE TABLE points
-- (
--     id SERIAL PRIMARY KEY,
--     category_show_id INTEGER REFERENCES categories_show_years ON DELETE CASCADE,
--     nom_or_win TEXT,
--     points INTEGER
-- );

-- CREATE TABLE nom_points
-- (
--     id SERIAL PRIMARY KEY,
--     category_show_id INTEGER REFERENCES categories_shows ON DELETE CASCADE,
--     points INTEGER
-- );

-- CREATE TABLE win_points
-- (
--     id SERIAL PRIMARY KEY,
--     category_show_id INTEGER REFERENCES categories_shows ON DELETE CASCADE,
--     points INTEGER
-- );

CREATE TABLE films_points
(
    id SERIAL PRIMARY KEY,
    film_id INTEGER REFERENCES films ON DELETE CASCADE,
    points_id INTEGER REFERENCES categories_show_points ON DELETE CASCADE
);

-- CREATE TABLE films_noms
-- (
--     id SERIAL PRIMARY KEY,
--     film_id INTEGER REFERENCES films ON DELETE CASCADE,
--     nom_points_id INTEGER REFERENCES nom_points ON DELETE CASCADE
-- );

-- CREATE TABLE films_wins
-- (
--     id SERIAL PRIMARY KEY,
--     film_id INTEGER REFERENCES films ON DELETE CASCADE,
--     win_points_id INTEGER REFERENCES win_points ON DELETE CASCADE
-- );



-- The list of years that will correspond to when the Award Shows were held
INSERT INTO years (curr_year)
VALUES
(1927), (1928),
(1929), (1930), (1931), (1932), (1933), (1934), (1935), (1936), (1937), (1938), (1939), (1940), (1941), (1942), (1943), (1944), (1945), (1946), (1947), (1948), (1949), (1950), (1951), (1952), (1953), (1954), (1955), (1956), (1957), (1958), (1959), (1960), (1961), (1962), (1963), (1964), (1965), (1966), (1967), (1968), (1969), (1970), (1971), (1972), (1973), (1974), (1975), (1976), (1977), (1978), (1979), (1980), (1981), (1982), (1983), (1984), (1985), (1986), (1987), (1988), (1989), (1990), (1991), (1992), (1993), (1994), (1995), (1996), (1997), (1998), (1999), (2000), (2001), (2002), (2003), (2004), (2005), (2006), (2007), (2008), (2009), (2010), (2011), (2012), (2013), (2014), (2015), (2016), (2017), (2018), (2019), (2020), (2021), (2022), (2023), (2024);



-- The list of films people will be able to choose from depending on the year
INSERT INTO films (title, year_id)
VALUES
('Oppenheimer', 97),
('American Fiction', 97),
('Anatomy of a Fall', 97),
('Barbie', 97),
('The Holdovers', 97),
('Killers of the Flower Moon', 97),
('Maestro', 97),
('Past Lives', 97),
('Poor Things', 97),
('The Zone of Interest', 97),
('Rustin', 97),
('Nyad', 97),
('The Color Purple', 97),
('May December', 97),
('The Boy and the Heron', 97),
('Elemental', 97),
('Nimona', 97),
('Robot Dreams', 97),
('Spider-Man: Across the Spider-Verse', 97),
('Io capitano', 97),
('Perfect Days', 97),
('Society of the Snow', 97),
('The Teacher`s Lounge', 97),
('20 Days in Mariupol', 97),
('Bobi Wine: The People`s President', 97),
('The Eternal Memory', 97),
('Four Daughters', 97),
('To Kill a Tiger', 97),
('Indiana Jones and the Dial of Destiny', 97),
('Flamin` Hot', 97),
('American Symphony', 97),
('The Creator', 97),
('Mission: Impossible - Dead Reckoning Part One', 97),
('Napoleon', 97),
('El Conde', 97),
('Golda', 97),
('Godzilla Minus One', 97),
('Guardians of the Galaxy Vol. 3', 97),
('Anyone but You', 97),
('Wonka', 97),                             -- 40
('The Iron Claw', 97),
('Leave the World Behind', 97),
('Wish', 97),
('The Boys in the Boat', 97),
('Bottoms', 97),
('Saltburn', 97),
('All of Us Strangers', 97),
('No One Will Save You', 97),
('The Hunger Games: The Ballad of Songbirds and Snakes', 97),
('The Exorcist: Believer', 97),
('Rebel Moon', 97),
('The Super Mario Bros. Movie', 97),
('Expend4bles', 97),
('The Marvels', 97),
('Taylor Swift: The Eras Tour', 97),
('Ant-Man and the Wasp: Quantumania', 97),
('Cocaine Bear', 97),
('Creed III', 97),
('Scream VI', 97),
('65', 97),                               -- 60
('Shazam! Fury of the Gods', 97),
('John Wick: Chapter 4', 97),
('Dungeons & Dragons: Honor Among Thieves', 97),
('Murder Mystery 2', 97),
('Air', 97),
('Priscilla', 97),
('Tetris', 97),
('Paint', 97),
('How to Blow Up a Pipeline', 97),
('Renfield', 97),                    -- 70
('Beau is Afraid', 97),
('Dream Scenario', 97),
('The Pope`s Exorcist', 97),
('Are You There God? It`s Me, Margaret.', 97),
('Fast X', 97),
('White Men Can`t Jump', 97),
('The Little Mermaid', 97),
('The Machine', 97),
('Transformers: Rise of the Beasts', 97),
('The Flash', 97),
('Asteroid City', 97),
('Extraction 2', 97),
('No Hard Feelings', 97),
('Fallen Leaves', 97),
('The Blackening', 97),
('M3GAN', 97),
('Suzume', 97),
('She Came to Me', 97),
('Ferrari', 97),
('Beyond Utopia', 97),              -- 90
('Still: A Michael J. Fox Movie', 97),
('Kokomo City', 97),
('Chile `76', 97),
('Shayda', 97),
('A Thousand and One', 97),
('Bella!', 97),
('It Ain`t Over', 97),
('The Pigeon Tunnel', 97),
('Stamped from the Beginning', 97),    -- 99
('Winnie-the-Pooh: Blood and Honey', 97),  -- 100
('Meg 2: The Trench', 97),  -- 101
('Mercy', 97),  -- 102
('Ghosted', 97),  -- 103
('Johnny & Clyde', 97),  -- 104
('Magic Mike`s Last Dance', 97),  -- 105
('The Mother', 97),  -- 106
('Confidential Informant', 97),  -- 107
('About My Father', 97),  -- 108
('Five Nights at Freddy`s', 97),  -- 109
-- 2022 films
('Everything Everywhere All At Once', 96),    -- 110
('All Quiet on the Western Front', 96),
('Avatar: The Way of Water', 96),
('The Banshees of Inisherin', 96),
('Elvis', 96),
('The Fabelmans', 96),
('Tar', 96),
('Top Gun: Maverick', 96),
('Triangle of Sadness', 96),
('Women Talking', 96),
('The Whale', 96),                              -- 120
('Aftersun', 96),
('Living', 96),
('Blonde', 96),
('To Leslie', 96),
('Causeway', 96),
('Black Panther: Wakanda Forever', 96),
('Glass Onion: A Knives Out Mystery', 96),
('Guillermo del Toro`s Pinocchio', 96),
('Marcel the Shell with Shoes On', 96),
('Puss in Boots: The Last Wish', 96),               -- 130
('The Sea Beast', 96),
('Turning Red', 96),
('Argentina, 1985', 96),
('Close', 96),
('EO', 96),
('The Quiet Girl', 96),
('Navalny', 96),
('All That Breathes', 96),
('All The Beauty and the Bloodshed', 96),
('Fire of Love', 96),                                  -- 140
('A House Made of Splinters', 96),
('Babylon', 96),
('RRR', 96),
('Tell It Like a Woman', 96),
('The Batman', 96),
('Empire of Light', 96),
('Bardo, False Chronicle of a Handful of Truths', 96),
('Mrs. Harris Goes to Paris', 96),
('Scream', 96),
('Hotel Transylvania: Transformania', 96),             -- 150
('The King`s Daughter', 96),
('Moonfall', 96),
('Death on the Nile', 96),
('Uncharted', 96),
('Texas Chainsaw Massacre', 96),
('After Yang', 96),
('Fresh', 96),
('The Adam Project', 96),
('X', 96),
('The Lost City', 96),                                -- 160
('Morbius', 96),
('The Bubble', 96),
('Sonic the Hedgehog 2', 96),
('Ambulance', 96),
('Father Stu', 96),
('Fantastic Beasts: The Secrets of Dumbledore', 96),
('The Bad Guys', 96),
('The Northman', 96),
('The Unbearable Weight of Massive Talent', 96),
('Doctor Strange in the Multiverse of Madness', 96),      -- 170
('Senior Year', 96),
('Firestarter', 96),
('Jurassic World Dominion', 96),
('Lightyear', 96),
('The Black Phone', 96),
('Minions: The Rise of Gru', 96),
('Thor: Love and Thunder', 96),
('The Gray Man', 96),
('Where the Crawdads Sing', 96),
('Paws of Fury: The Legend of Hank', 96),                 -- 180
('Nope', 96),
('DC League of Super-Pets', 96),
('Bullet Train', 96),
('Easter Sunday', 96),
('Luck', 96),
('Prey', 96),
('Bodies Bodies Bodies', 96),
('They/Them', 96),
('Fall', 96),
('Emily the Criminal', 96),                                -- 190
('After Ever Happy', 96),
('Pinocchio', 96),
('Barbarian', 96),
('Clerks III', 96),
('The Woman King', 96),
('Pearl', 96),
('Jeepers Creepers: Reborn', 96),
('Don`t Worry Darling', 96),
('The Munsters', 96),
('Smile', 96),                                             -- 200
('Bros', 96),
('Hocus Pocus 2', 96),
('Amsterdam', 96),
('Hellraiser', 96),
('Halloween Ends', 96),
('Till', 96),
('Rosaline', 96),
('The Good Nurse', 96),
('Black Adam', 96),
('Enola Homes 2', 96),                                    -- 210
('Weird: The Al Yankovic Story', 96),
('Spirited', 96),
('A Christmas Story Christmas', 96),
('She Said', 96),
('The Menu', 96),
('Slumberland', 96),
('Bones and All', 96),
('Strange World', 96),
('Violent Night', 96),
('Emancipation', 96),                                    -- 220
('Spoiler Alert', 96),
('The Mean One', 96),
('Whitney Houston: I Wanna Dance with Somebody', 96),
('Saint Omer', 96),
('Happening', 96),
('Murina', 96),
('Retrograde', 96),
('Hustle', 96),
('Moonage Daydream', 96),
('2nd Chance', 96),                                     -- 230
('Last Flight Home', 96),
('Viva Maestro', 96),
('Downfall:The Case Against Boeing', 96),
('The Son', 96),
('The Inspection', 96),
('White Noise', 96),
('Good Luck to You, Leo Grande', 96),
('Inu-Oh', 96),
('Decision to Leave', 96),
('Good Mourning', 96),                                  -- 240
('Marmaduke', 96),
('Samaritan', 96),
('Mack & Rita', 96),
('The Requin', 96),
('The 355', 96),
('Lamborghini: The Man Behind the Legend', 96),
('365 Days: This Day', 96),
('The Next 365 Days', 96);




-- a starting selection of test users
INSERT INTO users (first_name, last_name, username, email, password)
VALUES
('Trevor', 'Duhon', 'Tadler', 'sithlord789@yahoo.com', 'hello!!!:)'),
('Kyle', 'Duhon', 'RaidenStorm', 'lightninglover@yahoo.com', 'KA-chow!!'),
('Kellie', 'Viola', 'KVoila', 'KellsBells@yahoo.com', 'PurpsNurps1'),
('Haley', 'Anslem', 'handslamy', 'handslamy@yahoo.com', 'LGBTcutie');



-- a starting selection of test groups
INSERT INTO groups (group_name)
VALUES
('The OGsss'),
('GURLLLIEESSS');




-- The Award Shows being used/counted
INSERT INTO award_shows (show_name)
VALUES
('Academy Awards'), -- First show in 1929
('Golden Globes'), -- First show in 1944
('Razzies'), -- First show in 1981
('SAG Awards'),  -- First show in 1995
('DGA Awards'),  -- First show in 1949
('WGA Awards'),  -- First show in 1949
('Critics Choice Awards');  -- First show in 1996
-- Baftas First show in 1949
-- Independent Spirit Awards First show in 1986




-- All the years that the Award Shows have been held
INSERT INTO shows_years (award_show_id, year_id, show_date)
VALUES
-- ACADEMY AWARDS (1-96)
(1, 3, '1929-05-16'), -- Date: 05/16/29 for films from 08/01/27 - 07/31/28
(1, 4, '1930-04-03'), -- Date: 04/03/30 for films from 08/01/28 - 07/31/29
(1, 5, '1930-11-05'), -- Date: 11/05/30 for films from 08/01/29 - 07/31/30
(1, 6, '1931-11-10'), -- Date: 11/10/31 for films from 08/01/30 - 07/31/31
(1, 7, '1932-11-18'), -- Date: 11/18/32 for films from 08/01/31 - 07/31/32
(1, 8, '1934-03-16'), -- Date: 03/16/34 for films from 08/01/32 - 12/31/33
(1, 9, '1935-02-27'), -- Date: 02/27/35 for films from 1934
(1, 10, '1936-03-05'), -- Date: 03/05/36 for films from 1935
(1, 11, '1937-03-04'), -- Date: 03/04/37 for films from 1936
(1, 12, '1938-03-10'), -- Date: 03/10/38 for films from 1937
(1, 13, '1939-02-23'), -- Date: 02/23/39 for films from 1938
(1, 14, '1940-02-29'), -- Date: 02/29/40 for films from 1939
(1, 15, '1941-02-27'), -- Date: 02/27/41 for films from 1940
(1, 16, '1942-02-26'), -- Date: 02/26/42 for films from 1941
(1, 17, '1943-03-04'), -- Date: 03/04/43 for films from 1942
(1, 18, '1944-03-02'), -- Date: 03/02/44 for films from 1943
(1, 19, '1945-03-15'), -- Date: 03/15/45 for films from 1944
(1, 20, '1946-03-07'), (1, 21, '1947-03-13'), (1, 22, '1948-03-20'),
(1, 23, '1949-03-24'), (1, 24, '1950-03-23'), (1, 25, '1951-03-29'),
(1, 26, '1952-03-20'), (1, 27, '1953-03-19'), (1, 28, '1954-03-25'),
(1, 29, '1955-03-30'), (1, 30, '1956-03-21'), (1, 31, '1957-03-27'),
(1, 32, '1958-03-26'), (1, 33, '1959-04-06'), (1, 34, '1960-04-04'),
(1, 35, '1961-04-17'), (1, 36, '1962-04-09'), (1, 37, '1963-04-08'),
(1, 38, '1964-04-13'), (1, 39, '1965-04-05'), (1, 40, '1966-04-18'),
(1, 41, '1967-04-10'), (1, 42, '1968-04-10'), (1, 43, '1969-04-14'),
(1, 44, '1970-04-07'), (1, 45, '1971-04-15'), (1, 46, '1972-04-10'),
(1, 47, '1973-03-27'), (1, 48, '1974-04-02'), (1, 49, '1975-04-08'),
(1, 50, '1976-03-29'), (1, 51, '1977-03-28'), (1, 52, '1978-04-03'),
(1, 53, '1979-04-09'), (1, 54, '1980-04-14'), (1, 55, '1981-03-31'),
(1, 56, '1982-03-29'), (1, 57, '1983-04-11'), (1, 58, '1984-04-09'),
(1, 59, '1985-03-25'), (1, 60, '1986-03-24'), (1, 61, '1987-03-30'),
(1, 62, '1988-04-11'), (1, 63, '1989-03-29'), (1, 64, '1990-03-26'),
(1, 65, '1991-03-25'), (1, 66, '1992-03-30'), (1, 67, '1993-03-29'),
(1, 68, '1994-03-21'), (1, 69, '1995-03-27'), (1, 70, '1996-03-25'),
(1, 71, '1997-03-24'), (1, 72, '1998-03-23'), (1, 73, '1999-03-21'),
(1, 74, '2000-03-26'), (1, 75, '2001-03-25'), (1, 76, '2002-03-24'),
(1, 77, '2003-03-23'), (1, 78, '2004-02-29'), (1, 79, '2005-02-27'),
(1, 80, '2006-03-05'), (1, 81, '2007-02-25'), (1, 82, '2008-02-24'),
(1, 83, '2009-02-22'), (1, 84, '2010-03-07'), (1, 85, '2011-02-27'),
(1, 86, '2012-02-26'), (1, 87, '2013-02-24'), (1, 88, '2014-03-02'),
(1, 89, '2015-02-22'), (1, 90, '2016-02-28'), (1, 91, '2017-02-26'),
(1, 92, '2018-03-04'), (1, 93, '2019-02-24'), (1, 94, '2020-02-09'),
(1, 95, '2021-04-25'), -- Date: 04/25/21 for films from 01/01/20 - 02/28/21
(1, 96, '2022-03-27'), -- Date: 03/27/22 for films from 03/01/21 - 12/31/21
(1, 97, '2023-03-12'), (1, 98, '2024-03-10'), 
-- GOLDEN GLOBES (97-177)
(2, 18, '1944-01-20'), -- Date: 01/20/44 for films from 1943
(2, 19, '1945-04-16'), (2, 20, '1946-03-30'), (2, 21, '1947-02-26'),
(2, 22, '1948-03-10'), (2, 23, '1949-03-16'), (2, 24, '1950-02-23'),
(2, 25, '1951-02-28'), (2, 26, '1952-02-21'), (2, 27, '1953-02-26'),
(2, 28, '1954-01-22'), (2, 29, '1955-02-24'), (2, 30, '1956-02-23'),
(2, 31, '1957-02-28'), (2, 32, '1958-02-22'), (2, 33, '1959-03-05'),
(2, 34, '1960-03-10'), (2, 35, '1961-03-16'), (2, 36, '1962-03-05'),
(2, 37, '1963-03-03'), (2, 38, '1964-03-11'), (2, 39, '1965-02-08'),
(2, 40, '1966-02-28'), (2, 41, '1967-02-15'), (2, 42, '1968-02-12'),
(2, 43, '1969-02-24'), (2, 44, '1970-02-02'), (2, 45, '1971-02-05'),
(2, 46, '1972-02-06'), (2, 47, '1973-01-28'), (2, 48, '1974-01-26'),
(2, 49, '1975-01-25'), (2, 50, '1976-01-24'), (2, 51, '1977-01-29'),
(2, 52, '1978-01-28'), (2, 53, '1979-01-27'), (2, 54, '1980-01-26'),
(2, 55, '1981-01-31'), (2, 56, '1982-01-30'), (2, 57, '1983-01-29'),
(2, 58, '1984-01-28'), (2, 59, '1985-01-27'), (2, 60, '1986-01-24'),
(2, 61, '1987-01-31'), (2, 62, '1988-01-23'), (2, 63, '1989-01-28'),
(2, 64, '1990-01-20'), (2, 65, '1991-01-19'), (2, 66, '1992-01-18'),
(2, 67, '1993-01-23'), (2, 68, '1994-01-22'), (2, 69, '1995-01-21'),
(2, 70, '1996-01-21'), (2, 71, '1997-01-19'), (2, 72, '1998-01-18'),
(2, 73, '1999-01-24'), (2, 74, '2000-01-23'), (2, 75, '2001-01-21'),
(2, 76, '2002-01-20'), (2, 77, '2003-01-19'), (2, 78, '2004-01-25'),
(2, 79, '2005-01-16'), (2, 80, '2006-01-16'), (2, 81, '2007-01-15'),
(2, 82, '2008-01-13'), (2, 83, '2009-01-11'), (2, 84, '2010-01-17'),
(2, 85, '2011-01-16'), (2, 86, '2012-01-15'), (2, 87, '2013-01-13'),
(2, 88, '2014-01-12'), (2, 89, '2015-01-11'), (2, 90, '2016-01-10'),
(2, 91, '2017-01-08'), (2, 92, '2018-01-07'), (2, 93, '2019-01-06'),
(2, 94, '2020-01-05'), 
(2, 95, '2021-02-28'), -- Date: 02/28/21 for films from 2020 - 02/28/21
(2, 96, '2022-01-09'), (2, 97, '2023-01-10'), (2, 98, '2024-01-07'),
-- RAZZIES (178-221)
(3, 55, '1981-03-31'), (3, 56, '1982-03-29'), (3, 57, '1983-04-11'),
(3, 58, '1984-04-08'), (3, 59, '1985-03-24'), (3, 60, '1986-03-23'),
(3, 61, '1987-03-29'), (3, 62, '1988-04-10'), (3, 63, '1989-03-29'),
(3, 64, '1990-03-25'), (3, 65, '1991-03-24'), (3, 66, '1992-03-29'),
(3, 67, '1993-03-28'), (3, 68, '1994-03-20'), (3, 69, '1995-03-26'),
(3, 70, '1996-03-24'), (3, 71, '1997-03-23'), (3, 72, '1998-03-22'),
(3, 73, '1999-03-20'), (3, 74, '2000-03-25'), (3, 75, '2001-03-24'),
(3, 76, '2002-03-23'), (3, 77, '2003-03-22'), (3, 78, '2004-02-28'),
(3, 79, '2005-02-26'), (3, 80, '2006-03-04'), (3, 81, '2007-02-24'),
(3, 82, '2008-02-23'), (3, 83, '2009-02-21'), (3, 84, '2010-03-06'),
(3, 85, '2011-02-26'), (3, 86, '2012-04-01'), (3, 87, '2013-02-23'),
(3, 88, '2014-03-01'), (3, 89, '2015-02-21'), (3, 90, '2016-02-27'),
(3, 91, '2017-02-25'), (3, 92, '2018-03-03'), (3, 93, '2019-02-23'),
(3, 94, '2020-03-16'),
(3, 95, '2021-04-24'), -- Date 04/24/2021 for films from 2020 - 02/2021
(3, 96, '2022-03-26'), (3, 97, '2023-03-10'), (3, 98, '2024-03-09'),
-- SAG AWARDS (222-251)
(4, 69, '1995-02-25'), (4, 70, '1996-02-24'), (4, 71, '1997-02-22'),
(4, 72, '1998-03-08'), (4, 73, '1999-03-07'), (4, 74, '2000-03-12'),
(4, 75, '2001-03-11'), (4, 76, '2002-03-10'), (4, 77, '2003-03-09'),
(4, 78, '2004-02-22'), (4, 79, '2005-02-05'), (4, 80, '2006-01-29'),
(4, 81, '2007-01-28'), (4, 82, '2008-01-27'), (4, 83, '2009-01-25'),
(4, 84, '2010-01-23'), (4, 85, '2011-01-30'), (4, 86, '2012-01-29'),
(4, 87, '2013-01-27'), (4, 88, '2014-01-18'), (4, 89, '2015-01-25'),
(4, 90, '2016-01-30'), (4, 91, '2017-01-29'), (4, 92, '2018-01-21'),
(4, 93, '2019-01-27'), (4, 94, '2020-01-19'), (4, 95, '2021-04-04'),
(4, 96, '2022-02-27'), (4, 97, '2023-02-26'), (4, 98, '2024-02-24'),
-- DGA AWARDS (252-327) (dates for 1949-65, 1970-73, 76-8 are approximate)
(5, 23, '1949-03-12'), (5, 24, '1950-03-11'), (5, 25, '1951-03-10'),
(5, 26, '1952-03-08'), (5, 27, '1953-03-14'), (5, 28, '1954-03-13'),
(5, 29, '1955-03-12'), (5, 30, '1956-03-10'), (5, 31, '1957-03-09'),
(5, 32, '1958-03-08'), (5, 33, '1959-03-14'), (5, 34, '1960-03-12'),
(5, 35, '1961-03-11'), (5, 36, '1962-03-10'), (5, 37, '1963-03-09'),
(5, 38, '1964-03-14'), (5, 39, '1965-03-13'), (5, 40, '1966-02-12'),
(5, 41, '1967-02-11'), (5, 42, '1968-02-17'), (5, 43, '1969-02-22'),
(5, 44, '1970-02-28'), (5, 45, '1971-02-27'), (5, 46, '1972-02-26'),
(5, 47, '1973-02-24'), (5, 48, '1974-03-16'), (5, 49, '1975-03-15'),
(5, 50, '1976-01-24'), (5, 51, '1977-01-24'), (5, 52, '1978-01-24'),
(5, 53, '1979-03-10'), (5, 54, '1980-03-15'), (5, 55, '1981-03-14'),
(5, 56, '1982-03-13'), (5, 57, '1983-03-12'), (5, 58, '1984-03-10'),
(5, 59, '1985-03-09'), (5, 60, '1986-03-08'), (5, 61, '1987-03-07'),
(5, 62, '1988-03-12'), (5, 63, '1989-03-11'), (5, 64, '1990-03-10'),
(5, 65, '1991-03-16'), (5, 66, '1992-03-14'), (5, 67, '1993-03-06'),
(5, 68, '1994-03-05'), (5, 69, '1995-03-11'), (5, 70, '1996-03-02'),
(5, 71, '1997-03-08'), (5, 72, '1998-03-07'), (5, 73, '1999-03-06'),
(5, 74, '2000-03-11'), (5, 75, '2001-03-10'), (5, 76, '2002-03-09'),
(5, 77, '2003-03-01'), (5, 78, '2004-02-07'), (5, 79, '2005-01-29'),
(5, 80, '2006-01-28'), (5, 81, '2007-02-03'), (5, 82, '2008-01-26'),
(5, 83, '2009-01-31'), (5, 84, '2010-01-30'), (5, 85, '2011-01-29'),
(5, 86, '2012-01-28'), (5, 87, '2013-02-02'), (5, 88, '2014-01-25'),
(5, 89, '2015-02-07'), (5, 90, '2016-02-06'), (5, 91, '2017-02-04'),
(5, 92, '2018-02-03'), (5, 93, '2019-02-02'), (5, 94, '2020-01-25'),
(5, 95, '2021-04-10'), (5, 96, '2022-03-12'), (5, 97, '2023-02-18'),
(5, 98, '2024-02-10'),
-- WGA AWARDS (328-403) (dates for 1949-63, 64-5, 67, 69-72, 74-89, 91-97, 99 are approximate)
(6, 23, '1949-03-12'), (6, 24, '1950-03-11'), (6, 25, '1951-03-10'),
(6, 26, '1952-03-08'), (6, 27, '1953-03-14'), (6, 28, '1954-03-13'),
(6, 29, '1955-03-12'), (6, 30, '1956-03-10'), (6, 31, '1957-03-09'),
(6, 32, '1958-03-08'), (6, 33, '1959-03-14'), (6, 34, '1960-03-12'),
(6, 35, '1961-03-11'), (6, 36, '1962-03-10'), (6, 37, '1963-05-07'),
(6, 38, '1964-03-14'), (6, 39, '1965-03-13'), (6, 40, '1966-03-23'),
(6, 41, '1967-02-11'), (6, 42, '1968-03-22'), (6, 43, '1969-02-22'),
(6, 44, '1970-02-28'), (6, 45, '1971-02-27'), (6, 46, '1972-02-26'),
(6, 47, '1973-03-16'), (6, 48, '1974-03-16'), (6, 49, '1975-03-15'),
(6, 50, '1976-01-24'), (6, 51, '1977-01-24'), (6, 52, '1978-01-24'),
(6, 53, '1979-03-10'), (6, 54, '1980-03-15'), (6, 55, '1981-03-14'),
(6, 56, '1982-03-13'), (6, 57, '1983-03-12'), (6, 58, '1984-03-10'),
(6, 59, '1985-03-09'), (6, 60, '1986-03-08'), (6, 61, '1987-03-07'),
(6, 62, '1988-03-12'), (6, 63, '1989-03-11'), (6, 64, '1990-03-18'),
(6, 65, '1991-03-16'), (6, 66, '1992-03-14'), (6, 67, '1993-03-06'),
(6, 68, '1994-03-05'), (6, 69, '1995-03-11'), (6, 70, '1996-03-02'),
(6, 71, '1997-03-08'), (6, 72, '1998-02-21'), (6, 73, '1999-03-06'),
(6, 74, '2000-03-05'), (6, 75, '2001-03-04'), (6, 76, '2002-03-02'),
(6, 77, '2003-03-08'), (6, 78, '2004-02-21'), (6, 79, '2005-02-19'),
(6, 80, '2006-02-04'), (6, 81, '2007-02-11'), (6, 82, '2008-02-09'),
(6, 83, '2009-02-07'), (6, 84, '2010-02-20'), (6, 85, '2011-02-05'),
(6, 86, '2012-02-19'), (6, 87, '2013-02-17'), (6, 88, '2014-02-01'),
(6, 89, '2015-02-14'), (6, 90, '2016-02-13'), (6, 91, '2017-02-19'),
(6, 92, '2018-02-11'), (6, 93, '2019-02-17'), (6, 94, '2020-02-01'),
(6, 95, '2021-03-21'), (6, 96, '2022-03-20'), (6, 97, '2023-03-05'),
(6, 98, '2024-04-14'),
-- CRITICS CHOICE AWARDS (404-432)
(7, 70, '1996-01-22'), (7, 71, '1997-01-20'), (7, 72, '1998-01-20'), 
(7, 73, '1999-01-25'), (7, 74, '2000-01-24'), (7, 75, '2001-01-22'), 
(7, 76, '2002-01-11'), (7, 77, '2003-01-17'), (7, 78, '2004-01-10'), 
(7, 79, '2005-01-10'), (7, 80, '2006-01-09'), (7, 81, '2007-01-14'), 
(7, 82, '2008-01-07'), (7, 83, '2009-01-08'), (7, 84, '2010-01-15'), 
(7, 85, '2011-01-14'), (7, 86, '2012-01-12'), (7, 87, '2013-01-10'), 
(7, 88, '2014-01-16'), (7, 89, '2015-01-15'), (7, 90, '2016-01-17'), 
(7, 91, '2016-12-11'), (7, 92, '2018-01-11'), (7, 93, '2019-01-13'), 
(7, 94, '2020-01-12'), (7, 95, '2021-03-07'), (7, 96, '2022-03-13'), 
(7, 97, '2023-01-15'), (7, 98, '2024-01-14');
-- BAFTA AWARDS?
-- INDEPENDENT SPIRIT AWARDS?





-- All the categories that will receive points if the film is nominated for them
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
('Best Cinematography'),
('Best Costume Design'),
('Best Makeup and Hairstyling'),
('Best Production Design'),
('Best Sound'),
('Best Visual Effects'),
('Best Film Editing'), -- 20
('Best Drama'),
('Best Musical/Comedy'),
('Best Actor Drama'),
('Best Actress Drama'),
('Best Actor Musical/Comedy'),
('Best Actress Musical/Comedy'),
('Best Screenplay'),  -- 27
('Worst Picture'),
('Worst Actor'),
('Worst Actress'),
('Worst Director'),
('Worst Supporting Actor'),
('Worst Supporting Actress'),
('Worst Screenplay'),
('Worst Prequel/Remake/Sequel'),
('Worst Screen Combo'),  -- 36
('Best Ensemble'),
('Best Stunts'),
('Best Director Theatrical Film'),
('Best First-Time Director'),
('Best Director Documentary'),
('Best Documentary Screenplay'),
('Best Acting Ensemble');





-- Combining the categories with the corresponding Award Year

-- INSERT INTO categories_show_years (category_id, show_year_id)
-- VALUES
-- (1, 96), (2, 96), (3, 96), (4, 96), (5, 96), (6, 96), (7, 96), (8, 96),
-- (9, 96), (10, 96), (11, 96), (12, 96), (13, 96), (14, 96), (15, 96),
-- (16, 96), (17, 96), (18, 96), (19, 96), (20, 96), (1, 95), (2, 95),
-- (3, 95), (4, 95), (5, 95), (6, 95), (7, 95), (8, 95), (9, 95), (10, 95),
-- (11, 95), (12, 95), (13, 95), (14, 95), (15, 95), (16, 95), (17, 95),
-- (18, 95), (19, 95), (20, 95),
-- (21, 177), (22, 177), (23, 177), (24, 177), (25, 177), (26, 177), (2, 177),
-- (5, 177), (6, 177), (7, 177), (27, 177), (11, 177), (12, 177), (13, 177),
-- (21, 176), (22, 176), (23, 176), (24, 176), (25, 176), (26, 176), (2, 176),
-- (5, 176), (6, 176), (7, 176), (27, 176), (11, 176), (12, 176), (13, 176),
-- (28, 221), (29, 221), (30, 221), (31, 221), (32, 221), (33, 221),
-- (34, 221), (35, 221), (36, 221), (28, 220), (29, 220), (30, 220),
-- (31, 220), (32, 220), (33, 220), (34, 220), (35, 220), (36, 220),
-- (37, 251), (3, 251), (4, 251), (6, 251), (7, 251), (38, 251), (37, 250),
-- (3, 250), (4, 250), (6, 250), (7, 250), (38, 250),
-- (39, 327), (40, 327), (41, 327), (39, 326), (40, 326), (41, 326),
-- (8, 403), (9, 403), (42, 403), (8, 402), (9, 402), (42, 402),
-- (1, 432), (2, 432), (3, 432), (4, 432), (6, 432), (7, 432), (43, 432),
-- (8, 432), (9, 432), (1, 431), (2, 431), (3, 431), (4, 431), (6, 431),
-- (7, 431), (43, 431), (8, 431), (9, 431);


INSERT INTO categories_show_points (category_id, show_year_id, nom_or_win, points)
VALUES
(1, 96, 'nom', 8), (1, 96, 'win', 8), (2, 96, 'nom', 6),  --   3
(2, 96, 'win', 6), (3, 96, 'nom', 6), (3, 96, 'win', 6),  --   6
(4, 96, 'nom', 6), (4, 96, 'win', 6), (5, 96, 'nom', 6),  --   9
(5, 96, 'win', 6), (6, 96, 'nom', 4), (6, 96, 'win', 4),  --  12
(7, 96, 'nom', 4), (7, 96, 'win', 4), (8, 96, 'nom', 4), --   15
(8, 96, 'win', 4), (9, 96, 'nom', 4), (9, 96, 'win', 4),  --  18
(10, 96, 'nom', 3), (10, 96, 'win', 3), (11, 96, 'nom', 3),  -- 21
(11, 96, 'win', 3), (12, 96, 'nom', 3), (12, 96, 'win', 3),  -- 24
(13, 96, 'nom', 3), (13, 96, 'win', 3), (14, 96, 'nom', 2),  -- 27
(14, 96, 'win', 2), (15, 96, 'nom', 2), (15, 96, 'win', 2), --  30
(16, 96, 'nom', 2),  -- 31
(16, 96, 'win', 2),  -- 32
(17, 96, 'nom', 2),  -- 33
(17, 96, 'win', 2),  -- 34
(18, 96, 'nom', 2),  -- 35
(18, 96, 'win', 2),  -- 36
(19, 96, 'nom', 2),  -- 37
(19, 96, 'win', 2),  -- 38
(20, 96, 'nom', 2),  -- 39
(20, 96, 'win', 2),  -- 40
(1, 95, 'nom', 8),  --  41
(1, 95, 'win', 8),  --  42
(2, 95, 'nom', 6), --   43
(2, 95, 'win', 6), --   44
(3, 95, 'nom', 6),  --  45
(3, 95, 'win', 6),  --  46
(4, 95, 'nom', 6),  --  47
(4, 95, 'win', 6),  --  48
(5, 95, 'nom', 6),  --  49
(5, 95, 'win', 6),  --  50
(6, 95, 'nom', 4),  --  51
(6, 95, 'win', 4),  --  52
(7, 95, 'nom', 4),  --  53
(7, 95, 'win', 4),  --  54
(8, 95, 'nom', 4),  --  55
(8, 95, 'win', 4),  --  56
(9, 95, 'nom', 4),  --  57
(9, 95, 'win', 4),  --  58
(10, 95, 'nom', 3), --  59
(10, 95, 'win', 3), --  60
(11, 95, 'nom', 3),  -- 61
(11, 95, 'win', 3),  -- 62
(12, 95, 'nom', 3),  -- 63
(12, 95, 'win', 3),  -- 64
(13, 95, 'nom', 3),  -- 65
(13, 95, 'win', 3),  -- 66
(14, 95, 'nom', 2),  -- 67
(14, 95, 'win', 2),  -- 68
(15, 95, 'nom', 2),  -- 69
(15, 95, 'win', 2),  -- 70
(16, 95, 'nom', 2),  -- 71
(16, 95, 'win', 2),  -- 72
(17, 95, 'nom', 2), --  73
(17, 95, 'win', 2), --  74
(18, 95, 'nom', 2),  -- 75
(18, 95, 'win', 2),  -- 76
(19, 95, 'nom', 2),  -- 77
(19, 95, 'win', 2),  -- 78
(20, 95, 'nom', 2), --  79
(20, 95, 'win', 2), --  80
(21, 177, 'nom', 5), -- 81
(21, 177, 'win', 5), -- 82
(22, 177, 'nom', 5), -- 83
(22, 177, 'win', 5), -- 84
(23, 177, 'nom', 4), -- 85
(23, 177, 'win', 4), -- 86
(24, 177, 'nom', 4), -- 87
(24, 177, 'win', 4), -- 88
(25, 177, 'nom', 4), -- 89
(25, 177, 'win', 4), -- 90
(26, 177, 'nom', 4), -- 91
(26, 177, 'win', 4), -- 92
(2, 177, 'nom', 4), --  93
(2, 177, 'win', 4), --  94
(5, 177, 'nom', 4),  -- 95
(5, 177, 'win', 4),  -- 96
(6, 177, 'nom', 3),  -- 97
(6, 177, 'win', 3),  -- 98
(7, 177, 'nom', 3),  -- 99
(7, 177, 'win', 3),  -- 100
(27, 177, 'nom', 2),  -- 101
(27, 177, 'win', 2),  -- 102
(11, 177, 'nom', 2),  -- 103
(11, 177, 'win', 2),  -- 104
(12, 177, 'nom', 2),  -- 105
(12, 177, 'win', 2),  -- 106
(13, 177, 'nom', 2), --  107
(13, 177, 'win', 2), --  108
(21, 176, 'nom', 5),  -- 109
(21, 176, 'win', 5),  -- 110
(22, 176, 'nom', 5),  -- 111
(22, 176, 'win', 5),  -- 112
(23, 176, 'nom', 4),  -- 113
(23, 176, 'win', 4),  -- 114
(24, 176, 'nom', 4),  -- 115
(24, 176, 'win', 4),  -- 116
(25, 176, 'nom', 4),  -- 117
(25, 176, 'win', 4),  -- 118
(26, 176, 'nom', 4),  -- 119
(26, 176, 'win', 4),  -- 120
(2, 176, 'nom', 4), --   121
(2, 176, 'win', 4), --   122
(5, 176, 'nom', 4),  --  123
(5, 176, 'win', 4),  --  124
(6, 176, 'nom', 3),  --  125
(6, 176, 'win', 3),  --  126
(7, 176, 'nom', 3),  --  127
(7, 176, 'win', 3),  --  128
(27, 176, 'nom', 2),  -- 129
(27, 176, 'win', 2),  -- 130
(11, 176, 'nom', 2),  -- 131
(11, 176, 'win', 2),  -- 132
(12, 176, 'nom', 2),  -- 133
(12, 176, 'win', 2),  -- 134
(13, 176, 'nom', 2), --  135
(13, 176, 'win', 2), --  136
(28, 221, 'nom', 4),  -- 137
(28, 221, 'win', 4),  -- 138
(29, 221, 'nom', 3),  -- 139
(29, 221, 'win', 3),  -- 140
(30, 221, 'nom', 3),  -- 141
(30, 221, 'win', 3),  -- 142
(31, 221, 'nom', 3),  -- 143
(31, 221, 'win', 3),  -- 144
(32, 221, 'nom', 2),  -- 145
(32, 221, 'win', 2),  -- 146
(33, 221, 'nom', 2), --  147
(33, 221, 'win', 2), --  148
(34, 221, 'nom', 1),  -- 149
(34, 221, 'win', 1),  -- 150
(35, 221, 'nom', 1),  -- 151
(35, 221, 'win', 1),  -- 152
(36, 221, 'nom', 1),  -- 153
(36, 221, 'win', 1),  -- 154
(28, 220, 'nom', 4),  -- 155
(28, 220, 'win', 4),  -- 156
(29, 220, 'nom', 3),  -- 157
(29, 220, 'win', 3),  -- 158
(30, 220, 'nom', 3), --  159
(30, 220, 'win', 3), --  160
(31, 220, 'nom', 3),  -- 161
(31, 220, 'win', 3),  -- 162
(32, 220, 'nom', 2),  -- 163
(32, 220, 'win', 2),  -- 164
(33, 220, 'nom', 2),  -- 165
(33, 220, 'win', 2),  -- 166
(34, 220, 'nom', 1),  -- 167
(34, 220, 'win', 1),  -- 168
(35, 220, 'nom', 1),  -- 169
(35, 220, 'win', 1),  -- 170
(36, 220, 'nom', 1), --  171
(36, 220, 'win', 1), --  172
(37, 251, 'nom', 4),  -- 173
(37, 251, 'win', 4),  -- 174
(3, 251, 'nom', 3),  --  175
(3, 251, 'win', 3),  --  176
(4, 251, 'nom', 3),  --  177
(4, 251, 'win', 3),  --  178
(6, 251, 'nom', 2),  --  179
(6, 251, 'win', 2),  --  180
(7, 251, 'nom', 2),  --  181
(7, 251, 'win', 2),  --  182
(38, 251, 'nom', 1),  -- 183
(38, 251, 'win', 1),  -- 184
(37, 250, 'nom', 4), --  185
(37, 250, 'win', 4), --  186
(3, 250, 'nom', 3),  --  187
(3, 250, 'win', 3),  --  188
(4, 250, 'nom', 3),  --  189
(4, 250, 'win', 3),  --  190
(6, 250, 'nom', 2),  --  191
(6, 250, 'win', 2),  --  192
(7, 250, 'nom', 2),  --  193
(7, 250, 'win', 2),  --  194
(38, 250, 'nom', 1), --  195
(38, 250, 'win', 1), --  196
(39, 327, 'nom', 3),  -- 197
(39, 327, 'win', 3),  -- 198
(40, 327, 'nom', 2),  -- 199
(40, 327, 'win', 2),  -- 200
(41, 327, 'nom', 2),  -- 201
(41, 327, 'win', 2),  -- 202
(39, 326, 'nom', 3),  -- 203
(39, 326, 'win', 3),  -- 204
(40, 326, 'nom', 2),  -- 205
(40, 326, 'win', 2),  -- 206
(41, 326, 'nom', 2), --  207
(41, 326, 'win', 2), --  208
(8, 403, 'nom', 2),  --  209
(8, 403, 'win', 2),  --  210
(9, 403, 'nom', 2),  --  211
(9, 403, 'win', 2),  --  212
(42, 403, 'nom', 1),  -- 213
(42, 403, 'win', 1),  -- 214
(8, 402, 'nom', 2),  --  215
(8, 402, 'win', 2),  --  216
(9, 402, 'nom', 2),  --  217
(9, 402, 'win', 2),  --  218
(42, 402, 'nom', 1), --  219
(42, 402, 'win', 1), --  220
(1, 432, 'nom', 4),  --  221
(1, 432, 'win', 4),  --  222
(2, 432, 'nom', 3),  --  223
(2, 432, 'win', 3),  --  224
(3, 432, 'nom', 3),  --  225
(3, 432, 'win', 3),  --  226
(4, 432, 'nom', 3),  --  227
(4, 432, 'win', 3),  --  228
(6, 432, 'nom', 2),  --  229
(6, 432, 'win', 2),  --  230
(7, 432, 'nom', 2),  --  231
(7, 432, 'win', 2),  --  232
(43, 432, 'nom', 2), --  233
(43, 432, 'win', 2), --  234
(8, 432, 'nom', 1),  --  235
(8, 432, 'win', 1),  --  236
(9, 432, 'nom', 1),  --  237
(9, 432, 'win', 1),  --  238
(1, 431, 'nom', 4),  --  239
(1, 431, 'win', 4),  --  240
(2, 431, 'nom', 3),  --  241
(2, 431, 'win', 3),  --  242
(3, 431, 'nom', 3),  --  243
(3, 431, 'win', 3),  --  244
(4, 431, 'nom', 3),  --  245
(4, 431, 'win', 3),  --  246
(6, 431, 'nom', 2), --   247
(6, 431, 'win', 2), --   248
(7, 431, 'nom', 2),  --  249
(7, 431, 'win', 2),  --  250
(43, 431, 'nom', 2),  -- 251
(43, 431, 'win', 2),  -- 252
(8, 431, 'nom', 1),  --  253
(8, 431, 'win', 1),  --  254
(9, 431, 'nom', 1), --   255
(9, 431, 'win', 1); --   256




-- Giving specific points depending on the category and award show (Revised in Above Table)

-- INSERT INTO points (category_show_id, points, nom_or_win)
-- VALUES
-- (1, 8, 'nom'), (1, 8, 'win'), (2, 6, 'nom'), (2, 6, 'win'), (3, 6, 'nom'),
-- (3, 6, 'win'), (4, 6, 'nom'), (4, 6, 'win'), (5, 6, 'nom'), (5, 6, 'win'),
-- (6, 4, 'nom'), (6, 4, 'win'), (7, 4, 'nom'), (7, 4, 'win'), (8, 4, 'nom'),
-- (8, 4, 'win'), (9, 4, 'nom'), (9, 4, 'win'), (10, 3, 'nom'),
-- (10, 3, 'win'), (11, 3, 'nom'), (11, 3, 'win'), (12, 3, 'nom'),
-- (12, 3, 'win'), (13, 3, 'nom'), (13, 3, 'win'), (14, 2, 'nom'),
-- (14, 2, 'win'), (15, 2, 'nom'), (15, 2, 'win'), (16, 2, 'nom'),
-- (16, 2, 'win'), (17, 2, 'nom'), (17, 2, 'win'), (18, 2, 'nom'),
-- (18, 2, 'win'), (19, 2, 'nom'), (19, 2, 'win'), (20, 2, 'nom'),
-- (20, 2, 'win'), (21, 8, 'nom'), (21, 8, 'win'), (22, 6, 'nom'),
-- (22, 6, 'win'), (23, 6, 'nom'), (23, 6, 'win'), (24, 6, 'nom'),
-- (24, 6, 'win'), (25, 6, 'nom'), (25, 6, 'win'), (26, 4, 'nom'),
-- (26, 4, 'win'), (27, 4, 'nom'), (27, 4, 'win'), (28, 4, 'nom'),
-- (28, 4, 'win'), (29, 4, 'nom'), (29, 4, 'win'), (30, 3, 'nom'),
-- (30, 3, 'win'), (31, 3, 'nom'), (31, 3, 'win'), (32, 3, 'nom'),
-- (32, 3, 'win'), (33, 3, 'nom'), (33, 3, 'win'), (34, 2, 'nom'),
-- (34, 2, 'win'), (35, 2, 'nom'), (35, 2, 'win'), (36, 2, 'nom'),
-- (36, 2, 'win'), (37, 2, 'nom'), (37, 2, 'win'), (38, 2, 'nom'),
-- (38, 2, 'win'), (39, 2, 'nom'), (39, 2, 'win'), (40, 2, 'nom'),
-- (40, 2, 'win'), (41, 5, 'nom'), (41, 5, 'win'), (42, 5, 'nom'),
-- (42, 5, 'win'), (43, 4, 'nom'), (43, 4, 'win'), (44, 4, 'nom'),
-- (44, 4, 'win'), (45, 4, 'nom'), (45, 4, 'win'), (46, 4, 'nom'),
-- (46, 4, 'win'), (47, 4, 'nom'), (47, 4, 'win'), (48, 4, 'nom'),
-- (48, 4, 'win'), (49, 3, 'nom'), (49, 3, 'win'), (50, 3, 'nom'),
-- (50, 3, 'win'), (51, 2, 'nom'), (51, 2, 'win'), (52, 2, 'nom'),
-- (52, 2, 'win'), (53, 2, 'nom'), (53, 2, 'win'), (54, 2, 'nom'),
-- (54, 2, 'win'), (55, 5, 'nom'), (55, 5, 'win'), (56, 5, 'nom'),
-- (56, 5, 'win'), (57, 4, 'nom'), (57, 4, 'win'), (58, 4, 'nom'),
-- (58, 4, 'win'), (59, 4, 'nom'), (59, 4, 'win'), (60, 4, 'nom'),
-- (60, 4, 'win'), (61, 4, 'nom'), (61, 4, 'win'), (62, 4, 'nom'),
-- (62, 4, 'win'), (63, 3, 'nom'), (63, 3, 'win'), (64, 3, 'nom'),
-- (64, 3, 'win'), (65, 2, 'nom'), (65, 2, 'win'), (66, 2, 'nom'),
-- (66, 2, 'win'), (67, 2, 'nom'), (67, 2, 'win'), (68, 2, 'nom'),
-- (68, 2, 'win'), (69, 4, 'nom'), (69, 4, 'win'), (70, 3, 'nom'),
-- (70, 3, 'win'), (71, 3, 'nom'), (71, 3, 'win'), (72, 3, 'nom'),
-- (72, 3, 'win'), (73, 2, 'nom'), (73, 2, 'win'), (74, 2, 'nom'),
-- (74, 2, 'win'), (75, 1, 'nom'), (75, 1, 'win'), (76, 1, 'nom'),
-- (76, 1, 'win'), (77, 1, 'nom'), (77, 1, 'win'), (78, 4, 'nom'),
-- (78, 4, 'win'), (79, 3, 'nom'), (79, 3, 'win'), (80, 3, 'nom'),
-- (80, 3, 'win'), (81, 3, 'nom'), (81, 3, 'win'), (82, 2, 'nom'),
-- (82, 2, 'win'), (83, 2, 'nom'), (83, 2, 'win'), (84, 1, 'nom'),
-- (84, 1, 'win'), (85, 1, 'nom'), (85, 1, 'win'), (86, 1, 'nom'),
-- (86, 1, 'win'), (87, 4, 'nom'), (87, 4, 'win'), (88, 3, 'nom'),
-- (88, 3, 'win'), (89, 3, 'nom'), (89, 3, 'win'), (90, 2, 'nom'),
-- (90, 2, 'win'), (91, 2, 'nom'), (91, 2, 'win'), (92, 1, 'nom'),
-- (92, 1, 'win'), (93, 4, 'nom'), (93, 4, 'win'), (94, 3, 'nom'),
-- (94, 3, 'win'), (95, 3, 'nom'), (95, 3, 'win'), (96, 2, 'nom'),
-- (96, 2, 'win'), (97, 2, 'nom'), (97, 2, 'win'), (98, 1, 'nom'),
-- (98, 1, 'win'), (99, 3, 'nom'), (99, 3, 'win'), (100, 2, 'nom'),
-- (100, 2, 'win'), (101, 2, 'nom'), (101, 2, 'win'), (102, 3, 'nom'),
-- (102, 3, 'win'), (103, 2, 'nom'), (103, 2, 'win'), (104, 2, 'nom'),
-- (104, 2, 'win'), (105, 2, 'nom'), (105, 2, 'win'), (106, 2, 'nom'),
-- (106, 2, 'win'), (107, 1, 'nom'), (107, 1, 'win'), (108, 2, 'nom'),
-- (108, 2, 'win'), (109, 2, 'nom'), (109, 2, 'win'), (110, 1, 'nom'),
-- (110, 1, 'win'), (111, 4, 'nom'), (111, 4, 'win'), (112, 3, 'nom'),
-- (112, 3, 'win'), (113, 3, 'nom'), (113, 3, 'win'), (114, 3, 'nom'),
-- (114, 3, 'win'), (115, 2, 'nom'), (115, 2, 'win'), (116, 2, 'nom'),
-- (116, 2, 'win'), (117, 2, 'nom'), (117, 2, 'win'), (118, 1, 'nom'),
-- (118, 1, 'win'), (119, 1, 'nom'), (119, 1, 'win'), (120, 4, 'nom'),
-- (120, 4, 'win'), (121, 3, 'nom'), (121, 3, 'win'), (122, 3, 'nom'),
-- (122, 3, 'win'), (123, 3, 'nom'), (123, 3, 'win'), (124, 2, 'nom'),
-- (124, 2, 'win'), (125, 2, 'nom'), (125, 2, 'win'), (126, 2, 'nom'),
-- (126, 2, 'win'), (127, 1, 'nom'), (127, 1, 'win'), (128, 1, 'nom'),
-- (128, 1, 'win');

-- INSERT INTO nom_points (category_show_id, points)
-- VALUES
-- (1, 8),
-- (2, 6),
-- (9, 4),
-- (12, 4),
-- (3, 6),
-- (10, 4),
-- (13, 4),
-- (4, 6),
-- (11, 4),
-- (14, 4),
-- (5, 6),
-- (6, 4),
-- (7, 4),
-- (8, 4);

-- INSERT INTO win_points (category_show_id, points)
-- VALUES
-- (1, 8),
-- (2, 6),
-- (9, 4),
-- (12, 4),
-- (3, 6),
-- (10, 4),
-- (13, 4),
-- (4, 6),
-- (11, 4),
-- (14, 4),
-- (5, 6),
-- (6, 4),
-- (7, 4),
-- (8, 4);





-- Giving the films points if they were nominated/won a category
INSERT INTO films_points (film_id, points_id)
VALUES
-- 2024 OSCARS:
-- Best Picture
(1, 1), (2, 1), (3, 1), (4, 1), (5, 1), (6, 1), (7, 1), (8, 1), (9, 1),
(10, 1),
(1, 2),
-- Best Director
(1, 3), (3, 3), (6, 3), (9, 3), (10, 3),
(1, 4),
-- Best Actress
(9, 5),  (12, 5), (6, 5), (3, 5), (7, 5),
(9, 6),
-- Best Actor
(1, 7), (7, 7), (11, 7), (5, 7), (2, 7),
(1, 8),
-- Best Animated Feature
(15, 9), (16, 9), (17, 9), (18, 9), (19, 9),
(15, 10),
-- Best Supporting Actress
(5, 11), (1, 11), (13, 11), (4, 11), (12, 11),
(5, 12),
-- Best Supporting Actor
(1, 13), (2, 13), (6, 13), (4, 13), (9, 13),
(1, 14),
-- Best Original Screenplay
(3, 15), (5, 15), (7, 15), (14, 15), (8, 15),
(3, 16),
-- Best Adapted Screenplay
(2, 17), (4, 17), (1, 17), (9, 17), (10, 17),
(2, 18),
-- Best Documentary
(24, 19), (25, 19), (26, 19), (27, 19), (28, 19),
(24, 20),
-- Best Original Score
(1, 21), (2, 21), (29, 21), (6, 21), (9, 21),
(1, 22),
-- Best Original Song
(4, 23), (30, 23), (4, 23), (31, 23), (6, 23),
(4, 24),
-- Best International Film
(10, 25), (20, 25), (21, 25), (22, 25), (23, 25),
(10, 26),
-- Best Cinematography
(1, 27), (35, 27), (6, 27), (7, 27), (9, 27),
(1, 28),
-- Best Costume Design
(9, 29), (4, 29), (6, 29), (34, 29), (1, 29),
(9, 30),
-- Best Makeup and Hairstyling
(9, 31), (36, 31), (7, 31), (1, 31), (22, 31),
(9, 32),
-- Best Production Design
(9, 33), (4, 33), (6, 33), (34, 33), (1, 33),
(9, 34),
-- Best Sound
(10, 35), (32, 35), (7, 35), (33, 35), (1, 35),
(10, 36),
-- Best Visual Effects
(37, 37), (32, 37), (38, 37), (33, 37), (34, 37),
(37, 38),
-- Best Film Editing
(1, 39), (3, 39), (5, 39), (6, 39), (9, 39),
(1, 40),
-- 2023 OSCARS:
-- Best Picture
(110, 41), (111, 41), (112, 41), (113, 41), (114, 41), (115, 41), 
(116, 41), (117, 41), (118, 41), (119, 41),
(110, 42),
-- Best Director
(110, 43), (113, 43), (115, 43), (116, 43), (118, 43),
(110, 44),
-- Best Actress
(110, 45),  (116, 45), (123, 45), (124, 45), (115, 45),
(110, 46),
-- Best Actor
(120, 47), (114, 47), (113, 47), (121, 47), (122, 47),
(120, 48),
-- Best Animated Feature
(128, 49), (129, 49), (130, 49), (131, 49), (132, 49),
(128, 50),
-- Best Supporting Actress
(110, 51), (126, 51), (120, 51), (113, 51), (110, 51),
(110, 52),
-- Best Supporting Actor
(110, 53), (113, 53), (125, 53), (115, 53), (113, 53),
(110, 54),
-- Best Original Screenplay
(110, 55), (113, 55), (115, 55), (116, 55), (118, 55),
(110, 56),
-- Best Adapted Screenplay
(119, 57), (111, 57), (127, 57), (122, 57), (117, 57),
(119, 58),
-- Best Documentary
(137, 59), (138, 59), (139, 59), (140, 59), (141, 59),
(137, 60),
-- Best Original Score
(111, 61), (142, 61), (113, 61), (110, 61), (115, 61),
(111, 62),
-- Best Original Song
(143, 63), (144, 63), (117, 63), (126, 63), (110, 63),
(143, 64),
-- Best International Film
(111, 65), (133, 65), (134, 65), (135, 65), (136, 65),
(111, 66),
-- Best Cinematography
(111, 67), (147, 67), (114, 67), (146, 67), (116, 67),
(111, 68),
-- Best Costume Design
(126, 69), (142, 69), (114, 69), (110, 69), (148, 69),
(126, 70),
-- Best Makeup and Hairstyling
(120, 71), (111, 71), (145, 71), (126, 71), (114, 71),
(120, 72),
-- Best Production Design
(111, 73), (112, 73), (142, 73), (114, 73), (115, 73),
(111, 74),
-- Best Sound
(117, 75), (111, 75), (112, 75), (145, 75), (114, 75),
(117, 76),
-- Best Visual Effects
(112, 77), (111, 77), (145, 77), (126, 77), (117, 77),
(112, 78),
-- Best Film Editing (fix noms and winner)
(110, 79), (113, 79), (114, 79), (116, 79), (117, 79),
(110, 80),
-- 2024 GOLDEN GLOBES:
-- Best Drama
(1, 81), (3, 81), (6, 81), (7, 81), (8, 81), (10, 81),
(1, 82),
-- Best Musical/Comedy
(9, 83), (65, 83), (2, 83), (4, 83), (5, 83), (14, 83),
(9, 84),
-- Best Actor Drama
(1, 85), (7, 85), (6, 85), (11, 85), (46, 85), (47, 85),
(1, 86),
-- Best Actress Drama
(6, 87),  (12, 87), (3, 87), (8, 87), (7, 87), (66, 87),
(6, 88),
-- Best Actor Musical/Comedy
(5, 89), (71, 89), (40, 89), (65, 89), (72, 89), (2, 89),
(5, 90),
-- Best Actress Musical/Comedy
(9, 91), (13, 91), (83, 91), (14, 91), (84, 91), (4, 91),
(9, 92),
-- Best Director
(1, 93), (7, 93), (4, 93), (9, 93), (6, 93), (8, 93),
(1, 94),
-- Best Animated Feature
(15, 95), (16, 95), (19, 95), (43, 95), (52, 95), (87, 95),
(15, 96),
-- Best Supporting Actress
(5, 97), (1, 97), (13, 97), (12, 97), (14, 97), (46, 97),
(5, 98),
-- Best Supporting Actor
(1, 99), (9, 99), (6, 99), (4, 99), (14, 99), (9, 99),
(1, 100),
-- Best Screenplay
(3, 101), (4, 101), (9, 101), (1, 101), (6, 101), (8, 101),
(3, 102),
-- Best Original Score
(1, 103), (9, 103), (15, 103), (10, 103), (19, 103), (6, 103),
(1, 104),
-- Best Original Song
(4, 105), (88, 105), (4, 105), (4, 105), (52, 105), (11, 105),
(4, 106),
-- Best International Film
(3, 107), (84, 107), (20, 107), (8, 107), (22, 107), (10, 107),
(3, 108),
-- 2023 GOLDEN GLOBES:
-- Best Drama
(115, 109), (112, 109), (114, 109), (116, 109), (117, 109),
(115, 110),
-- Best Musical/Comedy
(113, 111), (142, 111), (110, 111), (127, 111), (118, 111),
(113, 112),
-- Best Actor Drama
(114, 113), (120, 113), (234, 113), (122, 113), (235, 113),
(114, 114),
-- Best Actress Drama
(116, 115),  (146, 115), (195, 115), (123, 115), (115, 115),
(116, 116),
-- Best Actor Musical/Comedy
(113, 117), (142, 117), (127, 117), (236, 117), (215, 117),
(113, 118),
-- Best Actress Musical/Comedy
(110, 119), (148, 119), (142, 119), (215, 119), (237, 119),
(110, 120),
-- Best Director
(115, 121), (112, 121), (110, 121), (114, 121), (113, 121),
(115, 122),
-- Best Animated Feature
(128, 123), (238, 123), (129, 123), (130, 123), (132, 123),
(128, 124),
-- Best Supporting Actress
(126, 125), (113, 125), (110, 125), (118, 125), (214, 125),
(126, 126),
-- Best Supporting Actor
(110, 127), (113, 127), (113, 127), (142, 127), (208, 127),
(110, 128),
-- Best Screenplay
(113, 129), (116, 129), (110, 129), (119, 129), (115, 129),
(113, 130),
-- Best Original Score
(142, 131), (113, 131), (128, 131), (119, 131), (115, 131),
(142, 132),
-- Best Original Song
(143, 133), (179, 133), (128, 133), (117, 133), (126, 133),
(143, 134),
-- Best International Film
(133, 135), (111, 135), (134, 135), (239, 135), (143, 135),
(133, 136),
-- 2024 Razzies:
-- Worst Picture
(100, 137), (50, 137), (53, 137), (101, 137), (61, 137),
(100, 138),
-- Worst Actor
(102, 139), (73, 139), (75, 139), (103, 139), (101, 139),
(102, 140),
-- Worst Actress
(104, 141), (103, 141), (105, 141), (106, 141), (61, 141),
(104, 142),
-- Worst Director
(100, 143),  (50, 143), (56, 143), (53, 143), (101, 143),
(100, 144),
-- Worst Supporting Actor
(53, 145), (56, 145), (107, 145), (56, 145), (73, 145),
(53, 146),
-- Worst Supporting Actress
(53, 147), (108, 147), (104, 147), (61, 147), (109, 147),
(53, 148),
-- Worst Screenplay
(100, 149), (50, 149), (53, 149), (29, 149), (61, 149),
(100, 150),
-- Worst Prequel/Remake/Sequel
(100, 151), (56, 151), (50, 151), (53, 151), (29, 151),
(100, 152),
-- Worst Screen Combo
(100, 153), (53, 153), (50, 153), (103, 153), (105, 153),
(100, 154),
-- 2023 Razzies (Need to fix all the "winners"):
-- Worst Picture
(123, 155), (192, 155), (240, 155), (151, 155), (161, 155),
(123, 156),
-- Worst Actor
(161, 157), (240, 157), (241, 157), (192, 157), (242, 157),
(161, 158),
-- Worst Actress
(173, 159), (243, 159), (151, 159), (244, 159),
-- (104, 160),  Razzies chosen as winner for shaming a little girl
-- Worst Director
(240, 161),  (162, 161), (123, 161), (161, 161), (192, 161),
(240, 162),
-- Worst Supporting Actor
(114, 163), (240, 163), (123, 163), (240, 163), (123, 163),
(114, 164),
-- Worst Supporting Actress
(161, 165), (245, 165), (151, 165), (192, 165), (245, 165), (246, 165),
(161, 166),
-- Worst Screenplay
(123, 167), (192, 167), (240, 167), (173, 167), (161, 167),
(123, 168),
-- Worst Prequel/Remake/Sequel
(192, 169), (247, 169), (248, 169), (123, 169), (172, 169), (173, 169),
(192, 170),
-- Worst Screen Combo
(114, 171), (240, 171), (123, 171), (123, 171), (247, 171), (248, 171),
(114, 172),
-- 2024 SAG AWARDS:
-- Best Ensemble
(1, 173), (2, 173), (4, 173), (13, 173), (6, 173),
(1, 174),
-- Best Actress
(6, 175), (12, 175), (7, 175), (4, 175), (9, 175),
(6, 176),
-- Best Actor
(1, 177), (7, 177), (11, 177), (5, 177), (2, 177),
(1, 178),
-- Best Supporting Actress
(5, 179), (1, 179), (13, 179), (89, 179), (12, 179),
(5, 180),
-- Best Supporting Actor
(1, 181), (2, 181), (9, 181), (6, 181), (4, 181),
(1, 182),
-- Best Stunts
(33, 183), (4, 183), (38, 183), (29, 183), (62, 183),
(33, 184),
-- 2023 SAG AWARDS:
-- Best Ensemble
(110, 185), (142, 185), (113, 185), (115, 185), (119, 185),
(110, 186),
-- Best Actress
(110, 187), (116, 187), (195, 187), (123, 187), (206, 187),
(110, 188),
-- Best Actor
(120, 189), (114, 189), (113, 189), (122, 189), (228, 189),
(120, 190),
-- Best Supporting Actress
(110, 191), (126, 191), (120, 191), (113, 191), (110, 191),
(110, 192),
-- Best Supporting Actor
(110, 193), (115, 193), (113, 193), (113, 193), (208, 193),
(110, 194),
-- Best Stunts
(117, 195), (112, 195), (145, 195), (126, 195), (195, 195),
(117, 196),
-- 2024 DGA AWARDS:
-- Best Director Theatrical Film
(1, 197), (4, 197), (9, 197), (5, 197), (6, 197),
(1, 198),
-- Best First-Time Director
(8, 199), (2, 199), (93, 199), (94, 199), (95, 199),
(8, 200),
-- Best Director Documentary
(24, 201), (25, 201), (90, 201), (91, 201), (92, 201),
(24, 202),
-- 2023 DGA AWARDS:
-- Best Director Theatrical Film
(110, 203), (116, 203), (117, 203), (113, 203), (115, 203),
(110, 204),
-- Best First-Time Director
(121, 205), (224, 205), (225, 205), (226, 205), (190, 205),
(121, 206),
-- Best Director Documentary
(140, 207), (227, 207), (139, 207), (137, 207), (138, 207),
(140, 208),
-- 2024 WGA AWARDS:
-- Best Original Screenplay
(65, 209), (4, 209), (5, 209), (14, 209), (8, 209),
-- (, 210), NO WINNER YET
-- Best Adapted Screenplay
(2, 211), (74, 211), (6, 211), (12, 211), (1, 211),
-- (, 212), NO WINNER YET
-- Best Documentary Screenplay
(96, 213), (97, 213), (98, 213), (99, 213),
-- (, 214), NO WINNER YET
-- 2023 WGA AWARDS:
-- Best Original Screenplay
(110, 215), (115, 215), (215, 215), (181, 215), (116, 215),
(110, 216),
-- Best Adapted Screenplay
(119, 217), (126, 217), (127, 217), (214, 217), (117, 217),
(119, 218),
-- Best Documentary Screenplay
(229, 219), (233, 219), (231, 219), (232, 219), (230, 219),
(229, 220),
-- 2024 CRITICS CHOICE AWARDS:
-- Best Picture
(1, 221), (2, 221), (4, 221), (13, 221), (5, 221), (6, 221), (7, 221),
(8, 221), (9, 221), (46, 221),
(1, 222),
-- Best Director
(1, 223), (7, 223), (4, 223), (9, 223), (5, 223), (6, 223),
(1, 224),
-- Best Actress
(9, 225), (6, 225), (3, 225), (8, 225), (7, 225), (4, 225),
(9, 226),
-- Best Actor
(5, 227), (7, 227), (6, 227), (11, 227), (1, 227), (2, 227),
(5, 228),
-- Best Supporting Actress
(5, 229), (1, 229), (13, 229), (4, 229), (12, 229), (14, 229),
(5, 230),
-- Best Supporting Actor
(1, 231), (2, 231), (6, 231), (4, 231), (14, 231), (9, 231),
(1, 232),
-- Best Acting Ensemble
(1, 233), (65, 233), (4, 233), (13, 233), (5, 233), (6, 233),
(1, 234),
-- Best Original Screenplay
(4, 235), (14, 235), (65, 235), (7, 235), (5, 235), (8, 235),
(4, 236),
-- Best Adaptec Screenplay
(2, 237), (74, 237), (47, 237), (9, 237), (1, 237), (6, 237),
(2, 238),
-- 2023 CRITICS CHOICE AWARDS:
-- Best Picture
(110, 239), (112, 239), (142, 239), (113, 239), (114, 239), (115, 239), 
(127, 239), (143, 239), (116, 239), (117, 239), (119, 239),
(110, 240),
-- Best Director
(110, 241), (112, 241), (142, 241), (116, 241), (114, 241), (113, 241),
(119, 241), (195, 241), (143, 241), (115, 241),
(110, 242),
-- Best Actress
(116, 243), (195, 243), (206, 243), (142, 243), (115, 243), (110, 243),
(116, 244),
-- Best Actor
(120, 245), (114, 245), (117, 245), (113, 245), (121, 245), (122, 245),
(120, 246),
-- Best Supporting Actress
(126, 247), (119, 247), (113, 247), (110, 247), (110, 247), (127, 247),
(126, 248),
-- Best Supporting Actor
(110, 249), (115, 249), (113, 249), (125, 249), (115, 249), (113, 249),
(110, 250),
-- Best Acting Ensemble
(127, 251), (113, 251), (110, 251), (115, 251), (195, 251), (119, 251),
(127, 252),
-- Best Original Screenplay
(110, 253), (116, 253), (115, 253), (113, 253), (121, 253),
(110, 254),
-- Best Adaptec Screenplay
(119, 255), (120, 255), (122, 255), (127, 255), (214, 255),
(119, 256);


-- INSERT INTO films_noms (film_id, nom_points_id)
-- VALUES
-- (1, 1),
-- (2, 1),
-- (5, 1),
-- (6, 1),
-- (1, 2),
-- (5, 2),
-- (1, 3),
-- (26, 3),
-- (5, 4),
-- (11, 4),
-- (15, 8),
-- (11, 8);

-- INSERT INTO films_wins (film_id, win_points_id)
-- VALUES
-- (5, 1),
-- (5, 2),
-- (1, 3),
-- (5, 4),
-- (11, 8);





-- Adding test users to test groups
INSERT INTO groups_users (group_id, user_id, is_admin)
VALUES
(1, 1, TRUE),
(1, 2, FALSE),
(1, 3, FALSE),
(1, 4, FALSE),
(2, 3, TRUE),
(2, 4, FALSE);





-- Giving test users starter films
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