USE school;

DROP TRIGGER IF EXISTS check_room_size;
delimiter //
CREATE TRIGGER check_room_size
BEFORE INSERT	
    ON time_table
   FOR EACH ROW
   BEGIN
	DECLARE msg VARCHAR(128);
    SET @ro_num = new.room_number;
    SET @cls_id = new.class_number;
    
    # Get room size
    SET @room_size = (
		SELECT size FROM room
		WHERE @ro_num = room_number);
        
	# Get class size with teacher
	SET @class_size = (
		SELECT COUNT(*) FROM student
		WHERE class_number=@cls_id)
        + 1;

    IF @class_size > @room_size THEN
        SET msg = concat('ERROR: The selected room can only contain ',
			CAST(@room_size as char), 
            ' people. Class size is ', 
            CAST(@class_size AS CHAR));
            
		# Throw an error
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg;
    END IF;
   END;
//


############################################
-- EXAMPLE
############################################

# Room for only 10 people: 157:
SELECT * FROM room WHERE room_number=157;

# Class with more than 10 people: 57:
SELECT COUNT(s.id) AS `count`, s.class_number FROM student AS s
GROUP BY s.class_number
ORDER BY `count` DESC;

INSERT INTO time_table (
	teacher_id, `subject_id`, class_number, room_number, teach_date, scheduled_time) 	
    VALUES (12, 44, 57, 157, "1970-05-21 04:13:42", 60);
    
