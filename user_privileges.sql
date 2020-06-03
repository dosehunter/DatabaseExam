USE school;

##################################################
##################### SETUP ######################    
##################################################

DROP ROLE IF EXISTS teacher, secretary, student, principal;

DROP USER IF EXISTS teacher1, teacher2, teacher3;
DROP USER IF EXISTS student1, student2, student3;
DROP USER IF EXISTS secretary1, secretary2, secretary3;
DROP USER IF EXISTS principal1;

##################################################
################# CREATE ROLES ###################    
##################################################

CREATE ROLE teacher;
GRANT SELECT ON school.student TO teacher;
GRANT SELECT ON school.dependent TO teacher;
GRANT SELECT ON school.class TO teacher;
GRANT SELECT, INSERT, UPDATE, DELETE ON school.exam_grades TO teacher;
GRANT SELECT, INSERT, UPDATE, DELETE ON school.time_table TO teacher;

CREATE ROLE secretary;
GRANT SELECT ON *.* TO secretary;
GRANT INSERT, UPDATE, DELETE ON school.student TO secretary;
GRANT INSERT, UPDATE, DELETE ON school.can_teach TO secretary;
GRANT INSERT, UPDATE, DELETE ON school.dependent TO secretary;
GRANT INSERT, UPDATE, DELETE ON school.time_table TO secretary;
GRANT INSERT, UPDATE, DELETE ON school.employee TO secretary;
GRANT INSERT, UPDATE, DELETE ON school.subject TO secretary;

CREATE ROLE student;
GRANT SELECT ON school.time_table TO student;
GRANT SELECT ON school.exam_grades TO student;

CREATE ROLE principal;
GRANT SELECT ON *.* TO principal;
GRANT INSERT, UPDATE, DELETE ON school.can_teach TO principal;
GRANT INSERT, UPDATE, DELETE ON school.employee TO principal;
GRANT INSERT, UPDATE, DELETE ON school.dependent TO principal;
GRANT INSERT, UPDATE, DELETE ON school.room TO principal;
GRANT INSERT, UPDATE, DELETE ON school.class TO principal;
GRANT INSERT, UPDATE, DELETE ON school.time_table TO principal;
GRANT INSERT, UPDATE, DELETE ON school.subject TO principal;
GRANT INSERT, UPDATE, DELETE ON school.student TO principal;

##################################################
################## CREATE USERS ##################    
##################################################

CREATE USER teacher1, teacher2, teacher3;
CREATE USER student1, student2, student3;
CREATE USER secretary1, secretary2, secretary3;
CREATE USER principal1;

##################################################
############ GRANT ROLES TO USERS ################    
##################################################

GRANT teacher TO teacher1, teacher2, teacher3;
GRANT student TO student1, student2, student3;
GRANT secretary TO secretary1, secretary2, secretary3;
GRANT principal TO principal1;

#############################################################
-- Quick look over all user grants
#############################################################

SELECT * FROM mysql.tables_priv
	WHERE Db = 'school';

#############################################################
-- To get more specific with the grants:
-- NOTE! You need to manually remove the file as mysql does not support overwritting files (Security feature)
#############################################################

SET @grants_file =  CONCAT(@@secure_file_priv, 'user_grants.txt');
SELECT @grants_file;

SELECT CONCAT('SHOW GRANTS FOR ''',user,'''@''',host,''';') AS `Privilege`
	FROM mysql.user
    HAVING `Privilege` LIKE "%principal%" 
		OR `Privilege` LIKE "%teacher%"
        OR `Privilege` LIKE "%secretary%"
        OR `Privilege` LIKE "%student%"
        INTO outfile 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\user_grants.txt'; 
# INTO OUTFILE DOES NOT ACCEPT VARIABLES THERE IS OTHER TEDIUS WORKAROUNDS

# IF IN SQL command line run this and it will show all grants for users:
#SOURCE /tmp/user_grants.txt
# Alternatively go and copy the contents of the file:
SHOW GRANTS FOR 'principal1'@'%';
SHOW GRANTS FOR 'secretary1'@'%';
SHOW GRANTS FOR 'secretary2'@'%';
SHOW GRANTS FOR 'secretary3'@'%';
SHOW GRANTS FOR 'student'@'%';
SHOW GRANTS FOR 'student1'@'%';
SHOW GRANTS FOR 'student2'@'%';
SHOW GRANTS FOR 'student3'@'%';
SHOW GRANTS FOR 'teacher1'@'%';
SHOW GRANTS FOR 'teacher2'@'%';
SHOW GRANTS FOR 'teacher3'@'%';

##################################################
############ SHOW GRANTS FOR ROLES ###############
##################################################

SHOW GRANTS FOR secretary;
SHOW GRANTS FOR student;
SHOW GRANTS FOR teacher;
SHOW GRANTS FOR principal;

