USE school;

CREATE TEMPORARY TABLE IF NOT EXISTS 
	table2 AS (
		SELECT * FROM employee);
        
SELECT * FROM table2;

INSERT INTO time_table (
	teacher_id, `subject_id`, class_number, room_number, teach_date, scheduled_time) 	
    VALUES (12, 44, 57, 157, "1970-05-21 04:13:42", 60);