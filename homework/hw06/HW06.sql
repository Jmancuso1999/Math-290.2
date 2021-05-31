--HW06
--- Exercise 1: Logged in to PowerBi, completed
--- Exercise 2 
--- Create database and tables and copy command 
create database imdb

create table imdb.public.title_akas (
"titleId"  varchar,
"ordering" varchar,
"title" varchar,
"region" varchar,
"language" varchar,
"types" varchar,
"attributes" varchar,
"isOriginalTitle" varchar
);

copy  imdb.public.title_akas from '/Users/namishasingh/Downloads/title.akas.tsv' delimiter E'\t';


create table imdb.public.title_basics (
tconst varchar,
titleType varchar,
primaryTitle varchar,
originalTitle varchar,
isAdult varchar, 
startYear varchar, 
endYear varchar, 
runtimeMinutes varchar, 
genres varchar
);

copy  imdb.public.title_basics from '/Users/namishasingh/Downloads/title.basics.tsv' delimiter E'\t';


create table imdb.public.title_crew (
tconst varchar,
directors varchar,
writers varchar
);

copy  imdb.public.title_crew from '/Users/namishasingh/Downloads/title.crew.tsv' delimiter E'\t';

create table imdb.public.title_episode (
tconst varchar, 
parentTconst varchar,
seasonNumber varchar,
episodeNumber varchar
);

copy  imdb.public.title_episode from '/Users/namishasingh/Downloads/title.episode.tsv' delimiter E'\t';


create table imdb.public.title_principals (
tconst varchar, 
ordering varchar, 
nconst varchar, 
category varchar, 
job varchar, 
characters varchar
);

copy  imdb.public.title_principals from '/Users/namishasingh/Downloads/title.principals.tsv' delimiter E'\t';


create table imdb.public.title_ratings ( 
tconst varchar, 
averageRating varchar, 
numvotes varchar
);

copy  imdb.public.title_ratings from '/Users/namishasingh/Downloads/title.ratings.tsv' delimiter E'\t';


create table imdb.public.name_basics (
nconst varchar, 
primaryName varchar, 
birthYear varchar, 
deathYear varchar,
primaryProfession varchar,
knownForTitles varchar
);

copy  imdb.public.name_basics from '/Users/namishasingh/Downloads/name.basics.tsv' delimiter E'\t';

SELECT * FROM imdb.public.title_akas;
SELECT * FROM imdb.public.title_basics;
SELECT * FROM imdb.public.title_crew;
SELECT * FROM imdb.public.title_episode;
SELECT * FROM imdb.public.title_principals;
SELECT * FROM imdb.public.title_ratings;
SELECT * FROM imdb.public.name_basics;


----Deleting the unintended row (which appeared at the first row of each table):
DELETE FROM imdb.public.title_akas WHERE "titleId" IN (SELECT "titleId" FROM imdb.public.title_akas LIMIT 1);
DELETE FROM imdb.public.title_basics WHERE tconst IN (SELECT tconst FROM imdb.public.title_basics LIMIT 1);
DELETE FROM imdb.public.title_crew WHERE tconst IN (SELECT tconst FROM imdb.public.title_crew LIMIT 1);
DELETE FROM imdb.public.title_episode WHERE tconst IN (SELECT tconst FROM imdb.public.title_episode LIMIT 1);
DELETE FROM imdb.public.title_principals WHERE tconst IN (SELECT tconst FROM imdb.public.title_principals LIMIT 1);
DELETE FROM imdb.public.title_ratings WHERE tconst IN (SELECT tconst FROM imdb.public.title_ratings LIMIT 1);
DELETE FROM imdb.public.name_basics WHERE nconst IN (SELECT nconst FROM imdb.public.name_basics LIMIT 1);


----Checking updated tables 
select * from imdb.public.title_akas ta;
select * from imdb.public.title_basics; 
select * from imdb.public.title_crew; 
select * from imdb.public.title_episode; 
select * from imdb.public.title_principals; 
select * from imdb.public.title_ratings; 
select * from imdb.public.name_basics nb; 

----Copy the tables into CSV
COPY imdb.public.title_akas TO '/Users/namishasingh/Desktop/HW06CSV/title_akas.csv' DELIMITER ',' CSV header;
COPY imdb.public.title_basics TO '/Users/namishasingh/Desktop/HW06CSV/title_basics.csv' DELIMITER ',' CSV header;
COPY imdb.public.title_crew TO '/Users/namishasingh/Desktop/HW06CSV/title_crew.csv' DELIMITER ',' CSV header;
COPY imdb.public.title_episode TO '/Users/namishasingh/Desktop/HW06CSV/title_episode.csv' DELIMITER ',' CSV header;
COPY imdb.public.title_principals TO '/Users/namishasingh/Desktop/HW06CSV/title_principals.csv' DELIMITER ',' CSV header;
COPY imdb.public.title_ratings TO '/Users/namishasingh/Desktop/HW06CSV/title_ratings.csv' DELIMITER ',' CSV header;
COPY imdb.public.name_basics TO '/Users/namishasingh/Desktop/HW06CSV/name_basics.csv' DELIMITER ',' CSV header;

