-- This script will show Foreign Keys, multiplicity (AKA cardinality), and CASCADE

CREATE TABLE users(
  -- Serial gives you an auto-incrementing bigint primary key
  user_id SERIAL, 
  user_name text
 );
 
 
 -- NOW, let's make a table that depends on users
 
 -- ------------------------
 -- one-to-many relationship
 -- ------------------------
 CREATE TABLE computers(
   computer_id SERIAL,
   computer_model text,
   user_id_fk BIGINT UNSIGNED, -- serial PKs are "unsigned bigints". So any FKs need to match that.
   CONSTRAINT fk_user_computer FOREIGN KEY (user_id_fk) REFERENCES users(user_id)
 );
 
 -- What is that??^ We've just made it so that computers BELONG to certain users
 -- one-to-many relationship: one user can own many computers
 -- inversely, many computers can belong to the same user
 
 -- The FK ALWAYS POINTS TO the PK of the table it depends on
 
 -- -----------------------
 -- one-to-one relationship
 -- -----------------------
 
 -- In a one-to-one, ONE record from one table belongs to ONE records from another table
 -- This enforces a strict pairing behavior
 
 -- We need a FK with the UNIQUE CONSTRAINT to establish a 1-1
 
CREATE TABLE user_badges(
  badge_id SERIAL,
  badge_number CHAR(10) UNIQUE NOT NULL,
  user_id_fk BIGINT UNSIGNED UNIQUE, -- Enforces the 1-1!
  CONSTRAINT fk_user_badge FOREIGN KEY (user_id_fk) REFERENCES users(user_id) ON DELETE CASCADE
);
 
 -- ------------------------
 -- many-to-many relationship
 -- ------------------------

-- This table is not directly related to the users table, but see below-
CREATE TABLE snacks(
  snack_id SERIAL,
  snack_name text
 );
 
 
 -- JOIN TABLE - These tables define a many-to-many relationship between two tables --
 -- Many snacks can belong to many users.
 CREATE TABLE user_snack_registrations(
 	user_id BIGINT UNSIGNED,
    snack_id BIGINT UNSIGNED,
    CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES users(user_id),
   CONSTRAINT fk_snack FOREIGN KEY (snack_id) REFERENCES snacks(snack_id),
   -- This table has a composite key (a Primary Key made up of multiple columns)
   PRIMARY KEY(user_id, snack_id)
 );
 
 
 
 -- DML HERE --------------------------
 
DESCRIBE users;
DESCRIBE computers;
DESCRIBE user_badges;
DESCRIBE snacks;


INSERT INTO users (user_name)
VALUES ('ElderGoose'), ('SQLLuvr'), ('WolfnBear'), ('IHaveNothing');

SELECT * FROM users;

INSERT INTO computers (computer_model, user_id_fk)
VALUES ('Dell', 1), ('Lenovo', 1), ('Toshiba', 2);

SELECT * FROM computers;


-- Check out what happens (error) when we try to delete a user
-- DELETE FROM users where user_id = 1;
-- "You can't delete this user!! Other records are currently pointing to it!"


-- Insert some badges, see what happens when we try to insert 2 badges for the same person
INSERT INTO user_badges (badge_number, user_id_fk)
VALUES ('1234567890', 1), ('1234567891', 2), ('1234567892', 3), ('1234567898', 4);

SELECT * FROM user_badges;

-- Thanks to CASCADE, deleting a user deletes the badge

DELETE FROM users WHERE user_id = 4;
SELECT * FROM user_badges;


-- Insert some snack
INSERT INTO snacks(snack_name)
VALUES ('Goldfish'), ('Poptart');


-- Inserting into the join table
INSERT INTO user_snack_registrations(user_id, snack_id)
VALUES (1, 2), (1, 1), (2, 2), (3, 2);

SELECT * FROM user_snack_registrations;
 
