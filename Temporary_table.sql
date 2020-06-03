USE school;

DROP TEMPORARY TABLE IF EXISTS teacher_eval;

CREATE TEMPORARY TABLE teacher_eval AS
	SELECT emp.id, full_name AS teacher, emp.salary, su.subject_name, su.subject_level
	FROM employee AS emp
    INNER JOIN can_teach AS ct
		ON emp.id = ct.teacher_id
	INNER JOIN `subject` AS su 
		ON ct.subject_id = su.id;
        
############################################
-- EXAMPLE
############################################

SELECT * FROM teacher_eval;


############################################
## NOTES
-- Due to population data this is not possible as there are duplicates of various of these combinations
-- HOWEVER, id, subject_name and subject_level should be a unique combination
/*
CREATE TEMPORARY TABLE emp_eval2 
	(PRIMARY KEY teach_id (teacher_id, subject_name, subject_level))
	SELECT emp.id AS teacher_id, full_name, emp.salary, su.subject_name, su.subject_level 
	FROM employee AS emp
	 INNER JOIN can_teach AS ct
			ON emp.id = ct.teacher_id
		INNER JOIN `subject` AS su 
			ON ct.subject_id = su.id;
SELECT * FROM teacher_eval2;
*/