----Exercise 3
---Calculate cardinality of each table and each column 
---title_akas
select distinct count(titleid) from imdb.public.title_akas ta; 
select distinct count(ordering) from imdb.public.title_akas ta; 
select distinct count(title) from imdb.public.title_akas ta; 
select distinct count(region) from imdb.public.title_akas ta; 
select distinct count(language) from imdb.public.title_akas ta; 
select distinct count(types) from imdb.public.title_akas ta; 
select distinct count(attributes) from imdb.public.title_akas ta; 
select distinct count(isoriginaltitle) from imdb.public.title_akas ta; 

---title_basics 
select distinct count(tconst) from imdb.public.title_basics;
select distinct count(titletype) from imdb.public.title_basics;
select distinct count(primarytitle) from imdb.public.title_basics;
select distinct count(originaltitle) from imdb.public.title_basics;
select distinct count(isadult) from imdb.public.title_basics;
select distinct count(startyear) from imdb.public.title_basics;
select distinct count(endyear) from imdb.public.title_basics;
select distinct count(runtimeminutes) from imdb.public.title_basics;
select distinct count(genres) from imdb.public.title_basics;

---title_crew
select distinct count(tconst) from imdb.public.title_crew;
select distinct count(directors) from imdb.public.title_crew;
select distinct count(writers) from imdb.public.title_crew;

---title_episode
select distinct count (tconst) from imdb.public.title_episode te;
select distinct count (parenttconst) from imdb.public.title_episode te; 
select distinct count (seasonnumber) from imdb.public.title_episode te; 
select distinct count (episodenumber) from imdb.public.title_episode te; 

---title_principals
select distinct count (tconst) from imdb.public.title_principals tp; 
select distinct count (ordering) from imdb.public.title_principals tp; 
select distinct count (nconst) from imdb.public.title_principals tp; 
select distinct count (category) from imdb.public.title_principals tp; 
select distinct count (job) from imdb.public.title_principals tp; 
select distinct count (characters) from imdb.public.title_principals tp; 

---title_ratings
select distinct count (tconst) from imdb.public.title_ratings tr; 
select distinct count (averagerating) from imdb.public.title_ratings tr; 
select distinct count (numvotes) from imdb.public.title_ratings tr; 

---name_basics
select distinct count (nconst) from imdb.public.name_basics nb; 
select distinct count (primaryname) from imdb.public.name_basics nb; 
select distinct count (birthyear) from imdb.public.name_basics nb; 
select distinct count (deathyear) from imdb.public.name_basics nb; 
select distinct count (primaryprofession) from imdb.public.name_basics nb; 
select distinct count (knownfortitles) from imdb.public.name_basics nb; 

----Primary key for each table 
ALTER TABLE imdb.public.title_akas ADD PRIMARY KEY ("titleId", ordering);
ALTER TABLE imdb.public.title_basics ADD PRIMARY KEY (tconst);
ALTER TABLE imdb.public.title_crew ADD PRIMARY KEY (tconst);
ALTER TABLE imdb.public.title_episode ADD PRIMARY KEY (tconst);
ALTER TABLE imdb.public.title_principals ADD PRIMARY KEY (tconst, ordering);
ALTER TABLE imdb.public.title_ratings ADD PRIMARY KEY (tconst);
ALTER TABLE imdb.public.name_basics ADD PRIMARY KEY (nconst);

-- Step 1: Use the EXCEPT set operation and count how many tconst values are presented in imdb.public.title_ratings 
--that aren't present in imdb.public.title_basic.
SELECT COUNT(*) FROM (SELECT "tconst" FROM imdb.public.title_ratings except SELECT "tconst" FROM imdb.public.title_basics
) AS result;
-- count 0

SELECT COUNT(*) FROM (SELECT "tconst" FROM imdb.public.title_basics except SELECT "tconst" FROM imdb.public.title_ratings
) AS result;
--count: 6,609,382 

-- Step 2: Calculate the same count but this time return the values of tconst column that are present in imdb.public.title_basic 
--but not in imdb.public.title_ratings.
SELECT "tconst" FROM (SELECT "tconst" FROM imdb.public.title_basics except SELECT "tconst" FROM imdb.public.title_ratings
) AS result;

--Step 3: Use the INTERSECT operation to count how many records of tconst column show op in both 
--imdb.public.title_basics and imdb.public.title_ratings tables.

SELECT Count (*) from (select "tconst"
FROM imdb.public.title_basics intersect SELECT "tconst"
FROM imdb.public.title_ratings) AS result1;
--1,132,893

--Step 4: Based on your analysis, which table should be the parent table and which table should be the child table?

--Based on our analysis, the child table should be imdb.public.title_ratings and the parent table should be imdb.public.title_basics. As you can evidently see in Step 1, there are no tconst values present in imdb.public.title_ratings that aren't present in imdb.public.title_basic. This means that the title_basics can not get any values from the title_ratings table but the reverse would be true. Also, as shown in Step 2, imdb.public.title_basic has values that aren’t present in the title_rating table therefore it should be a parent table. 

--Step 5: Attempt to use the ALTER TABLE statement to add a foreign key relationship between the two tables.

ALTER TABLE imdb.public.title_ratings 
ADD CONSTRAINT FK_title_basics_rating_tconst
FOREIGN KEY ("tconst") REFERENCES imdb.public.title_basics ("tconst");

