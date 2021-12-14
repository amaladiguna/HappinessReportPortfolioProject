SELECT *
from HAPPY2015 H2015
INNER JOIN HAPPY2016 H2016 on H2015.COUNTRY = H2016.COUNTRY
INNER JOIN HAPPY2017 H2017 on H2016.COUNTRY = H2017.COUNTRY
INNER JOIN HAPPY2018 H2018 on H2016.COUNTRY = H2018.COUNTRY_OR_REGION
INNER JOIN HAPPY2019 H2019 on H2016.COUNTRY = H2019.COUNTRY_OR_REGION

-- Happiness Scores From 2019 to Visualize
SELECT COUNTRY, HAPPINESS_SCORE FROM HAPPY2015

SELECT COUNTRY FROM HAPPY2015 WHERE REGION = 'Sub-Saharan Africa'

SELECT DISTINCT REGION FROM HAPPY2015

-- Get countries' AVG Happiness and AVG GDP
-- Manual AVG because multiple databases

SELECT H2015.COUNTRY,
           (H2015.HAPPINESS_SCORE+H2016.HAPPINESS_SCORE+H2017.HAPPINESSSCORE+H2018.SCORE+H2019.SCORE)/4 score,
           (H2015.ECONOMY_GDP_PER_CAPITA+H2016.ECONOMY_GDP_PER_CAPITA+H2017.ECONOMYGDPPERCAPITA+H2018.GDP_PER_CAPITA+H2019.GDP_PER_CAPITA)/4
            AS "GDP Per Capita"
    FROM HAPPY2015 H2015
    INNER JOIN HAPPY2016 H2016 on H2015.COUNTRY = H2016.COUNTRY
    INNER JOIN HAPPY2017 H2017 on H2016.COUNTRY = H2017.COUNTRY
    INNER JOIN HAPPY2018 H2018 on H2016.COUNTRY = H2018.COUNTRY_OR_REGION
    INNER JOIN HAPPY2019 H2019 on H2016.COUNTRY = H2019.COUNTRY_OR_REGION

-- Get countries' AVG Change in Happiness and AVG Change in Income
-- Manual AVG because multiple Databases

WITH CTE_COUNTRY_SUM_SCORE_GDP AS (
    SELECT H2015.COUNTRY,
           H2015.HAPPINESS_SCORE+H2016.HAPPINESS_SCORE+H2017.HAPPINESSSCORE+H2018.SCORE+H2019.SCORE score,
           H2015.ECONOMY_GDP_PER_CAPITA+H2016.ECONOMY_GDP_PER_CAPITA+H2017.ECONOMYGDPPERCAPITA+H2018.GDP_PER_CAPITA+H2019.GDP_PER_CAPITA
            AS "GDP Per Capita"
    FROM HAPPY2015 H2015
    INNER JOIN HAPPY2016 H2016 on H2015.COUNTRY = H2016.COUNTRY
    INNER JOIN HAPPY2017 H2017 on H2016.COUNTRY = H2017.COUNTRY
    INNER JOIN HAPPY2018 H2018 on H2016.COUNTRY = H2018.COUNTRY_OR_REGION
    INNER JOIN HAPPY2019 H2019 on H2016.COUNTRY = H2019.COUNTRY_OR_REGION
)
SELECT COUNTRY, score/3, "GDP Per Capita"/3 FROM CTE_COUNTRY_SUM_SCORE_GDP

-- Average National Participation 2015-2019
WITH CTE_PARTICIPATION AS (
    SELECT '2015' Year,COUNT(*) Participants
        FROM HAPPY2015
    UNION
    SELECT '2016' Year,COUNT(*) Participants
        FROM HAPPY2016
    UNION
    SELECT '2017' Year, COUNT(*) Participants
        FROM HAPPY2017
    UNION
    SELECT '2018' Year, COUNT(*) Participants
        FROM HAPPY2018
    UNION
    SELECT '2019' Year, COUNT(*) Participants
        FROM HAPPY2019
)
SELECT AVG(Participants) "Average National Participants" FROM CTE_PARTICIPATION

-- Average Change in Income and Average Change in Happiness
SELECT H2015.COUNTRY, (H2016.ECONOMY_GDP_PER_CAPITA-H2015.ECONOMY_GDP_PER_CAPITA+
       H2017.ECONOMYGDPPERCAPITA-H2016.ECONOMY_GDP_PER_CAPITA +
       H2018.GDP_PER_CAPITA-H2017.ECONOMYGDPPERCAPITA+
       H2019.GDP_PER_CAPITA-H2018.GDP_PER_CAPITA)/4 "AVG GDP PER CAPITA",
       (H2016.HAPPINESS_SCORE-H2015.HAPPINESS_SCORE+
       H2017.HAPPINESSSCORE-H2016.HAPPINESS_SCORE+
       H2018.SCORE-H2017.HAPPINESSSCORE+
       H2019.SCORE-H2018.SCORE)/4 "AVG HAPPINESS SCORE"
from HAPPY2015 H2015
INNER JOIN HAPPY2016 H2016 on H2015.COUNTRY = H2016.COUNTRY
INNER JOIN HAPPY2017 H2017 on H2016.COUNTRY = H2017.COUNTRY
INNER JOIN HAPPY2018 H2018 on H2016.COUNTRY = H2018.COUNTRY_OR_REGION
INNER JOIN HAPPY2019 H2019 on H2016.COUNTRY = H2019.COUNTRY_OR_REGION