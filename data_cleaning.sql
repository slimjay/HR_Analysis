CREATE DATABASE human_resource;

USE human_resource;

SELECT * FROM hr;

ALTER TABLE hr
CHANGE COLUMN ï»¿id emp_id VARCHAR(20) NULL;

-- View the data types of every column
DESCRIBE hr;
-- Noticed birtdate was in wrong data type(text), changed to date format
SELECT birthdate FROM hr;
-- Safe Protection blocks you from making changes. 
SET sql_safe_updates = 0;

UPDATE hr
SET birthdate = CASE
	WHEN birthdate LIKE '%/%' THEN date_format(str_to_date(birthdate, '%m/%d/%Y'), '%Y-%m-%d')
    WHEN birthdate LIKE '%-%' THEN date_format(str_to_date(birthdate, '%m-%d-%Y'), '%Y-%m-%d')
    ELSE NULL
END;

ALTER TABLE hr
MODIFY COLUMN birthdate DATE;

UPDATE hr
SET hire_date = CASE
	WHEN hire_date LIKE '%/%' THEN date_format(str_to_date(hire_date, '%m/%d/%Y'), '%Y-%m-%d')
    WHEN hire_date LIKE '%-%' THEN date_format(str_to_date(hire_date, '%m-%d-%Y'), '%Y-%m-%d')
    ELSE NULL
END;

ALTER TABLE hr
MODIFY COLUMN hire_date DATE;

UPDATE hr
SET termdate = date(str_to_date(termdate, '%Y-%m-%d %H:%i:%s UTC'))
WHERE termdate IS NOT NULL AND termdate != ' ';

ALTER TABLE hr
MODIFY COLUMN termdate DATE;

-- Added a new colum Age
ALTER TABLE hr ADD COLUMN age INT;
--Timestampdiff calculates the current date with birthdate
UPDATE hr
SET age = timestampdiff(YEAR, birthdate, CURDATE());

SELECT birthdate,age from hr;
-- I noticed some ages were negative

SELECT 
	min(age) AS youngest,
  max(age) AS oldest
FROM hr;
-- To verify my assumption

SELECT count(*) FROM hr WHERE age < 18;
-- I filtered age less than 18 because it won't be necessary in my analysis

SELECT COUNT(*) FROM hr WHERE termdate > CURDATE();

SELECT COUNT(*)
FROM hr
WHERE termdate = '0000-00-00';

SELECT location FROM hr;
