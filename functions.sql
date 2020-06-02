DROP FUNCTION IF EXISTS GET_FULL_CPR;

DELIMITER //

CREATE FUNCTION GET_FULL_CPR(dob DATE, cpr INT)
    RETURNS CHAR(17)
    DETERMINISTIC
    BEGIN
        DECLARE full_cpr CHAR(17);
        SET full_cpr=CONCAT(
			CAST(DATE_FORMAT(dob, "%d/%m/%Y")AS CHAR), 
                '-', cpr); 
        RETURN full_cpr;
    END //

DELIMITER ;

############################################
-- EXAMPLE
############################################

SELECT GET_FULL_CPR('1993-04-18', 7213)as myname;

