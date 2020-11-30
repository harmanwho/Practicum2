USE testRImdb;
USE test2;

Show tables;

SELECT * FROM titleBasics;
SELECT * FROM titleRatings;
SELECT * FROM titleGenre;
SELECT * FROM juncTitleGenre;
SELECT * FROM nameBasics;
SELECT * FROM nameProfession;

SELECT * FROM crewRoles;


SELECT * FROM juncNameTitles;


SELECT * FROM titleGenre;

DROP TABLE titleGenres;

CREATE TABLE titleGenre (
	genreID INT PRIMARY KEY AUTO_INCREMENT,
    genre VARCHAR(256)
);

ALTER TABLE titleBasics MODIFY startYear SMALLINT;

ALTER TABLE titleBasics MODIFY endYear SMALLINT;

ALTER TABLE nameBasics MODIFY birthYear SMALLINT;

ALTER TABLE nameBasics MODIFY deathYear SMALLINT;


ALTER TABLE titleBasics MODIFY originalTitle VARCHAR(256);


ALTER TABLE titleBasics MODIFY isAdult INT;


ALTER TABLE titleBasics MODIFY runtimeMinutes INT;

DELETE from titleBasics;
DELETE from nameBasics;

DELETE from titleGenre;

SELECT * FROM nameBasics;
UPDATE nameBasics SET age =0;

UPDATE nameBasics
SET age = CASE
		WHEN deathYear IS NULL THEN YEAR(CURRENT_TIMESTAMP) - birthYear + 1
        ELSE deathYear - birthYear + 1
	END;

SELECT jn.nconst,count(*) FROM juncNameTitles as jn GROUP BY jn.nconst;

UPDATE nameBasics as n
INNER JOIN juncNameTitles as j ON n.nconst = j.nconst
SET n.numTitlesCount = n.nconst;
 

SET n.numTitlesCount = 0;

UPDATE nameBasics as n
SET numTitlesCount = (
	SELECT count(*)
	FROM juncNameTitles as j
    WHERE j.nconst = n.nconst
);

UPDATE nameBasics AS t
INNER JOIN (
  SELECT s.nconst, COUNT(*) AS count
  FROM juncNameTitles AS s
  -- WHERE s.custom_condition IS (true)
  GROUP BY s.nconst
) AS aggregate ON aggregate.nconst = t.nconst
SET t.numTitlesCount = aggregate.count;

SHOW ENGINE INNODB STATUS;

UPDATE nameBasics as n,
(SELECT nb.nconst as id, count(*) AS count
FROM juncNameTitles as jn
INNER JOIN nameBasics as nb
	ON jn.nconst = nb.nconst
GROUP BY nb.nconst) AS t
SET n.numTitlesCount = t.count
WHERE n.nconst = id;


SELECT nb.nconst, count(*)
FROM juncNameTitles as jn
INNER JOIN nameBasics as nb
	ON jn.nconst = nb.nconst
GROUP BY nb.nconst;

SELECT * FROM juncNameTitles;

SHOW FULL PROCESSLIST;



SELECT * FROM nameBasics;

DELIMITER //
CREATE TRIGGER after_nameBasics_age
BEFORE INSERT ON nameBasics
FOR EACH ROW
BEGIN
	IF NEW.deathYear IS NULL
	THEN SET NEW.age = YEAR(CURRENT_TIMESTAMP) - NEW.birthYear + 1;
	ELSE SET NEW.age = NEW.deathYear - NEW.birthYear + 1;
    END IF;
END //
DELIMITER ;


DELIMITER //
CREATE TRIGGER after_nameBasics_age
BEFORE INSERT ON nameBasics
FOR EACH ROW
BEGIN
    IF NEW.deathYear IS NULL
	THEN SET NEW.age = YEAR(CURRENT_TIMESTAMP) - NEW.birthYear + 1;
	ELSE SET NEW.age = NEW.deathYear - NEW.birthYear + 1;
    END IF;
END //
DELIMITER ;

DROP TRIGGER after_nameBasics_age;

SHOW TRIGGERS;

SELECT * FROM nameBasics WHERE nconst = 'nm1000001';

INSERT INTO nameBasics VALUES ('nm1000001', "Brad Pitt", 1983, NULL, NULL, NULL);

DROP VIEW actorAttView;

CREATE VIEW actorAttView AS
SELECT primaryName as Name, age as Age, (if(deathYear IS NULL, "FALSE", "TRUE")) as isDead, numTitlesCount as NumberOfMovies
FROM nameBasics;

UPDATE actorAttView2
SET isDead = IF(isDead IS NOT NULL, 0, 1);



SELECT * FROM actorAttView;

SELECT DISTINCT(titleType) FROM titleBasics;

SELECT t.parentTconst as Id, b.primaryTitle as Title, MAX(t.seasonNumber) as NumberOfSeasons
FROM titleEpisodes as t, titleBasics as b
WHERE t.parentTconst = b.tconst AND b.titleType = 'tvSeries'
GROUP BY t.parentTconst
ORDER BY t.parentTconst;

SELECT * FROM titleEpisodes as t, titleBasics as b 
WHERE b.primaryTitle ='Arthur Godfrey and His Friends' AND t.parentTconst = b.tconst;


SELECT *
FROM Orders
LEFT JOIN Customers
ON Orders.CustomerID
=
Customers.CustomerID
;

SELECT n.nconst, n.primaryName, i.numAboveAvgMovies
FROM nameBasics as n
INNER JOIN (
	SELECT j.nconst as id, COUNT(j.tconst) as numAboveAvgMovies
	FROM juncNameTitles as j
	INNER JOIN (
		SELECT t.tconst as titleID, t.averageRating, b.titleType as type
		FROM titleRatings as t
		RIGHT JOIN titleBasics as b
		ON t.tconst = b.tconst AND b.titleType = "movie"
		WHERE t.averageRating > ( SELECT avg(averageRating) FROM titleRatings )
	) AS m
	ON j.tconst = m.titleID
	GROUP BY j.nconst) as i
ON n.nconst = i.id AND i.numAboveAvgMovies > 2;




SELECT t.tconst, t.averageRating, b.titleType
FROM titleRatings as t, titleBasics as b
WHERE 
	t.averageRating > ( SELECT avg(averageRating) FROM titleRatings )
    AND
    b.titleType = 'movie'
ORDER BY t.averageRating;