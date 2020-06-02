USE school;
#########################################################################################
#########################################################################################
-- Retrieve teachers who teach more than 3 subjects and number of distinct subjects taught.
#########################################################################################
SELECT e.*, COUNT(*) AS `Number of subjects` 
	FROM employee AS e
    INNER JOIN can_teach AS ct
		ON ct.teacher_id = e.id
	GROUP BY e.id
    HAVING COUNT(DISTINCT ct.`subject_id`) >= 3
    ORDER BY `Number of subjects` DESC;
    
#########################################################################################    
#########################################################################################
-- Retrieve the id of all teachers who are not assigned to the subject: ‘History’
#########################################################################################

SELECT e.full_name AS `name`, e.id FROM employee AS e
WHERE e.id IN (
	SELECT teacher_id FROM can_teach AS ct
	INNER JOIN `subject` AS s 
		ON s.id = ct.`subject_id`
        WHERE s.subject_name != "History");


#########################################################################################
#########################################################################################
-- Retrieve the CPR number of all male teachers who are assigned as head teachers for a class.
#########################################################################################
SELECT CONCAT(CAST(e.dob AS CHAR), "-", CAST(e.cpr AS CHAR)) 
	AS "CPR of all male teachers assigned head of a class" 
	FROM employee AS e
	WHERE e.id IN (
		SELECT head_teacher_id 
		FROM class)
	AND e.gender = "M";


SELECT COUNT(s.id) AS `count` FROM student AS s
GROUP BY s.class_number
ORDER BY `count` DESC;

