USE school;

INSERT INTO time_table (
	teacher_id, `subject_id`, class_number, room_number, teach_date, scheduled_time) 	
    VALUES 
    (17, 44, 9, 109, "2020-06-01 12:00:00", 60), 
    (17, 12, 9, 109, "2020-06-02 12:00:00", 45),
    (17, 22, 4, 319, "2020-06-03 8:00:00", 120),
    (17, 44, 39, 248, "2020-06-04 11:00:00", 30),
    (17, 33, 34, 159, "2020-06-01 8:00:00", 90),
    (17, 47, 34, 159, "2020-06-03 9:00:00", 60),
    (17, 33, 34, 159, "2020-06-04 11:00:00", 60),
    (48, 2, 34, 159, "2020-06-01 10:00:00", 60),
    (48, 2, 9, 109, "2020-06-03 12:00:00", 45),
    (48, 5, 4, 319, "2020-06-01 8:00:00", 120),
    (48, 41, 39, 248, "2020-06-04 11:00:00", 30),
    (48, 47, 34, 159, "2020-06-01 8:00:00", 60),
    (48, 29, 34, 159, "2020-06-04 12:00:00", 120),
    (21, 9, 34, 159, "2020-06-01 11:00:00", 120),
    (21, 26, 34, 159, "2020-06-03 11:00:00", 60),
    (21, 34, 34, 109, "2020-06-04 11:00:00", 90),
    (21, 51, 34, 159, "2020-06-01 10:00:00", 60);

DROP VIEW IF EXISTS weekly_schedule;
CREATE VIEW weekly_schedule AS 
	SELECT su.subject_name AS "Subject",
	su.subject_level AS "Level",
	te.full_name AS "Teacher",
    DAYNAME(tt.teach_date) AS "Day",
    DATE_FORMAT(TIME(tt.teach_date), "%H:%i") AS `Start time`,
    DATE_FORMAT(ADDTIME(
		TIME(
			tt.teach_date), 
            CONCAT(
				FLOOR(tt.scheduled_time/60), ':',
                MOD(tt.scheduled_time,60),':')), "%H:%i") 
		AS `End time`,
 CONCAT(CAST(cl.class_year AS CHAR), 
	"-", 
    CAST(cl.class_level AS CHAR)) AS "Class"
 FROM time_table AS tt
 INNER JOIN `subject` AS su 
	ON tt.`subject_id` = su.id
 INNER JOIN employee AS te
	ON tt.teacher_id = te.id
 INNER JOIN class AS cl
	ON tt.class_number = cl.id
    WHERE  YEARWEEK(`teach_date`, 1) = YEARWEEK(CURDATE(), 1)
    ORDER BY tt.teach_date, `Start time`, `End time`;

##################################################
-- The view in action
##################################################

SELECT * FROM weekly_schedule;

