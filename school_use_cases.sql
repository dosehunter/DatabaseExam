USE school;

#########################################################################################
#########################################################################################
-- 1. Retrieve teachers who teach more than 3 subjects and number of distinct subjects taught.
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
-- 2. Retrieve the id of all teachers who are not assigned to the subject: ‘History’
#########################################################################################

SELECT e.full_name AS `name`, e.id FROM employee AS e
WHERE e.id IN (
	SELECT teacher_id FROM can_teach AS ct
	INNER JOIN `subject` AS s 
		ON s.id = ct.`subject_id`
        WHERE s.subject_name != "History");


#########################################################################################
#########################################################################################
-- 3. Retrieve the CPR number of all male teachers who are assigned as head teachers for a class.
#########################################################################################

SELECT GET_FULL_CPR(e.dob, e.cpr) 
	AS "CPR of all male teachers assigned head of a class" 
	FROM employee AS e
	WHERE e.id IN (
		SELECT head_teacher_id 
		FROM class)
	AND e.gender = "M";

#########################################################################################
#########################################################################################
-- 4. Retrieve the names of all the students who did not pass their exam.
#########################################################################################

SELECT full_name AS `Students that failed an exam`
FROM student
WHERE id IN (SELECT student_id 
    FROM exam_grades
    WHERE grade < 02);

#########################################################################################
#########################################################################################
-- 5. What gender has got more email addresses?
#########################################################################################    

SELECT CASE 
  WHEN COUNT(CASE WHEN gender='M' THEN 1 END) > 
	   COUNT(CASE WHEN gender="F" THEN 1 END) 
  THEN "Boys" ELSE "Girls" END AS `Who are more likely to have an email:`
  FROM student
WHERE email IS NOT NULL;
