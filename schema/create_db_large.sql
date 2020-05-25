DROP TABLE IF EXISTS Company;
CREATE TABLE Company 
	(name VARCHAR(100), 
	 year_established VARCHAR(4),
	 comp_id INT(4),
	 PRIMARY KEY (comp_id)
) ENGINE = innoDB; 


DROP TABLE IF EXISTS Singer;
CREATE TABLE Singer 
	(name VARCHAR(50), 
	 birth_date VARCHAR(20),
	 start_year VARCHAR(4), 
	 region VARCHAR(50), 
	 belongingComp_id INT(4),
     id INT(5), 
     FOREIGN KEY(belongingComp_id) REFERENCES Company(comp_id)
     ON UPDATE CASCADE 
     ON DELETE SET NULL, 
	 PRIMARY KEY (id)
) ENGINE = innoDB; 


DROP TABLE IF EXISTS Event;
CREATE TABLE Event 
	(name VARCHAR(100), 
	 date VARCHAR(20),
	 country VARCHAR(100), 
     city VARCHAR(50), 
	 PRIMARY KEY (name, date)
) ENGINE = innoDB; 


DROP TABLE IF EXISTS Participates_in;
CREATE TABLE Participates_in 
	(event_name VARCHAR(100), 
	 event_time VARCHAR(20),
     singer_id INT(5), 
     FOREIGN KEY(event_name, event_time) REFERENCES Event(name, date) 
     ON UPDATE CASCADE 
     ON DELETE CASCADE, 
     FOREIGN KEY(singer_id) REFERENCES Singer(id) 
     ON UPDATE CASCADE 
     ON DELETE CASCADE, 
	 PRIMARY KEY (event_name, event_time, singer_id)
) ENGINE = innoDB; 


DROP TABLE IF EXISTS Concert;
CREATE TABLE Concert 
	(concert_name VARCHAR(100), 
	 concert_time VARCHAR(20),
	 attendance INT(8),
     FOREIGN KEY(concert_name, concert_time) REFERENCES Event(name, date)
     ON UPDATE CASCADE 
     ON DELETE CASCADE, 
	 PRIMARY KEY (concert_name, concert_time)
) ENGINE = innoDB; 


DROP TABLE IF EXISTS MusicFestival;
CREATE TABLE MusicFestival 
	(festival_name VARCHAR(100), 
	 festival_time VARCHAR(20),
	 genre VARCHAR(30),
	 scale VARCHAR(20),
     FOREIGN KEY(festival_name, festival_time) REFERENCES Event(name, date)
     ON UPDATE CASCADE 
     ON DELETE CASCADE, 
	 PRIMARY KEY (festival_name, festival_time)
) ENGINE = innoDB; 


DROP TABLE IF EXISTS Fan;
CREATE TABLE Fan 
	(name VARCHAR(50), 
	 birth_date VARCHAR(20),
	 region VARCHAR(50), 
     id INT(5), 
	 PRIMARY KEY (id)
) ENGINE = innoDB; 


DROP TABLE IF EXISTS Link;
CREATE TABLE Link 
	(URL VARCHAR(200), 
	 year_released INT(4), 
	 type_of_content VARCHAR(20), 
	 updatedFan_id INT(5), 
	 event_name VARCHAR(100), 
	 event_time VARCHAR(20),
     FOREIGN KEY(updatedFan_id) REFERENCES Fan(id)
     ON UPDATE CASCADE 
     ON DELETE SET NULL, 
     FOREIGN KEY(event_name, event_time) REFERENCES Event(name, date)
     ON UPDATE CASCADE 
     ON DELETE CASCADE,
	 PRIMARY KEY (URL)
) ENGINE = innoDB; 


DROP TABLE IF EXISTS Song;
CREATE TABLE Song 
	(name VARCHAR(100),
     year_released INT(4), 
	 genre VARCHAR(30), 
     song_singer_id INT(5),
     FOREIGN KEY(song_singer_id) REFERENCES Singer(id)
     ON UPDATE CASCADE 
     ON DELETE CASCADE, 
	 PRIMARY KEY (name, song_singer_id)
) ENGINE = innoDB; 


DROP TABLE IF EXISTS Favorite;
CREATE TABLE Favorite 
	(fan_id INT(5),
	 singer_id INT(5),
     FOREIGN KEY(fan_id) REFERENCES Fan(id)
     ON UPDATE CASCADE 
     ON DELETE CASCADE,
     FOREIGN KEY(singer_id) REFERENCES Singer(id)
     ON UPDATE CASCADE 
     ON DELETE CASCADE, 
	 PRIMARY KEY (fan_id, singer_id)
) ENGINE = innoDB; 


DROP TABLE IF EXISTS Likes;
CREATE TABLE Likes 
	(fan_id INT(5),
	 song_name VARCHAR(100), 
	 song_singer_id INT(5),
     FOREIGN KEY(fan_id) REFERENCES Fan(id)
     ON UPDATE CASCADE 
     ON DELETE CASCADE,
     FOREIGN KEY(song_name) REFERENCES Song(name)
     ON UPDATE CASCADE 
     ON DELETE CASCADE, 
     FOREIGN KEY(song_singer_id) REFERENCES Singer(id)
     ON UPDATE CASCADE 
     ON DELETE CASCADE, 
	 PRIMARY KEY (fan_id, song_name, song_singer_id)
) ENGINE = innoDB; 

