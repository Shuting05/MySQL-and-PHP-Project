-- This file contains all schema modifications, stored procedures and views used. 
-- You can find schema create and populate scripts in folder 'schema'. 


-- For page SINGERS:
-- Singer 1: Explore Singer(s) You Are Interested In
DROP PROCEDURE IF EXISTS singer1;
DELIMITER |
CREATE PROCEDURE singer1(
	IN singername VARCHAR(50))
BEGIN
	SELECT s.name AS singer_name, s.birth_date AS singer_birth_date, s.start_year AS singer_start_year,
				   s.region AS singer_region, s.id AS singer_id, c.name AS comp_name
          FROM Singer s, Company c
          WHERE s.name LIKE CONCAT('%', singername, '%')
          AND s.belongingComp_id = c.comp_id
          ORDER BY s.name, s.birth_date; 
END |
DELIMITER ; 


-- Singer 1_1: Singer's songs
DROP PROCEDURE IF EXISTS singer1_1;
DELIMITER |
CREATE PROCEDURE singer1_1(
	IN singerid INT(5))
BEGIN
	SELECT name, year_released, genre 
    FROM Song 
    WHERE song_singer_id = singerid; 
END |
DELIMITER ; 


-- Singer1_2: Add new singers
-- To prevent insertion of duplicate records without id, I modified schema for table Singer a bit: 
ALTER TABLE Singer ADD CONSTRAINT singer_unique UNIQUE (name, birth_date, start_year, region); 
-- Stored Procedure
DROP PROCEDURE IF EXISTS singer1_2;
DELIMITER |
CREATE PROCEDURE singer1_2(
	IN singername VARCHAR(50),
    IN startyear INT(4),
    IN birthdate VARCHAR(20), 
	IN region VARCHAR(50))
BEGIN
	DECLARE singerid INT;
    
    SET singerid = (SELECT MAX(id) 
    FROM Singer) + 1;
    
    IF startyear = 0 THEN
		SET startyear = 1000;
        END IF;
	IF birthdate = '' THEN
		SET birthdate = 'N/A';
        END IF;
	IF region = 'None' THEN
		SET region = 'N/A';
        END IF;
    
	INSERT INTO Singer(name, birth_date, start_year, region, id)
	VALUES(singername, birthdate, startyear, region, singerid);
    
    SELECT s.name AS singer_name, s.birth_date AS singer_birth_date, s.start_year AS singer_start_year, 
				   s.region AS singer_region, s.id AS singer_id
    FROM Singer s
    WHERE id = singerid; 
END |
DELIMITER ; 


-- Singer 2: Find singers by start-year and region
DROP PROCEDURE IF EXISTS sectionFour;
DELIMITER |
CREATE PROCEDURE sectionFour(
	IN startyear INT(4),
    IN region VARCHAR(50))
BEGIN
	SELECT s.name AS singer_name, s.birth_date as singer_birth_date, c.name AS comp_name
          FROM Singer s, Company c
          WHERE s.start_year = startyear
          AND s.region = region
          AND s.belongingComp_id = c.comp_id
          ORDER BY s.name, s.birth_date; 
END |
DELIMITER ; 


-- Singer 3: 
-- Part 1: Update info for existing singers 
DROP PROCEDURE IF EXISTS singer3_1;
DELIMITER |
CREATE PROCEDURE singer3_1(
	IN singerid INT(5),
    IN startyear INT(4),
    IN birthdate VARCHAR(20), 
	IN region VARCHAR(50))
BEGIN
    
    IF startyear <> 0 THEN
		UPDATE Singer SET start_year = startyear
        WHERE id = singerid;
        END IF;
	IF birthdate <> '' THEN
		UPDATE Singer SET birth_date = birthdate 
        WHERE id = singerid;
        END IF;
	IF region <> 'None' THEN
		UPDATE Singer SET region = region 
        WHERE id = singerid;
        END IF;
    
    SELECT s.name AS singer_name, s.birth_date AS singer_birth_date, s.start_year AS singer_start_year, 
				   s.region AS singer_region, s.id AS singer_id
    FROM Singer s
    WHERE id = singerid; 
END |
DELIMITER ; 


