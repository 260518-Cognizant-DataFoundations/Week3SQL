-- This demo will demonstrate Normal Forms 1-3 and Joins (at the end)

/* 1st Normal Form (we do NOT want this)
 * 
 *
 * Rules:
 * 1) Tables must have primary keys (can be a composite key - PK made up of multiple columns)
 * 2) Columns must be atomic (columns must track the smallest pieces of data possible) */
 
 
CREATE TABLE videogames(
	-- Notice no typical serial primary key 
	name VARCHAR(20),
	genre INT,
	release_year INT,
	developer VARCHAR(20),
	developer_hq TEXT,
  	developer_size INT,
	PRIMARY KEY(name, developer) 
  	-- This is a composite key - multiple columns are used to uniquely identify a record
);

DROP TABLE IF EXISTS videogames;

/* 2nd Normal Form (this is better, but we still haven't achieved 3NF, which is the goal
 * 
 * 1) Be in 1NF
 * 2) Remove partial dependencies (When columns on depend on PART of the primary key. 
 	 Just using a single column primary key is the best way to achieve this! */

CREATE TABLE videogames(
	-- Now we can use our typical serial primary key 
  	game_id SERIAL,
	game_name VARCHAR(20),
	game_genre INT,
	game_release_year INT,
	developer VARCHAR(20),
	developer_hq TEXT,
  	developer_size INT
);

DROP TABLE IF EXISTS videogames;

/* 3rd Normal Form - This is how we want our tables structured 
 * 
 * Rules:
 * 1) Be in 2NF
 * 2) Remove Transitive Dependencies (we need to split our data into distinct tables)
 * 	In other words, tables must have a SINGLE RESPONSIBILITY. 
 * 	-One table deals with games, another with the developers */
 

CREATE TABLE developers(
	dev_id SERIAL PRIMARY KEY,
  	dev_name text,
  	dev_HQ CHAR(2),
	games_released int
);
 
 CREATE TABLE videogames(
 	game_id SERIAL PRIMARY KEY,
   	game_name text,
   	game_genre text,
   	dev_id_fk BIGINT UNSIGNED,
   	CONSTRAINT fk_dev FOREIGN KEY (dev_id_fk) REFERENCES developers(dev_id)
 );
 -- "This column, called dev_id_fk is a constraint we're naming "fk_dev"
 -- The Foreign Key references the column in developers called "dev_id"






-- DML Here -----------------------------------

 -- Insert data for developers and games
 INSERT INTO developers(dev_name, dev_HQ, games_released)
 VALUES ('Team Cherry', 'AS', 2), 
 ('Valve', 'WA', 30), 
 ('Toby Fox', 'NH', 2),
 ('Ben Petruzziello', 'VA', 0);
 
 SELECT * FROM developers;
 
 INSERT INTO videogames(game_name, game_genre, dev_id_fk)
values ('Hollow Knight', 'Metrovania', 1), ('Silksong', 'Metrovania', 1),
('TF2', 'FPS', 2), ('Undertale', 'RPG', 3);

SELECT * FROM videogames;


-- INNER JOIN (I want records from BOTH tables that have FK/PK matches)--------------------------

-- The records we get are records that have FK/PK relationships - so Ben is not here :(
SELECT * FROM videogames v INNER JOIN developers d ON v.dev_id_fk = d.dev_id;

-- Yes, we can still filter with WHERE clause and anything else
SELECT * FROM videogames v INNER JOIN developers d ON v.dev_id_fk = d.dev_id WHERE d.dev_id = 1;

 -- LEFT vs RIGHT join---------------------------------------------------------------------------
 
 -- Get ALL records from the LEFT/RIGHT table plus matching records from the other table
 
 -- Same result as the INNER JOIN
 SELECT * FROM videogames v LEFT JOIN developers d ON v.dev_id_fk = d.dev_id;
 
 -- We finally see Ben! He's in the "right table" and has no games
  SELECT * FROM videogames v RIGHT JOIN developers d ON v.dev_id_fk = d.dev_id;
  
  -- OUTER JOIN (doesn't exist in MySQL but we can rig it)----------------------------------------
  
  -- Outer joins return EVERYTHING from both tables
  -- We can emulate this behavior by using UNION to combine a left and right join
  
  SELECT * FROM videogames v LEFT JOIN developers d ON v.dev_id_fk = d.dev_id
 	UNION
  SELECT * FROM videogames v RIGHT JOIN developers d ON v.dev_id_fk = d.dev_id;
  
  
 
