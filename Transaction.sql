# Employees who have children at the school will get a bonus of 2% salary increase
DROP PROCEDURE IF EXISTS add_employee;

DELIMITER //

CREATE PROCEDURE add_employee(full_name_p VARCHAR(30), dob_p DATE, cpr_p INT, gender_p CHAR, salary_p INT)
BEGIN
	DECLARE msg VARCHAR(120);
	START TRANSACTION;
		
		INSERT INTO `employee` (full_name, dob, cpr, gender, salary)
			VALUES (full_name_p, dob_p, cpr_p, gender_p, salary_p);
		
		SET @employee = (
			SELECT MAX(id) FROM employee);
		
		SET @has_child = IF(EXISTS (
			SELECT e.id FROM employee AS e
				INNER JOIN dependent AS d
					ON e.full_name = d.full_name
					WHERE e.id = @employee), 'yes', 'no');
		
		UPDATE employee 
		SET salary = CASE
				WHEN @has_child = "yes"
					THEN salary*1.02
					ELSE salary
				END
			WHERE id = @employee;
		
		SET @salary = (SELECT salary FROM employee WHERE id=@employee);
		SELECT @salary;
		IF @salary > 25000 THEN
			ROLLBACK;
			SET msg = concat('ERROR: The salary is too high ',
			CAST(@salary as char));
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg;
		ELSE
			COMMIT;
		END IF;
END//

DELIMITER ;

CALL add_employee('Rickey Hermann','1972-05-24','4161','F','22920');

SELECT * FROM employee;
#DELETE FROM employee WHERE id=57;