-- Part 2: Add new song(s) to existing singers
DROP PROCEDURE IF EXISTS singer3_2;
DELIMITER |
CREATE PROCEDURE singer3_2(
	IN singerid INT(5),
    IN songname VARCHAR(100),
    IN yearreleased INT(4),
    IN genre VARCHAR(30))
BEGIN
    
    IF yearreleased = 0 THEN
		SET yearreleased = 1000;
        END IF;
	IF genre = 'None' THEN
		SET genre = 'N/A';
        END IF;
    
	INSERT INTO Song(name, year_released, genre, song_singer_id)
	VALUES(songname, yearreleased, genre, singerid);
    
    SELECT s.name AS song_name, s1.name AS singer_name, s.year_released AS year_released, s.genre AS genre
    FROM Song s, Singer s1
    WHERE s1.id = singerid
    AND s.name = songname; 
END |
DELIMITER ; 



-- --------------------------------------------------------------------------------------------------
-- For page EVENTS:
-- Event 1: Explore Events You Are Interested In
DROP PROCEDURE IF EXISTS event1;
DELIMITER |
CREATE PROCEDURE event1(
	IN eventname VARCHAR(50))
BEGIN
	SELECT * FROM Event e
	WHERE e.name LIKE CONCAT('%', eventname, '%'); 
END |
DELIMITER ; 


-- Event 1_1: links for the event
DROP PROCEDURE IF EXISTS event1_1;
DELIMITER |
CREATE PROCEDURE event1_1(
	IN eventname VARCHAR(50))
BEGIN
	SELECT url, year_released, type_of_content
          FROM Link l
          WHERE l.event_name = eventname
          ORDER BY year_released; 
END |
DELIMITER ; 


-- Event 2: Find Events Your Favorite Singer Attended
DROP PROCEDURE IF EXISTS event2;
DELIMITER |
CREATE PROCEDURE event2(
	IN singername VARCHAR(50))
BEGIN
	SELECT event_name, event_time FROM Participates_in 
		  WHERE singer_id = (SELECT id FROM Singer WHERE name = singername); 
END |
DELIMITER ; 


-- Event 3_1: Add Events - Concert
DROP PROCEDURE IF EXISTS event3_1;
DELIMITER |
CREATE PROCEDURE event3_1(
	IN concertname VARCHAR(50),
    IN concertdate VARCHAR(20), 
    IN attendance INT(8))
BEGIN
	IF attendance = 0 THEN
		SET attendance = NULL;
        END IF;

	INSERT INTO Event(name, date)
	VALUES(concertname, concertdate);

	INSERT INTO Concert(concert_name, concert_time, attendance)
	VALUES(concertname, concertdate, attendance);
    
    SELECT *
    FROM Concert
    WHERE concert_name = concertname
    AND concert_time = concertdate; 

END |
DELIMITER ; 


-- Event 3_2: Display that the event has been added to table Event
DROP PROCEDURE IF EXISTS event3_2;
DELIMITER |
CREATE PROCEDURE event3_2(
	IN concertname VARCHAR(50),
    IN concertdate VARCHAR(20))
BEGIN
    SELECT *
    FROM Event
    WHERE name = concertname
    AND date = concertdate; 
END |
DELIMITER ; 


-- Event 4_1: Add Events - Music Festival
DROP PROCEDURE IF EXISTS event4_1;
DELIMITER |
CREATE PROCEDURE event4_1(
	IN mfname VARCHAR(50),
    IN mfdate VARCHAR(20), 
    IN genre VARCHAR(30), 
    IN scale VARCHAR(20))
BEGIN

	IF genre = 'None' THEN
		SET genre = NULL;
        END IF;
        
	IF scale = 'None' THEN
		SET scale = NULL;
        END IF;
        
	INSERT INTO Event(name, date)
	VALUES(mfname, mfdate);

	INSERT INTO MusicFestival(festival_name, festival_time, genre, scale)
	VALUES(mfname, mfdate, genre, scale);
    
    SELECT *
    FROM MusicFestival
    WHERE festival_name = mfname
    AND festival_time = mfdate; 

END |
DELIMITER ; 


-- Event 4_2: Display that the event has been added to table Event
DROP PROCEDURE IF EXISTS event4_2;
DELIMITER |
CREATE PROCEDURE event4_2(
	IN mfname VARCHAR(50),
    IN mfdate VARCHAR(20))
