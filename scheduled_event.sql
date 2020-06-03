USE school;

##################################################
-- Once a year the school Needs to print all student grades for that year, 
-- it should show the student id, student name, grade, subject, exam date 
-- and the teacher teaching the subject.
##################################################
########### PROCEDURE FOR OPERATION ##############
##################################################

DROP PROCEDURE IF EXISTS get_grades_for_year;

DELIMITER //
CREATE PROCEDURE get_grades_for_year(school_year DATE)
BEGIN 
	SELECT stu.id AS ID, 
	stu.full_name AS "Student",
	eg.grade AS "Grade",
	eg.exam_date AS "Date",
	su.subject_name AS "Subject",
	em.full_name AS "Subject teacher"
	FROM student AS stu
	INNER JOIN exam_grades AS eg 
        ON eg.student_id = stu.id
	INNER JOIN `subject` AS su 
        ON su.id = eg.subject_id
	INNER JOIN employee AS em
	WHERE em.id IN (
		SELECT head_teacher_id 
		FROM class AS cl 
		WHERE cl.id = stu.class_number) 
	AND 
	eg.exam_date BETWEEN school_year - INTERVAL 1 YEAR AND school_year;
END//
DELIMITER ;

##################################################
############### Scheduled Event ##################
##################################################

DROP EVENT IF EXISTS yearly_grades;

DELIMITER //
CREATE EVENT yearly_grades ON
	SCHEDULE EVERY 1 YEAR
		STARTS '2000-01-01 00:00:00'
		ENDS '2030-01-01 00:00:00'
DO BEGIN
		CALL get_grades_for_year(CURDATE());
END//
DELIMITER ;

############################################
-- EXAMPLE
############################################

CALL get_grades_for_year('2017-01-01');


