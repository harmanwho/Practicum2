--
-- Database: `MediaIMDBPRac`
-- Create Tables acccording to the .tsv files
-- Load all the Tables with .tsv Data

-- --------------------------------------------------------

-- Main table - titleBasics --

--
-- Table - titleBasics | File - title.basics.tsv
--
CREATE TABLE titleBasics (
    tconst VARCHAR(256) PRIMARY KEY,
    titleType VARCHAR(256),
    primaryTitle VARCHAR(256),
    originalTitle VARCHAR(256),
    isAdult BOOLEAN,
    startYear YEAR,
    endYear YEAR,
    runtimeMinutes INT
);
SELECT * FROM titleBasics;

--
-- Table - titleGenre
--
CREATE TABLE titleGenre (
	genreID INT PRIMARY KEY AUTO_INCREMENT,
    genre VARCHAR(256)
);

SELECT * FROM titleGenre;

--
-- Table - juncTitleGenre 
--
CREATE TABLE juncTitleGenre (
	tconst VARCHAR(256),
    genreID INT,
    CONSTRAINT titleGenreFK FOREIGN KEY (tconst) REFERENCES titleBasics (tconst),
    CONSTRAINT genreFK FOREIGN KEY (genreID) REFERENCES titleGenre (genreID)
);

SELECT * FROM juncTitleGenre;

--
-- Table - titleRatings  | File - title.ratings.tsv
--
CREATE TABLE titleRatings (
	tconst VARCHAR(256),
    averageRating INT,
    numVotes INT,
    CONSTRAINT titleRatingFK FOREIGN KEY (tconst) REFERENCES titleBasics (tconst)
);

SELECT * FROM titleRatings;

--
-- Table - titleEpisodes  | File - title.episodes.tsv
--
CREATE TABLE titleEpisodes (
	tconst VARCHAR(256) PRIMARY KEY,
    parentTconst VARCHAR(256),
    seasonNumber INT,
    episodeNumber INT,
    CONSTRAINT titleEpisodeFK FOREIGN KEY (parentTconst) REFERENCES titleBasics (tconst)
);

SELECT * FROM titleEpisodes;

--
-- Table - crewRoles  | File - title.crew.tsv
--
CREATE TABLE crewRoles (
	roleID INT PRIMARY KEY AUTO_INCREMENT,
    role VARCHAR(256)
);

SELECT * FROM crewRoles;

--
-- Table - juncCrewRole 
--
CREATE TABLE juncCrewRole (
	tconst VARCHAR(256),
    nconst VARCHAR(256),
    roleID INT,
    CONSTRAINT titleCrewFK FOREIGN KEY (tconst) REFERENCES titleBasics (tconst),
    CONSTRAINT roleCrewFK FOREIGN KEY (roleID) REFERENCES crewRoles (roleID)
);

SELECT * FROM juncCrewRole;


-- Main table - nameBasics --

--
-- Table - nameBasics | File - name.basics.tsv
--
CREATE TABLE nameBasics (
	nconst VARCHAR(256) PRIMARY KEY,
	primaryName VARCHAR(256),
    birthYear YEAR,
    deathYear YEAR,
    age INT,
    numTitlesCount INT
);

SELECT * FROM nameBasics;

--
-- Table - juncNameTitles
--
CREATE TABLE juncNameTitles (
	nconst VARCHAR(256),
    tconst VARCHAR(256),
    CONSTRAINT nameFK FOREIGN KEY (nconst) REFERENCES nameBasics (nconst),
    CONSTRAINT titleFK FOREIGN KEY (tconst) REFERENCES titleBasics (tconst)
);

SELECT * FROM juncNameTitles;

CREATE TABLE nameProfession (
	professionID INT PRIMARY KEY AUTO_INCREMENT,
    primaryProfession VARCHAR(256)
);
SELECT * FROM nameProfession;

--
-- Table - juncNameProfession
--
CREATE TABLE juncNameProfession (
	nconst VARCHAR(256),
    professionID INT,
    CONSTRAINT nameProfessionFK FOREIGN KEY (nconst) REFERENCES nameBasics (nconst),
    CONSTRAINT professionFK FOREIGN KEY (professionID) REFERENCES nameProfession (professionID)
);

SELECT * FROM juncNameProfession;

--
-- Table - titlePrincipals | File - title.principals.tsv
--
CREATE TABLE titlePrincipals (
	tconst VARCHAR(256),
    ordering INT,
    nconst VARCHAR(256),
    category VARCHAR(256),
    job VARCHAR(256),
    characters VARCHAR(256),
    CONSTRAINT principalTitleFK FOREIGN KEY (tconst) REFERENCES titleBasics (tconst),
    CONSTRAINT principalNameFK FOREIGN KEY (nconst) REFERENCES nameBasics (nconst)
);

SELECT * FROM titlePrincipals;




-- NOT CREATED YET

--
-- Table - titleAkas  | File - title.akas.tsv
--
CREATE TABLE titleAkas (
	titleId VARCHAR(256),
    ordering INT,
    title VARCHAR(256),
    region VARCHAR(256),
    language VARCHAR(256),
    types VARCHAR(256),
    attributes VARCHAR(256),
    isOriginalTitle BOOLEAN,
    CONSTRAINT titleAkasFK FOREIGN KEY (titleId) REFERENCES titleBasics (tconst)
);

SELECT * FROM titleAkas;