BEGIN
    SELECT *
    FROM Event
    WHERE name = mfname
    AND date = mfdate; 
END |
DELIMITER ; 

DELETE FROM Event where name = 'Hello' AND date =  '2018-01-02'; 


-- Event 5: Add Events - Others
DROP PROCEDURE IF EXISTS event5;
DELIMITER |
CREATE PROCEDURE event5(
	IN eventname VARCHAR(50),
    IN eventdate VARCHAR(20),
    IN country VARCHAR(50),
    IN city VARCHAR(50))
BEGIN
	INSERT INTO Event
	VALUES(eventname, eventdate, country, city);
    
    SELECT *
    FROM Event
    WHERE name = eventname
    AND date = eventdate; 
END |
DELIMITER ; 


-- Event 6: Update Info for Existing Events
DROP PROCEDURE IF EXISTS event6;
DELIMITER |
CREATE PROCEDURE event6(
    IN eventname VARCHAR(50),
    IN eventdate VARCHAR(20),
	IN updatecountry VARCHAR(50),
    IN updatecity VARCHAR(50))
BEGIN
	IF updatecountry <> '' THEN
		UPDATE Event SET country = updatecountry 
        WHERE name = eventname
        AND date = eventdate;
        END IF;
        
	IF updatecity <> '' THEN
		UPDATE Event SET city = updatecity 
        WHERE name = eventname
        AND date = eventdate;
        END IF;

    SELECT *
    FROM Event
    WHERE name = eventname
    AND date = eventdate; 
    
END |
DELIMITER ; 


-- Event 6_1: Find original value of country and city: 
DROP PROCEDURE IF EXISTS event6_1;
DELIMITER |
CREATE PROCEDURE event6_1(
    IN eventname VARCHAR(50),
    IN eventdate VARCHAR(20))
BEGIN
    SELECT country, city
    FROM Event
    WHERE name = eventname
    AND date = eventdate; 
    
END |
DELIMITER ; 


-- Event 7: Delete events:
DROP PROCEDURE IF EXISTS event7;
DELIMITER |
CREATE PROCEDURE event7(
    IN eventname VARCHAR(50),
    IN eventdate VARCHAR(20))

BEGIN
    DELETE FROM Event 
    WHERE name = eventname
    AND date = eventdate; 
END |
DELIMITER ; 


-- --------------------------------------------------------------------------------------------------
-- For page FANS:
DROP VIEW IF EXISTS FanLink; 
CREATE VIEW FanLink AS 
	SELECT f.name AS FanUploaded, f.id AS fan_id, l.URL, l.year_released, l.type_of_content, l.event_name, l.event_time
    FROM Link l 
    LEFT OUTER JOIN Fan f
    ON l.updatedFan_id = f.id
    WHERE l.updatedFan_id IS NOT NULL; 


-- Fan 1: Add fans
-- To prevent insertion of duplicate records without id, I modified schema for table Fan a bit: 
ALTER TABLE Fan ADD CONSTRAINT fan_unique UNIQUE (name, birth_date, region); 
-- Stored Procedure
DROP PROCEDURE IF EXISTS fan1;
DELIMITER |
CREATE PROCEDURE fan1(
	IN fanname VARCHAR(50),
    IN birthdate VARCHAR(20), 
	IN region VARCHAR(50))
BEGIN
	DECLARE fanid INT;
    
    SET fanid = (SELECT MAX(id) 
    FROM Fan) + 1;
    
	IF birthdate = '' THEN
		SET birthdate = 'N/A';
        END IF;
	IF region = 'None' THEN
		SET region = 'N/A';
        END IF;
    
	INSERT INTO Fan(name, birth_date, region, id)
	VALUES(fanname, birthdate, region, fanid);
    
    SELECT f.name AS fan_name, f.birth_date AS fan_birth_date,
				   f.region AS fan_region, f.id AS fan_id
    FROM Fan f
    WHERE id = fanid; 
END |
DELIMITER ; 

-- Delete New Fans
DROP PROCEDURE IF EXISTS deleteFan;
DELIMITER |
CREATE PROCEDURE deleteFan(
   IN fanid INT(5))
BEGIN
    DELETE FROM Fan 
    WHERE id = fanid; 
END |
DELIMITER ; 
