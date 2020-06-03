DROP DATABASE IF EXISTS school;
CREATE DATABASE school;
USE school;

##################################################
-- DATABASE SETUP
##################################################

##################################################
################### DEPENDENT ####################    
-- The responsible dependent/s for a student
-- Name, phone, address and email will be stored
-- So that a teacher can contact them should anything happen
##################################################  
CREATE TABLE dependent(
	dep_id INT
		NOT NULL
        AUTO_INCREMENT,
    full_name VARCHAR(25),
    phone INT,
    address VARCHAR(30),
    email VARCHAR(30), 
    PRIMARY KEY (dep_id));

##################################################
#################### EMPLOYEE ####################    
-- Holds name, date of birth, cpr, gender and salary
################################################## 
   
CREATE TABLE employee(
	id INT
		NOT NULL
        AUTO_INCREMENT,
    full_name VARCHAR(25),
    dob DATE,
    cpr INT,
    gender CHAR,
    salary INT, #(6,2),
    PRIMARY KEY (id));  
    
##################################################  
##################### CLASS ######################  
-- Students are assigned a primary class
-- Needs info on class year, expected finish date, level, and headteacher
##################################################    

CREATE TABLE class(
	id INT
		NOT NULL
        AUTO_INCREMENT,
    class_year YEAR,
    graduation_date DATE,
    class_level INT,
    head_teacher_id INT,
    FOREIGN KEY (head_teacher_id) 
		REFERENCES employee(id) 
			ON UPDATE CASCADE 
            ON DELETE SET NULL,  -- If a teacher leaves the institution, the class might temporarily miss a head teacher
	PRIMARY KEY (id));

##################################################    
#################### STUDENT #####################
-- Student table holds necessary info of students
-- name, date of birth, cpr, gender, email, phone, and class number
-- A student can be assigned a maximum of one class
##################################################

CREATE TABLE student(
	id INT
		NOT NULL
        AUTO_INCREMENT,
    full_name VARCHAR(25),
	dob DATE,
    cpr INT,
    gender CHAR,
    email VARCHAR(30) DEFAULT NULL,
    phone INT DEFAULT NULL,
    class_number INT,
    FOREIGN KEY (class_number)
		REFERENCES class(id)
			ON UPDATE CASCADE
            ON DELETE SET NULL,
    PRIMARY KEY (id));

################################################## 
################### STUD_DEP #####################   
-- Bridge table between student and dependent
-- Combination of FK's must be unique
##################################################

CREATE TABLE stud_dep(
	student_id INT 
		NOT NULL,
    dependent_id INT 
		NOT NULL,
    FOREIGN KEY (student_id) 
		REFERENCES student(id) 
			ON UPDATE CASCADE 
			ON DELETE RESTRICT,
    FOREIGN KEY (dependent_id) 
		REFERENCES dependent(dep_id) 
			ON UPDATE CASCADE 
			ON DELETE CASCADE,
	UNIQUE KEY `unique_comb`(student_id, dependent_id),
	PRIMARY KEY (student_id, dependent_id));

##################################################  
#################### SUBJECT #####################  
-- Constains subject name and subject level
##################################################

CREATE TABLE `subject`(
	id INT
		NOT NULL
        AUTO_INCREMENT,
	subject_name VARCHAR(15),
    subject_level INT,
    PRIMARY KEY (id));    
 
 ##################################################
 ################## EXAM_GRADES ###################
-- Exam grades contains student, a grade, a subject and a date of the exam
-- Student id and subject id is the primary key, as a student should only 
-- have one exam grade for a subject.
##################################################
 
CREATE TABLE exam_grades(
	student_id INT
		NOT NULL,
    subject_id INT
		NOT NULL,
    grade INT,
    exam_date DATE,
    FOREIGN KEY (student_id) 
		REFERENCES student(id) 
			ON UPDATE CASCADE 
            ON DELETE RESTRICT,
	FOREIGN KEY (subject_id) 
		REFERENCES `subject`(id) 
			ON UPDATE CASCADE 
            ON DELETE RESTRICT,
	UNIQUE KEY `exam_unq_comb`(student_id, subject_id),
	PRIMARY KEY (student_id, subject_id));

##################################################
###################### ROOM ######################
-- Room table holds room_number and amount of people it can hold at a given time
##################################################

CREATE TABLE room(
	room_number INT,
	size INT,
	PRIMARY KEY (room_number));

################################################## 
################## TIME_TABLE ####################   
-- Time table connects room, class, employee, and teacher together with a date and a time
-- So that the school can when teachers teach and what rooms are occupied
##################################################

CREATE TABLE time_table(
	id INT 
		NOT NULL 
        AUTO_INCREMENT,
    teacher_id INT,
    `subject_id` INT,
    class_number INT,
    room_number INT DEFAULT NULL,
    teach_date DATETIME,
    scheduled_time INT,
    FOREIGN KEY (room_number) 
		REFERENCES room(room_number)
			ON UPDATE CASCADE
            ON DELETE SET NULL,
	FOREIGN KEY (teacher_id) 
		REFERENCES employee(id)
			ON UPDATE CASCADE
            ON DELETE SET NULL,
	FOREIGN KEY (class_number)
		REFERENCES class(id)
			ON UPDATE CASCADE
            ON DELETE SET NULL,
	FOREIGN KEY (`subject_id`)
		REFERENCES `subject`(id)
			ON UPDATE CASCADE
            ON DELETE SET NULL,
	PRIMARY KEY (id));

##################################################
################### CAN_TEACH ####################    
-- Bridge table between employee (teacher) and subjects he/she is able to teach
##################################################

CREATE TABLE can_teach(
	teacher_id INT 
		NOT NULL,
    `subject_id` INT 
		NOT NULL,
    FOREIGN KEY (teacher_id)
		REFERENCES employee(id)
			ON UPDATE CASCADE
            ON DELETE CASCADE,
	FOREIGN KEY (`subject_id`)
		REFERENCES `subject`(id)
			ON UPDATE CASCADE
            ON DELETE CASCADE,
	UNIQUE KEY `unique_comb_teach`(teacher_id, subject_id),
	PRIMARY KEY (teacher_id, `subject_id`));

##################################################
-- CREATING EXTRA INDEXES
##################################################
-- As we're using these to join tables we have chosen to create indexes for them

CREATE INDEX idx_emp_name 
	ON employee(full_name);
    
CREATE INDEX idx_dep_name 
	ON dependent(full_name);

##################################################    
-- REQUIREMENTS (TRIGGERS/EVENTS) 
##################################################
# NOTE TRIGGERS SHOULD BE RUN AFTER POPULATING THE DATABASE!
# AND CAN BE FOUND IN "Trigger.sql"

