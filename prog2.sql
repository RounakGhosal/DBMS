CREATE DATABASE DAY3;
USE DAY3;

CREATE TABLE STUDENT(
student_id INT PRIMARY KEY,
name VARCHAR(25),
dept VARCHAR(10)
);

CREATE TABLE COURSE(
course_id INT PRIMARY KEY,
course_name VARCHAR(10)
);

CREATE TABLE ENROLL(
enroll_id INT PRIMARY KEY,
student_id INT,
FOREIGN KEY(student_id) REFERENCES STUDENT(student_id),
course_id INT,
FOREIGN KEY(course_id) REFERENCES COURSE(course_id),
grade INT NOT NULL
);

INSERT INTO STUDENT VALUES
(1, 'Amit', 'CSE'),
(2, 'Riya', 'IT'),
(3, 'Rahul', 'ECE'),
(4, 'Sneha', 'CSE'),
(5, 'Arjun', 'ME'),
(6, 'Neha', 'IT'),
(7, 'Karan', 'CSE'),
(8, 'Priya', 'ECE'),
(9, 'Ankit', 'ME'),
(10, 'Sonal', 'CSE');

INSERT INTO COURSE VALUES
(101, 'DBMS'),
(102, 'Operating Systems'),
(103, 'Data Structures'),
(104, 'Computer Networks'),
(105, 'Machine Learning'),
(106, 'Artificial Intelligence'),
(107, 'Software Engineering'),
(108, 'Cyber Security'),
(109, 'Cloud Computing'),
(110, 'Big Data');

INSERT INTO ENROLL VALUES
(1, 1, 101, 85),
(2, 2, 106, 78),
(3, 3, 103, 88),
(4, 4, 101, 92),
(5, 5, 104, 75),
(6, 6, 105, 81),
(7, 7, 106, 89),
(8, 8, 103, 84),
(9, 9, 105, 73),
(10, 10, 108, 90);

select C.course_name, 
count(E.student_id) as student_count
from ENROLL as E
join COURSE as C on E.course_id=C.course_id
group by C.course_name;

select S.name, C.course_name, E.grade
from STUDENT as S 
join ENROLL as E on S.student_id = E.student_id
join COURSE as C on E.course_id = C.course_id; 

select S.name, C.course_name, S.dept
from STUDENT as S
join ENROLL as E ON S.student_id = E.student_id
join COURSE AS C ON E.course_id = C.course_id
where dept = 'CSE';

SELECT S.name FROM STUDENT AS S
LEFT JOIN ENROLL AS E ON S.student_id = E.student_id
WHERE E.student_id is NULL;

INSERT INTO STUDENT VALUES (15, 'Amrita', 'CSE');
INSERT INTO COURSE VALUES
(111, 'IT');

SELECT C.course_name FROM COURSE AS C
LEFT JOIN ENROLL AS E ON C.course_id = E.course_id
WHERE E.enroll_id is NULL;

SELECT C.course_name, COUNT(E.student_id) AS student_count
FROM ENROLL E
JOIN COURSE C ON E.course_id = C.course_id
GROUP BY C.course_name
HAVING COUNT(E.student_id) > 1;