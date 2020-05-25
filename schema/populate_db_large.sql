
LOAD DATA
    LOCAL INFILE "data/Company_large.dat"
    REPLACE INTO TABLE Company
    FIELDS TERMINATED BY '|'
    (name, year_established, comp_id); 

LOAD DATA
    LOCAL INFILE "data/Singer_large.dat"
    REPLACE INTO TABLE Singer
    FIELDS TERMINATED BY '|'
    (name, birth_date, start_year, region, belongingComp_id, id);

LOAD DATA   
	LOCAL INFILE "data/Event_large.dat" 
    REPLACE INTO TABLE Event
    FIELDS TERMINATED BY '|' 
    (name, date, country, city);

LOAD DATA   
	LOCAL INFILE "data/Participates_in_large.dat" 
    REPLACE INTO TABLE Participates_in 
    FIELDS TERMINATED BY '|' 
    (event_name, event_time, singer_id);

LOAD DATA   
	LOCAL INFILE "data/Concert_large.dat" 
    REPLACE INTO TABLE Concert 
    FIELDS TERMINATED BY '|' 
    (concert_name, concert_time, attendance);

LOAD DATA   
	LOCAL INFILE "data/MusicFestival_large.dat" 
    REPLACE INTO TABLE MusicFestival
    FIELDS TERMINATED BY '|' 
    (festival_name, festival_time, genre, scale);

LOAD DATA   
	LOCAL INFILE "data/Fan_large.dat" 
    REPLACE INTO TABLE Fan
    FIELDS TERMINATED BY '|' 
    (name, birth_date, region, id);

LOAD DATA   
	LOCAL INFILE "data/Link_large.dat" 
    REPLACE INTO TABLE Link
    FIELDS TERMINATED BY '|' 
    (URL, year_released, type_of_content, updatedFan_id, event_name, event_time);

LOAD DATA   
	LOCAL INFILE "data/Song_large.dat" 
    REPLACE INTO TABLE Song 
    FIELDS TERMINATED BY '|' 
    (name, year_released, genre, song_singer_id);
    
LOAD DATA   
	LOCAL INFILE "data/Favorite_large.dat" 
    REPLACE INTO TABLE Favorite
    FIELDS TERMINATED BY '|' 
    (fan_id, singer_id);

LOAD DATA   
	LOCAL INFILE "data/Likes_large.dat" 
    REPLACE INTO TABLE Likes
    FIELDS TERMINATED BY '|' 
    (fan_id, song_name, song_singer_id);

    