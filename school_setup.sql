DROP DATABASE IF EXISTS school;
CREATE DATABASE school;
USE school;

##################################################
-- DATABASE SETUP
##################################################
-- TABLES
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
    
-- Teacher/employee
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
    
CREATE TABLE stud_dep(
	student_id INT NOT NULL,
    dependent_id INT NOT NULL,
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
    
CREATE TABLE `subject`(
	id INT
		NOT NULL
        AUTO_INCREMENT,
	subject_name VARCHAR(15),
    subject_level INT,
    PRIMARY KEY (id));    
 
CREATE TABLE exam_grades(
	student_id INT,
    `subject_id` INT,
    grade INT,
    exam_date DATE,
    FOREIGN KEY (student_id) 
		REFERENCES student(id) 
			ON UPDATE CASCADE 
            ON DELETE restrict,
	FOREIGN KEY (`subject_id`) 
		REFERENCES `subject`(id) 
			ON UPDATE CASCADE 
            ON DELETE RESTRICT,
	PRIMARY KEY (student_id, `subject_id`));

CREATE TABLE room(
	room_number INT,
	size INT,
	PRIMARY KEY (room_number));

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

CREATE TABLE can_teach(
	teacher_id INT NOT NULL,
    `subject_id` INT NOT NULL,
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
CREATE INDEX idx_emp_name ON employee(full_name);
CREATE INDEX idx_dep_name ON dependent(full_name);

##################################################    
-- REQUIREMENTS (TRIGGERS/EVENTS) 
##################################################
# NOTE TRIGGERS SHOULD BE RUN AFTER POPULATING THE DATABASE!

