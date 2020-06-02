USE school;

##########################################
-- Once a year the school Needs to print all student grades for that year, 
-- it should show the student id, student name, grade, subject, exam date 
-- and the teacher teaching the subject.

DROP EVENT IF EXISTS yearly_grades;
CREATE EVENT yearly_grades ON
	SCHEDULE AT CURRENT_TIMESTAMP + INTERVAL 1 YEAR
    DO
		SELECT stu.id AS ID, 
		stu.full_name AS "Student",
		eg.grade AS "Grade",
		eg.exam_date AS "Date",
		su.subject_name AS "Subject",
		em.full_name AS "Subject teacher"
	  FROM student AS stu
	 INNER JOIN exam_grades 
		AS eg
		ON eg.student = stu.id
	 INNER JOIN `subject` 
		AS su
		ON su.id = eg.`subject`
	 INNER JOIN employee
		AS em
	 WHERE em.id IN (
		SELECT head_teacher 
		FROM class 
		AS cl 
		WHERE cl.id = stu.class_number);
	
############################################
-- EXAMPLE
############################################



