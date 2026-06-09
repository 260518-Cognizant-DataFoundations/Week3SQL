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
VALUES('Bob', 35, 200000), ('Joe', 38, 225000), ('Mike', 55, 500000), ('Ken', 42, null),
('Jeff', 35, 200000), ('Sukalyan', 21, 200000), ('Dave', 48, 200000);

-- Select shows table data (goes way deeper than this)
SELECT * FROM employees;

-- the where clause ---------------

SELECT * FROM employees WHERE salary = 200000;

SELECT * FROM employees WHERE age > 35;

-- quick subquery, which is query inside query

SELECT * FROM employees WHERE salary <
(SELECT AVG(salary) FROM employees);


-- Note above, we aren't limeted to selcting all, we can select certain columns alone

SELECT username, salary FROM employees;


SELECT * FROM employees WHERE salary BETWEEN 200001 AND 300000;

-- The wildcard (%) can be used to denote values that can be anything
-- often used with the "LIKE" operator

SELECT * FROM employees WHERE username LIKE 'B%';

SELECT * FROM employees WHERE salary = 300000 OR salary = 500000;


-- IN is more graceful than OR if you have potentially a ton of values to check
SELECT * FROM employees WHERE salary IN ('100000', '200000', '300000', '400000', '500000');



-- ORDER BY - orders results based on certain column

-- order numerically
SELECT * FROM employees ORDER BY salary;

-- order alphabetically
SELECT * FROM employees ORDER BY username DESC;
-- need to specify desc for descending order

-- FUNCTIONS - take in one or more values and return a single value

-- scalar functions take in up to one value and return one value

SELECT now();
SELECT upper('i am in all caps now');
SELECT lower('I AM BIG AND MIGHTY');

-- aggregate function take in multiple values and return one value

-- throwing in "AS" to change the result column name
SELECT max(salary) AS Max_Salary FROM employees;

-- count() returns a number representing the amount of returned records
SELECT count(*) FROM employees;
SELECT count(*) as Bobs FROM employees WHERE username = 'Bob'; 
SELECT count(salary) as Salaries FROM employees; -- Does the null get counted? NO!


-- GROUP BY and HAVING ------------------------------

-- GROUP BY will merge records together based on matching column values
SELECT salary, count(*) AS Salary_Counts FROM employees GROUP BY salary;

-- HAVING is like a WHERE clause but for aggregate functions. It's ONLY used after GROUP BY.

SELECT salary, count(*) AS Salary_Counts_No_Nulls FROM employees GROUP BY salary HAVING salary IS NOT NULL;

-- HAVING exists because WHERE doesn't work after a group by 
-- WHERE only works after table selection. It only works on the raw table data.


-- Calling truncate just to show it (removes all data)
TRUNCATE TABLE employees;

select * from employees;