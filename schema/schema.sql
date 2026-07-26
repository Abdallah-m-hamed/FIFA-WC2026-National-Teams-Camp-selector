PRAGMA foreign_keys = ON;
CREATE TABLE Country (
    id       INTEGER PRIMARY KEY AUTOINCREMENT,
    name     TEXT NOT NULL UNIQUE,
    avg_temp REAL NOT NULL,
    offset   INTEGER NOT NULL
);
CREATE TABLE Airport (
    id        INTEGER PRIMARY KEY AUTOINCREMENT,
    name      TEXT NOT NULL UNIQUE,
    latitude  REAL NOT NULL CHECK (latitude  BETWEEN -90  AND 90),
    longitude REAL NOT NULL CHECK (longitude BETWEEN -180 AND 180),
    country   TEXT NOT NULL,
    region    TEXT
);
CREATE TABLE Facility (
    id            INTEGER PRIMARY KEY AUTOINCREMENT,
    name          TEXT NOT NULL UNIQUE,
    city_display  TEXT NOT NULL,
    latitude      REAL NOT NULL CHECK (latitude  BETWEEN -90  AND 90),
    longitude     REAL NOT NULL CHECK (longitude BETWEEN -180 AND 180),
    facility_type TEXT NOT NULL CHECK (facility_type IN ('academy', 'mls', 'university'))
);
CREATE TABLE Flight (
    id                      INTEGER PRIMARY KEY AUTOINCREMENT,
    origin_airport_id       INTEGER NOT NULL REFERENCES Airport(id) ON DELETE RESTRICT,
    destination_airport_id  INTEGER NOT NULL REFERENCES Airport(id) ON DELETE RESTRICT,
    distance                REAL NOT NULL CHECK (distance > 0),
    duration                REAL NOT NULL CHECK (duration > 0),
    CHECK (origin_airport_id != destination_airport_id)
);
CREATE TABLE Venue (
    id              INTEGER PRIMARY KEY AUTOINCREMENT,
    host_city_name  TEXT NOT NULL,
    stadium_name    TEXT NOT NULL UNIQUE,
    avg_temp        REAL,
    offset          INTEGER,
    country_id      INTEGER NOT NULL REFERENCES Country(id) ON DELETE RESTRICT,
    latitude        REAL NOT NULL CHECK (latitude  BETWEEN -90  AND 90),
    longitude       REAL NOT NULL CHECK (longitude BETWEEN -180 AND 180)
);
CREATE TABLE Assignment (
    id          INTEGER PRIMARY KEY AUTOINCREMENT,
    country_id  INTEGER NOT NULL UNIQUE REFERENCES Country(id) ON DELETE CASCADE,
    facility_id INTEGER NOT NULL UNIQUE REFERENCES Facility(id) ON DELETE CASCADE
);
CREATE TABLE Match (
    id         INTEGER PRIMARY KEY AUTOINCREMENT,
    team_a_id  INTEGER NOT NULL REFERENCES Country(id) ON DELETE RESTRICT,
    team_b_id  INTEGER NOT NULL REFERENCES Country(id) ON DELETE RESTRICT,
    venue_id   INTEGER NOT NULL REFERENCES Venue(id) ON DELETE RESTRICT,
    group_name TEXT,
    stage      TEXT NOT NULL,
    CHECK (team_a_id != team_b_id)
);
