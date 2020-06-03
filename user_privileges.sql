DROP ROLE IF EXISTS teacher, secretary, student, principal;

DROP USER IF EXISTS teacher1, teacher2, teacher3;
DROP USER IF EXISTS student1, student2, student3;
DROP USER IF EXISTS secretary1, secretary2, secretary3;
DROP USER IF EXISTS principal1;

CREATE ROLE teacher;
GRANT SELECT ON school.student TO teacher;
GRANT SELECT ON school.dependent TO teacher;
GRANT SELECT ON school.class TO teacher;
GRANT SELECT, INSERT, ALTER, DELETE ON school.exam_grades TO teacher;
GRANT SELECT, INSERT, ALTER, DELETE ON school.time_table TO teacher;

CREATE ROLE secretary;
GRANT SELECT ON *.* TO secretary;
GRANT INSERT, ALTER, DELETE ON school.student TO secretary;
GRANT INSERT, ALTER, DELETE ON school.can_teach TO secretary;
GRANT INSERT, ALTER, DELETE ON school.dependent TO secretary;
GRANT INSERT, ALTER, DELETE ON school.time_table TO secretary;
GRANT INSERT, ALTER, DELETE ON school.employee TO secretary;
GRANT INSERT, ALTER, DELETE ON school.subject TO secretary;

CREATE ROLE student;
GRANT SELECT ON school.time_table TO student;
GRANT SELECT ON school.exam_grades TO student;

CREATE ROLE principal;
GRANT SELECT ON *.* TO principal;
GRANT INSERT, ALTER, DELETE ON school.can_teach TO principal;
GRANT INSERT, ALTER, DELETE ON school.employee TO principal;
GRANT INSERT, ALTER, DELETE ON school.dependent TO principal;
GRANT INSERT, ALTER, DELETE ON school.room TO principal;
GRANT INSERT, ALTER, DELETE ON school.class TO principal;
GRANT INSERT, ALTER, DELETE ON school.time_table TO principal;
GRANT INSERT, ALTER, DELETE ON school.subject TO principal;
GRANT INSERT, ALTER, DELETE ON school.student TO principal;

CREATE USER teacher1, teacher2, teacher3;
CREATE USER student1, student2, student3;
CREATE USER secretary1, secretary2, secretary3;
CREATE USER principal1;

GRANT teacher TO teacher1, teacher2, teacher3;
GRANT student TO student1, student2, student3;
GRANT secretary TO secretary1, secretary2, secretary3;
GRANT principal TO principal1;

