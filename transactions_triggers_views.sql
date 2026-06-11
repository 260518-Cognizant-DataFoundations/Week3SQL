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


-- ---------------------------------

-- 5 nests, 5 birds
INSERT INTO nests (nest_location)
VALUES ('Oak Tree'), ('Fence Post'), ('Roof Gutter'), ('Abandoned Car'), ('Chimney');       

-- (some nests have multiple birds, some nests have none)
INSERT INTO birds (bird_species, nest_id_fk)
VALUES ('Sparrow', 1), ('Sparrow', 1), ('Sparrow', 1), ('Blue Jay', 2), ('Cardinal', 3), ('Wren', 5);    

SELECT * FROM nests;
SELECT * FROM birds;