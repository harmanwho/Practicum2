


show global variables like 'local_infile';
 set global local_infile=true;
 
LOAD DATA LOCAL INFILE '/Users/harmansidhu/Documents/DBMS/Practicums/imdbData/title.basics.tsv'
INTO TABLE titleBasics
FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\n';

LOAD DATA 
	LOCAL INFILE '/Users/harmansidhu/Documents/DBMS/Practicums/imdbData/title.basics.tsv'
	INTO TABLE titleDates
	FIELDS TERMINATED BY '\t'
	LINES TERMINATED BY '\n'
	IGNORE 1 LINES
    (@tconst, @startYear, @endYear)
    set
		tconst = @tconst,
        startYear = @startYear,
        endYear = @endYear;


LOAD DATA LOCAL INFILE '/Users/harmansidhu/Documents/DBMS/Practicums/imdbData/title.ratings.tsv'
INTO TABLE titleRatings
FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\n';


LOAD DATA LOCAL INFILE '/Users/harmansidhu/Documents/DBMS/Practicums/imdbData/title.episode.tsv'
INTO TABLE titleEpisodes
FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\n';

LOAD DATA LOCAL INFILE '/Users/harmansidhu/Documents/DBMS/Practicums/imdbData/name.basics.tsv'
INTO TABLE nameBasics
FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\n';

ALTER TABLE titleDates MODIFY startYear INT;
ALTER TABLE titleDates MODIFY endYear INT;

SELECT * FROM titleBasics;

DELETE FROM titleDates;
DELETE FROM titleEpisodes;
DELETE FROM titleRatings;

SELECT * FROM titleDates;

SELECT * FROM titleRatings;

SELECT * FROM titleEpisodes;

SELECT * FROM nameBasics;

ALTER TABLE nameBasics MODIFY primaryName VARCHAR(256) AFTER nconst;

DELETE FROM titleBasics LIMIT 1;
DELETE FROM nameBasics LIMIT 1;
DELETE FROM nameBasics;

