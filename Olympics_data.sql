--Identify the sport which was played in all summer olympics.
WITH t1 AS
  (SELECT DISTINCT sport,games                   
   FROM athlete_events
   ORDER BY games),
     t2 AS
  (SELECT COUNT(DISTINCT games) AS num_games
   FROM athlete_events
   WHERE season = 'Summer')
SELECT sport,
       COUNT(sport) AS frequency
FROM t1
GROUP BY sport
HAVING COUNT(sport) =
  (SELECT num_games
   FROM t2);

--Athletes with the most gold medals
SELECT name,
       count(medal) AS no_of_medals
FROM athlete_events
GROUP BY name
ORDER BY no_of_medals DESC

---Find the Ratio of male and female athletes participated in all olympic games.
WITH participation AS
  (SELECT games,
          count(*) AS total,
          count(CASE
                    WHEN sex = 'M' THEN 1
                END)AS Males,
          count(CASE
                    WHEN sex = 'F' THEN 1
                END) AS Females
   FROM athlete_events
   GROUP BY games)
SELECT games,
       total,
       males,
       females,
       ROUND((CAST(males AS NUMERIC)/total)*100, 2) AS ratio_males,
       ROUND((CAST(females AS NUMERIC)/total)*100, 2) AS ratio_females
FROM participation
ORDER BY ratio_females DESC;

--Fetch the top 5 most successful countries in olympics. Success is defined by no of medals won
SELECT region,
       count(medal)
FROM athlete_events a
INNER JOIN noc_regions n ON a.noc = n.noc
GROUP BY n.region
ORDER BY COUNT DESC
LIMIT 5;

--Ages in the Olympics
SELECT MIN(age::numeric) AS min_age,
       MAX(age::numeric) AS max_age,
       AVG(age::numeric) AS avg_age
FROM athlete_events
WHERE age != 'NA' ;

-- Fetch details of the oldest athletes to win a gold medal.
SELECT *
FROM athlete_events
WHERE is_numeric(age) AND age::numeric = (SELECT MAX(age::numeric) FROM athlete_events WHERE medal = 'Gold');
SELECT MAX(age::integer) FROM athlete_events where medal = 'Gold'

--Number of appearances by African Countries
WITH t1 AS
  (SELECT DISTINCT games,
                   noc
   FROM athlete_events)
SELECT c.name,
       count(t1.noc) AS number_of_appearances
FROM t1
INNER JOIN noc_regions n ON t1.noc = n.noc
INNER JOIN continents c ON n.region = c.name
WHERE c.region = 'Africa'
GROUP BY c.name
ORDER BY number_of_appearances DESC;