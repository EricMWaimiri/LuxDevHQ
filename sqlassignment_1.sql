-- Create schema and set search path
CREATE SCHEMA nairobi_academy;
SET search_path TO nairobi_academy;

-- Students table
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    gender VARCHAR(1),
    class VARCHAR(10),
    city VARCHAR(50)
);

-- Subjects table
CREATE TABLE subjects (
    subject_id INT PRIMARY KEY,
    subject_name VARCHAR(100) NOT NULL UNIQUE,
    department VARCHAR(50),
    teacher_name VARCHAR(100),
    credits INT
);

-- Exam results table
CREATE TABLE exam_results (
    result_id INT PRIMARY KEY,
    student_id INT NOT NULL REFERENCES students(student_id),
    subject_id INT NOT NULL REFERENCES subjects(subject_id),
    marks INT NOT NULL,
    exam_date DATE,
    grade VARCHAR(2)
);

-- Add phone_number column
ALTER TABLE students ADD COLUMN phone_number VARCHAR(20);

-- Rename credits → credit_hours
ALTER TABLE subjects RENAME COLUMN credits TO credit_hours;

-- Drop phone_number column
ALTER TABLE students DROP COLUMN phone_number;


-- Insert 10 students
INSERT INTO students (student_id, first_name, last_name, gender, class, city)
VALUES
(1, 'John', 'Mwangi', 'M', 'Form 1', 'Nairobi'),
(2, 'Mary', 'Wanjiru', 'F', 'Form 2', 'Mombasa'),
(3, 'Peter', 'Otieno', 'M', 'Form 3', 'Kisumu'),
(4, 'Grace', 'Kamau', 'F', 'Form 4', 'Nakuru'),
(5, 'Esther', 'Akinyi', 'F', 'Form 2', 'Nakuru'),
(6, 'David', 'Mutua', 'M', 'Form 3', 'Nairobi'),
(7, 'Alice', 'Njeri', 'F', 'Form 1', 'Mombasa'),
(8, 'Brian', 'Omondi', 'M', 'Form 4', 'Kisumu'),
(9, 'Cynthia', 'Chebet', 'F', 'Form 2', 'Nairobi'),
(10, 'Eric', 'Kiptoo', 'M', 'Form 3', 'Eldoret');

-- Insert 10 subjects
INSERT INTO subjects (subject_id, subject_name, department, teacher_name, credit_hours)
VALUES
(1, 'Mathematics', 'Sciences', 'Mr. Otieno', 4),
(2, 'English', 'Languages', 'Ms. Wanjiru', 3),
(3, 'Biology', 'Sciences', 'Dr. Achieng', 4),
(4, 'Chemistry', 'Sciences', 'Mr. Kamau', 4),
(5, 'Physics', 'Sciences', 'Ms. Mwangi', 4),
(6, 'History', 'Humanities', 'Mr. Kiptoo', 3),
(7, 'Geography', 'Humanities', 'Ms. Chebet', 3),
(8, 'Business Studies', 'Commerce', 'Mr. Mutua', 3),
(9, 'Computer Studies', 'Sciences', 'Ms. Njeri', 3),
(10, 'Kiswahili', 'Languages', 'Mr. Omondi', 3);

-- Insert 10 exam results
INSERT INTO exam_results (result_id, student_id, subject_id, marks, exam_date, grade)
VALUES
(1, 1, 1, 75, '2024-03-15', 'B'),
(2, 2, 2, 68, '2024-03-15', 'C'),
(3, 3, 3, 82, '2024-03-16', 'A'),
(4, 4, 4, 55, '2024-03-16', 'C'),
(5, 5, 5, 49, '2024-03-17', 'D'),
(6, 6, 6, 72, '2024-03-17', 'B'),
(7, 7, 7, 64, '2024-03-18', 'C'),
(8, 8, 8, 90, '2024-03-18', 'A'),
(9, 9, 9, 77, '2024-03-18', 'B'),
(10, 10, 10, 61, '2024-03-18', 'C');

-- Confirm rows
SELECT COUNT(*) FROM students;
SELECT COUNT(*) FROM subjects;
SELECT COUNT(*) FROM exam_results;

-- Update Esther Akinyi’s city
UPDATE students SET city = 'Nairobi' WHERE student_id = 5;

-- Correct marks for result_id 5
UPDATE exam_results SET marks = 59 WHERE result_id = 5;

-- Delete exam result with result_id 9
DELETE FROM exam_results WHERE result_id = 9;


-- Students in Form 4
SELECT * FROM students WHERE class = 'Form 4';

-- Subjects in Sciences department
SELECT * FROM subjects WHERE department = 'Sciences';

-- Exam results marks >= 70
SELECT * FROM exam_results WHERE marks >= 70;

-- Female students
SELECT * FROM students WHERE gender = 'F';

-- Form 3 AND Nairobi
SELECT * FROM students WHERE class = 'Form 3' AND city = 'Nairobi';

-- Form 2 OR Form 4
SELECT * FROM students WHERE class IN ('Form 2', 'Form 4');


-- Marks between 50 and 80
SELECT * FROM exam_results WHERE marks BETWEEN 50 AND 80;

-- Exams between 15–18 March 2024
SELECT * FROM exam_results WHERE exam_date BETWEEN '2024-03-15' AND '2024-03-18';

-- Students in Nairobi, Mombasa, Kisumu
SELECT * FROM students WHERE city IN ('Nairobi', 'Mombasa', 'Kisumu');

-- Students NOT in Form 2 or 3
SELECT * FROM students WHERE class NOT IN ('Form 2', 'Form 3');

-- Names starting with A or E
SELECT * FROM students WHERE first_name LIKE 'A%' OR first_name LIKE 'E%';

-- Subjects containing 'Studies'
SELECT * FROM subjects WHERE subject_name LIKE '%Studies%';

-- Count Form 3 students
SELECT COUNT(*) AS form3_count FROM students WHERE class = 'Form 3';

-- Count exam results marks >= 70
SELECT COUNT(*) AS high_scores FROM exam_results WHERE marks >= 70;

-- Performance labels
SELECT result_id, student_id, subject_id, marks,
CASE
    WHEN marks >= 80 THEN 'Distinction'
    WHEN marks >= 60 THEN 'Merit'
    WHEN marks >= 40 THEN 'Pass'
    ELSE 'Fail'
END AS performance
FROM exam_results;

-- Student level labels
SELECT first_name, last_name, class,
CASE
    WHEN class IN ('Form 3', 'Form 4') THEN 'Senior'
    WHEN class IN ('Form 1', 'Form 2') THEN 'Junior'
END AS student_level
FROM students;
