show databases;
USE practicum2;

CREATE TABLE titleBasics (
    tconst VARCHAR(256) PRIMARY KEY,
    titleType VARCHAR(256),
    primaryTitle VARCHAR(256),
    originalTitle VARCHAR(256),
    isAdult BOOLEAN,
    runtimeMinutes INT
);

CREATE TABLE titleGenres (
	tconst VARCHAR(256),
    genre VARCHAR(256),
    CONSTRAINT tconst_fk FOREIGN KEY (tconst) REFERENCES titleBasics (tconst)
);

CREATE TABLE titleRatings (
	tconst VARCHAR(256),
    averageRating FLOAT,
    numVotes INT,
    CONSTRAINT rating_fk FOREIGN KEY (tconst) REFERENCES titleBasics (tconst)
);

CREATE TABLE titleDates (
	tconst VARCHAR(256),
    startyear INT,
    endyear INT,
    CONSTRAINT titleDates_fk FOREIGN KEY (tconst) REFERENCES titleBasics (tconst)
);

CREATE TABLE titleEpisodes (
	tconst VARCHAR(256),
    parentTconst VARCHAR(256),
    seasonRating INT,
    episodeNumber INT,
    CONSTRAINT episodesParentFK FOREIGN KEY (parentTconst) REFERENCES titleBasics (tconst)
);

CREATE TABLE titleCrew (
	tconst VARCHAR(256),
    crewID INT PRIMARY KEY AUTO_INCREMENT,
    CONSTRAINT crew_fk FOREIGN KEY (tconst) REFERENCES titleBasics (tconst)
);

CREATE TABLE titleWriters (
	tconst VARCHAR(256),
    crewID INT,
    writer VARCHAR(256),
    CONSTRAINT writerTitle_fk FOREIGN KEY (tconst) REFERENCES titleCrew (tconst),
	CONSTRAINT writerCrew_fk FOREIGN KEY (crewID) REFERENCES titleCrew (crewID)
);

CREATE TABLE titleDirectors (
	tconst VARCHAR(256),
    crewID INT,
    director VARCHAR(256),
    CONSTRAINT directorTitle_fk FOREIGN KEY (tconst) REFERENCES titleCrew (tconst),
	CONSTRAINT directorCrew_fk FOREIGN KEY (crewID) REFERENCES titleCrew (crewID)
);

CREATE TABLE titleAkas (
	titleId VARCHAR(256),
    ordering INT,
    title VARCHAR(256),
    language VARCHAR(256),
    types VARCHAR(256),
    attributes VARCHAR(256),
    isOriginalTitle BOOLEAN,
    CONSTRAINT akasTitle_fk FOREIGN KEY (titleId) REFERENCES titleBasics (tconst)
);

CREATE TABLE titlePrincipals (
	tconst VARCHAR(256),
    ordering INT,
    nconst VARCHAR(256),
    category VARCHAR(256),
    job VARCHAR(256),
    CONSTRAINT principalsTitle_fk FOREIGN KEY (tconst) REFERENCES titleBasics (tconst),
    CONSTRAINT principalsName_fk FOREIGN KEY (nconst) REFERENCES nameBasics (nconst)
);

CREATE TABLE principalCharacters (
	tconst VARCHAR(256),
    nconst VARCHAR(256),
    charPlayed VARCHAR(256),
    CONSTRAINT charTitle_fk FOREIGN KEY (tconst) REFERENCES titlePrincipals (tconst),
    CONSTRAINT charName_fk FOREIGN KEY (nconst) REFERENCES titlePrincipals (nconst)
);

CREATE TABLE nameBasics (
    nconst VARCHAR(256) PRIMARY KEY,
    birthYear INT,
    deathYear INT,
    primaryName VARCHAR(256),
    age INT
);

CREATE TABLE nameTitles (
	nconst VARCHAR(256),
    knownForTitle VARCHAR(256),
    numTitleCount int,
    CONSTRAINT nameTitles_fk FOREIGN KEY (nconst) REFERENCES nameBasics (nconst)
);

CREATE TABLE nameProfession (
	nconst VARCHAR(256),
    primaryProfession VARCHAR(256),
    CONSTRAINT professionTitles_fk FOREIGN KEY (nconst) REFERENCES nameBasics (nconst)
);

show tables;