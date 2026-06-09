CREATE TABLE employees(
	user_id int AUTO_INCREMENT PRIMARY KEY, -- Primary Keys are UNIQUE, NOT NULL by default. 
	username VARCHAR(12) UNIQUE NOT NULL, -- Username must exist and be unique between employees
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


-- DML HERE -------------------------------------------------------

-- Describe shows details about the table (NOT the data)
DESCRIBE employees;

-- Insert adds records to the table
INSERT INTO employees(username, age, salary)
VALUES('Bob', 35, 200000), 
('Joe', 38, 225000),
('Michael', 55, 500000);

-- Select shows table data (goes way deeper than this)
SELECT * FROM employees;

-- We don't have to just select "all". We can selet certain columns alone
SELECT username, salary FROM employees;

-- the WHERE clause (helps us filter the data that gets returned)------------------------------------

SELECT * FROM employees WHERE salary = 200000;

SELECT * FROM employees WHERE age > 35;

SELECT * FROM employees WHERE salary BETWEEN 200001 AND 300000;

-- The wildcard (%) can be used to denote values that can be anything
-- This is often used with the "LIKE" operator
SELECT * FROM employees WHERE username LIKE 'B%';

SELECT * FROM employees WHERE salary = 300000 OR salary = 500000;

-- IN is more graceful than OR if you have potentially a ton of values to check
SELECT * FROM employees WHERE salary IN ('100000', '200000', '300000', '400000')

-- Here's a quick SUBQUERY, which is just a query inside a query
-- NOTE the function used! avg() gets the average of a certain column
SELECT * FROM employees WHERE salary < (SELECT avg(salary) FROM employees);



-- Calling truncate just to show it (removes all data)
TRUNCATE TABLE employees;

select * from employees;
