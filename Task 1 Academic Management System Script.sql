-- Task 1: Academic Mangement System

-- 1. Database Creation: 

-- Creating a Database
Create database academic_management;

-- Using Database
use academic_management;

-- a) Creating first table 'StudentInfo'

CREATE TABLE StudentInfo (
    STU_ID INT PRIMARY KEY,
    STU_NAME VARCHAR(100),
    DOB DATE,
    PHONE_NO VARCHAR(15),
    EMAIL_ID VARCHAR(100),
    ADDRESS TEXT
);

-- b) Creating second table 'CoursesInfo'

CREATE TABLE CoursesInfo (
    COURSE_ID INT PRIMARY KEY,
    COURSE_NAME VARCHAR(100),
    COURSE_INSTRUCTOR_NAME VARCHAR(100)
);

-- c) Creating third table 'EnrollmentInfo Table'

CREATE TABLE EnrollmentInfo (
    ENROLLMENT_ID INT PRIMARY KEY,
    STU_ID INT,
    COURSE_ID INT,
    ENROLL_STATUS VARCHAR(20),
    FOREIGN KEY (STU_ID) REFERENCES StudentInfo(STU_ID),
    FOREIGN KEY (COURSE_ID) REFERENCES CoursesInfo(COURSE_ID)
);

-- 2. Data Creation

-- a) Inserting the values in the table 'StudentInfo'

INSERT INTO StudentInfo VALUES
(1, 'Virat Kohli', '1988-11-05', '9876543210', 'virat.kohli@cric.in', 'Delhi'),
(2, 'Rohit Sharma', '1987-04-30', '9812345678', 'rohit.sharma@cric.in', 'Mumbai'),
(3, 'MS Dhoni', '1981-07-07', '9123456780', 'ms.dhoni@cric.in', 'Ranchi'),
(4, 'Jasprit Bumrah', '1993-12-06', '9988776655', 'jasprit.bumrah@cric.in', 'Ahmedabad'),
(5, 'Hardik Pandya', '1993-10-11', '9874501234', 'hardik.pandya@cric.in', 'Surat');

-- b) Inserting the values in the table 'CoursesInfo'

INSERT INTO CoursesInfo VALUES
(101, 'Data Structures', 'Dr. Neeraj Yadav'),
(102, 'SQL & Databases', 'Prof. Anjali Verma'),
(103, 'Operating Systems', 'Dr. Ramesh Iyer'),
(104, 'Computer Networks', 'Prof. Swati Patel');

-- c) Inserting the values in the table 'EnrollmentInfo'

INSERT INTO EnrollmentInfo VALUES
(1001, 1, 101, 'Enrolled'),
(1002, 1, 102, 'Enrolled'),
(1003, 2, 102, 'Enrolled'),
(1004, 2, 103, 'Enrolled'),
(1005, 3, 101, 'Enrolled'),
(1006, 3, 104, 'Not Enrolled'),
(1007, 4, 104, 'Enrolled'),
(1008, 5, 101, 'Enrolled'),
(1009, 5, 102, 'Enrolled'),
(1010, 5, 103, 'Enrolled');

-- 3. Retrieve the Student Information

-- a) Write a query to retrieve student details, such as student name, contact information, and Enrollment status.

SELECT s.STU_NAME, s.PHONE_NO, s.EMAIL_ID, e.ENROLL_STATUS
FROM StudentInfo s
JOIN EnrollmentInfo e ON s.STU_ID = e.STU_ID;

-- b) Write a query to retrieve a list of courses in which a specific student is enrolled. 

SELECT s.STU_NAME, c.COURSE_NAME
FROM EnrollmentInfo e
JOIN StudentInfo s ON e.STU_ID = s.STU_ID
JOIN CoursesInfo c ON e.COURSE_ID = c.COURSE_ID
WHERE s.STU_NAME = 'Virat Kohli' AND e.ENROLL_STATUS = 'Enrolled';

-- c) Write a query to retrieve course information, including course name, instructor information. 

SELECT COURSE_NAME, COURSE_INSTRUCTOR_NAME
FROM CoursesInfo;

-- d) Write a query to retrieve course information fpr a specific course. 

SELECT *
FROM CoursesInfo
WHERE COURSE_NAME = 'SQL & Databases';

-- e) Write a query to retrieve course information for multiple courses.

SELECT *
FROM CoursesInfo
WHERE COURSE_NAME IN ('Data Structures', 'Operating Systems');

-- 4. Reporting and Analytics 

-- a) Write a query to retrieve the number of students enrolled in each course.

SELECT c.COURSE_NAME, COUNT(e.STU_ID) AS Enrolled_Students
FROM CoursesInfo c
JOIN EnrollmentInfo e ON c.COURSE_ID = e.COURSE_ID
WHERE e.ENROLL_STATUS = 'Enrolled'
GROUP BY c.COURSE_NAME;

-- b) Write a query to retrieve the list of students enrolled in a specific course. 

SELECT s.STU_NAME
FROM StudentInfo s
JOIN EnrollmentInfo e ON s.STU_ID = e.STU_ID
JOIN CoursesInfo c ON c.COURSE_ID = e.COURSE_ID
WHERE c.COURSE_NAME = 'SQL & Databases' AND e.ENROLL_STATUS = 'Enrolled';

-- c) Write a query to retrieve the count of enrolled student for each instructor. 

SELECT c.COURSE_INSTRUCTOR_NAME, COUNT(e.STU_ID) AS Total_Enrolled
FROM CoursesInfo c
JOIN EnrollmentInfo e ON c.COURSE_ID = e.COURSE_ID
WHERE e.ENROLL_STATUS = 'Enrolled'
GROUP BY c.COURSE_INSTRUCTOR_NAME;

-- d) Write a query to retrieve the list of students who are enrolled in multiple courses.

SELECT s.STU_NAME
FROM StudentInfo s
JOIN EnrollmentInfo e ON s.STU_ID = e.STU_ID
WHERE e.ENROLL_STATUS = 'Enrolled'
GROUP BY s.STU_NAME
HAVING COUNT(e.COURSE_ID) > 1;

-- e) Write a query to retrieve the courses that have the highest number of enrolled students (arranging from highest to lowest)

SELECT c.COURSE_NAME, COUNT(e.STU_ID) AS Enrolled_Students
FROM CoursesInfo c
JOIN EnrollmentInfo e ON c.COURSE_ID = e.COURSE_ID
WHERE e.ENROLL_STATUS = 'Enrolled'
GROUP BY c.COURSE_NAME
ORDER BY Enrolled_Students DESC;

-- ---------------------------------The End ----------------------------