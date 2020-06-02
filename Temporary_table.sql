USE school;

CREATE TEMPORARY TABLE IF NOT EXISTS 
	table2 AS (
		SELECT * FROM employee);
        
SELECT * FROM table2;

SHOW INDEXES FROM student;

EXPLAIN SELECT * FROM employee 
	WHERE full_name LIKE "%a";

CREATE INDEX idx_emp_name ON employee(full_name);

############################################
-- EXAMPLE
############################################

