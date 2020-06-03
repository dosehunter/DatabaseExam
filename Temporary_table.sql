USE school;

DROP TEMPORARY TABLE IF EXISTS teacher_eval;

CREATE TEMPORARY TABLE teacher_eval 
	(PRIMARY KEY teach_id (teacher_id, `Subject Name`, `Subject Level`))
	SELECT emp.id AS teacher_id,
    full_name AS "Full Name",
    emp.salary AS "Salary",
    emp.dob AS "Date of birth",
    su.subject_name AS `Subject Name`,
    su.subject_level AS `Subject Level`
	FROM employee AS emp
	 INNER JOIN can_teach AS ct
			ON emp.id = ct.teacher_id
		INNER JOIN `subject` AS su 
			ON ct.subject_id = su.id;
        
############################################
-- EXAMPLE
############################################

SELECT * FROM teacher_eval;