-- Active: 1730458426931@@127.0.0.1@5432@university_db
-- CREATE DATABASE university_db;

CREATE Table students (
  student_id SERIAL PRIMARY KEY,
  student_name VARCHAR(100),
  age INT,
  email VARCHAR(100),
  frontend_mark INT,
  backend_mark INT,
  status VARCHAR(100)
)

CREATE Table courses(
  course_id SERIAL PRIMARY KEY,
  course_name VARCHAR(100),
  credits INT
)

CREATE Table enrollment (
  enrollment_id SERIAL PRIMARY KEY,
  student_id INT REFERENCES students(student_id),
  course_id INT REFERENCES courses(course_id)
)

INSERT into students (student_name, age, email,frontend_mark, backend_mark,status) VALUES 
('Sameer',21,'sameer@example.com',48,60,NULL),
('Zoya',23,'zoya@example.com',52,58,NULL),
('Nabil',22,'nabil@example.com',37,46,NULL),
('Rafi',24,'rafi@example.com',41,40,NULL),
('Sophia',22,'sophia@example.com',50,52,NULL),
('Hasan',23,'hasan@gmail.com',43,39,NULL)


INSERT INTO courses (course_name, credits) VALUES ('Next.js',	3),('React.js',	4),('Databases',	3),('Prisma',	3)

INSERT into enrollment ( student_id, course_id) VALUES (1	,1), (1,	2), (2,	1),(3,	2);

-- Query 1: Insert a new student record with the following details:
INSERT INTO students (student_name, age, email,frontend_mark, backend_mark,status) VALUES ('Md',27,'md@gmail.com',50,50,NULL);

-- Query 2: Retrieve the names of all students who are enrolled in the course titled 'Next.js'.

SELECT students.student_name FROM students
join enrollment on students.student_id = enrollment.student_id
join courses on courses.course_id = enrollment.course_id
WHERE courses.course_name = 'Next.js'


-- Query 3: Update the status of the student with the highest total (frontend_mark + backend_mark) to 'Awarded'.

UPDATE students
SET status = 'Awarded'
WHERE students.frontend_mark + students.backend_mark = (
    SELECT MAX(frontend_mark + backend_mark) 
    FROM students
);

-- Query 4: Delete all courses that have no students enrolled.
DELETE from courses
WHERE courses.course_id NOT IN(SELECT DISTINCT courses.course_id from courses
join enrollment on courses.course_id = enrollment.course_id)



-- Query 5:Retrieve the names of students using a limit of 2, starting from the 3rd student.

SELECT students.student_name FROM students limit 2 OFFSET 2;

-- Query 6:Retrieve the course names and the number of students enrolled in each course.
SELECT courses.course_name, count(courses.course_id) FROM courses
join enrollment on courses.course_id = enrollment.course_id
GROUP BY courses.course_id


-- Query 7: Calculate and display the average age of all students.
SELECT avg(age) as average_age from students


-- Query 8: Retrieve the names of students whose email addresses contain 'example.com'.

SELECT students.student_name from students
where students.email LIKE '%example.com'


-- 1. What is PostgreSQL?
-- PostgreSQL is open source relational database management system.

-- 2. What is the purpose of a database schema in PostgreSQL?
-- It's a logical container of tables, views, idexes and many more

-- Primary key: uniquely indetify a row of table
-- 3. Explain the primary key and foreign key concepts in PostgreSQL.
--Foreign key: it's column of a table that referances the primary key of another table. it create a relation among those tables. 


-- 4. What is the difference between the VARCHAR and CHAR data types?
-- varchar varible length string data type, char fixed length string data type

-- 5. Explain the purpose of the WHERE clause in a SELECT statement.
-- Filtering rows

-- 6. What are the LIMIT and OFFSET clauses used for?
-- to control the subset of rows return in a query

-- 7. How can you perform data modification using UPDATE statements?
-- update table
-- set column = value

-- 8. What is the significance of the JOIN operation, and how does it work in PostgreSQL?
-- create virtual table on relation of primary key and foreign key
-- select table1
-- join table2 on table1.same_column = table2.same_column

-- 9. Explain the GROUP BY clause and its role in aggregation operations.
-- Groups the selected rows based on one or more attributes

-- 10. How can you calculate aggregate functions like COUNT, SUM, and AVG in PostgreSQL?
-- used with select to return mathematical summaries on columns
-- select aggregate_function(column)
-- From Table