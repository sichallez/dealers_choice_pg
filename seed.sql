DROP TABLE IF EXISTS players;
DROP TABLE IF EXISTS rankings;

CREATE TABLE rankings (
    id SERIAL PRIMARY KEY,
    ranking INTEGER UNIQUE DEFAULT NULL,
    name VARCHAR(50) DEFAULT NULL,
    country VARCHAR(50) DEFAULT NULL,
    age INTEGER DEFAULT NULL,
    point INTEGER DEFAULT NULL
);

CREATE TABLE players (
    id SERIAL PRIMARY KEY,
    rankingId INTEGER REFERENCES rankings(ranking) NOT NULL,
    weight VARCHAR(50) DEFAULT NULL,
    height VARCHAR(50) DEFAULT NULL,
    ageDate VARCHAR(50) DEFAULT NULL,
    birthplace VARCHAR(50) DEFAULT NULL,
    plays VARCHAR(200) DEFAULT NULL,
    coach VARCHAR(100) DEFAULT NULL
);

/* TRUNCATE TABLE rankings, players; */

INSERT INTO rankings (ranking, name, country, age, point) VALUES (1, 'Novak Djokovic', 'Serbia (SRB)', 34, 10875);
INSERT INTO rankings (ranking, name, country, age, point) VALUES (2, 'Daniil Medvedev', 'Russia (RUS)', 25, 9635);
INSERT INTO rankings (ranking, name, country, age, point) VALUES (5, 'Rafael Nadal', 'Spain (ESP)', 35, 6875);
INSERT INTO rankings (ranking, name, country, age, point) VALUES (30, 'Roger Federer', 'Switzerland', 40, 1665);

INSERT INTO players (rankingId, weight, height, ageDate, birthplace, plays, coach) VALUES ((SELECT ranking FROM rankings WHERE name='Novak Djokovic'), '170 lbs(77 kg)', '6''2"(188cm)', '34 (1987.05.22)', 'Belgrade, Serbia', 'Right-Handed, Two-Handed Backhand', 'Marian Vajda, Goran Ivanisevic');
INSERT INTO players (rankingId, weight, height, ageDate, birthplace, plays, coach) VALUES ((SELECT ranking FROM rankings WHERE name='Daniil Medvedev'), '182 lbs(83 kg)', '6''6"(198cm)', '25 (1996.02.11)', 'Moscow, Russia', 'Right-Handed, Two-Handed Backhand', 'Ivan Ljubicic, Gilles Cervara');
INSERT INTO players (rankingId, weight, height, ageDate, birthplace, plays, coach) VALUES ((SELECT ranking FROM rankings WHERE name='Rafael Nadal'), '187 lbs(85 kg)', '6''1"(185cm)', '35 (1986.06.03)', 'Manacor, Mallorca, Spain', 'Left-Handed, Two-Handed Backhand', 'Carlos Moya, Francisco Roig, Marc Lopez');
INSERT INTO players (rankingId, weight, height, ageDate, birthplace, plays, coach) VALUES ((SELECT ranking FROM rankings WHERE name='Roger Federer'), '187 lbs(85 kg)', '6''1"(185cm)', '40 (1981.08.08)', 'Basel, Switzerland', 'Right-Handed, One-Handed Backhand', 'Ivan Ljubicic, Severin Luthi');

