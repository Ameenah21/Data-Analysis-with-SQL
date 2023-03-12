DROP TABLE IF EXISTS athlete_events;
CREATE TABLE IF NOT EXISTS athlete_events
(
    id          INT,
    name        VARCHAR,
    sex         VARCHAR,
    age         VARCHAR,
    height      VARCHAR,
    weight      VARCHAR,
    team        VARCHAR,
    noc         VARCHAR,
    games       VARCHAR,
    year        INT,
    season      VARCHAR,
    city        VARCHAR,
    sport       VARCHAR,
    event       VARCHAR,
    medal       VARCHAR
);

DROP TABLE IF EXISTS noc_regions;
CREATE TABLE IF NOT EXISTS noc_regions
(    noc         VARCHAR,
    region      VARCHAR,
    notes       VARCHAR
)