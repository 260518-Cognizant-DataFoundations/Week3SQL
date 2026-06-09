CREATE TABLE employees(
	user_id int AUTO_INCREMENT PRIMARY KEY, -- Primary Keys are UNIQUE, NOT NULL by default. 
	username text UNIQUE NOT NULL, -- Username must exist and be unique between employees
  	age int CHECK(age > 18 AND age <= 100), -- Age must be between 18 and 100
  	active boolean DEFAULT TRUE, -- Default defines a default value if no value was added
	hire_date datetime DEFAULT CURRENT_TIMESTAMP,
  	fav_food text
);

-- Oh no! I forgot I need to include employee salary in my table
ALTER TABLE employees 
ADD COLUMN salary int;

-- Also, we don't care to track favorite food anymore
ALTER TABLE employees
DROP COLUMN fav_food;


-- DROP will drop tables we no longer want
CREATE TABLE dumb_stuff(
	thing1 text,
  	thing2 text
);

DROP TABLE dumb_stuff;

-- Oh no! I forgot I need to include employee salary in my table
ALTER TABLE employees 
ADD COLUMN salary int;

-- Also, we don't care to track favorite food anymore
ALTER TABLE employees
DROP COLUMN fav_food;


-- DROP will drop tables we no longer want
CREATE TABLE dumb_stuff(
	thing1 text,
  	thing2 text
);

DROP TABLE dumb_stuff;


-- DML HERE -------------------------------------------------------

-- Describe shows details about the table (NOT the data)
DESCRIBE employees;

-- Insert adds records to the table
INSERT INTO employees(username, age, active)
VALUES('Bob', 35, True), ('Joe', 38, False);

-- Select shows table data (goes way deeper than this)
SELECT * FROM employees;





-- Calling truncate just to show it (removes all data)
TRUNCATE TABLE employees;

select * from employees;
