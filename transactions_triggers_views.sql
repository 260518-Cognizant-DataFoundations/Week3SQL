CREATE TABLE nests(
  nest_id SERIAL PRIMARY KEY,
  nest_location text
);

CREATE TABLE birds(
   bird_id SERIAL PRIMARY KEY,
   bird_species text,
   nest_id_fk BIGINT UNSIGNED,
   CONSTRAINT nest_fk FOREIGN KEY (nest_id_fk) REFERENCES nests(nest_id)
);


-- DML ---------------------------------

-- 5 nests, 5 birds
INSERT INTO nests (nest_location)
VALUES ('Oak Tree'), ('Fence Post'), ('Roof Gutter'), ('Abandoned Car'), ('Chimney');       

-- (some nests have multiple birds, some nests have none)
INSERT INTO birds (bird_species, nest_id_fk)
VALUES ('Sparrow', 1), ('Sparrow', 1), ('Sparrow', 1), ('Blue Jay', 2), ('Cardinal', 3), ('Wren', 5);    

SELECT * FROM nests;
SELECT * FROM birds;


-- -----------------
-- TRANSACTION REVIEW
-- ------------------

-- A group of commands that must pass together or fail together

-- A bird was created a new nest!
-- We need to insert a bird at the same time as the nest, or both must fail
START TRANSACTION;
	INSERT INTO nests(nest_location) VALUES ('Holly Tree');
    INSERT INTO birds(bird_species, nest_id_fk) VALUES ('Finch', LAST_INSERT_ID()); 
    -- Grabs the ID of whatever was last inserted
COMMIT;

SELECT * FROM nests; SELECT * FROM birds;


-- REVIEW: ALTER command and UPDATE command
ALTER TABLE nests ADD COLUMN bird_count int;
UPDATE nests n SET bird_count = (SELECT COUNT(*) FROM birds b WHERE b.nest_id_fk = n.nest_id);

select * from nests;

-- ------------------------------------------
-- VIEWS - when you want to store the results of a query instead of rewriting it
-- ------------------------------------------

-- We can query and filter a view as if it's a table!
-- Look at this ugly twice-nested subquery. I don't want to slap this throughout the scipt

-- "Select all birds in nests with counts above average"
CREATE VIEW birds_in_busy_nests AS
	SELECT bird_species, nest_id_fk FROM birds WHERE nest_id_fk IN 
    	(SELECT nest_id FROM nests WHERE bird_count > (
        	SELECT AVG(bird_count) FROM nests));
            
-- Use it just like a table!
SELECT * FROM birds_in_busy_nests;





