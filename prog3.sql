CREATE DATABASE PRACTICE_1;
USE PRACTICE_1;

CREATE TABLE STUDENT(
student_id int primary key,
name varchar(25) not null,
age int,
constraint check_age check(age > 0),
city varchar(10)
);

INSERT INTO STUDENT (student_id, name, age, city) VALUES
(1, 'Rohan', 21, 'Kolkata'),
(2, 'Amit', 22, 'Delhi'),
(3, 'Priya', 20, 'Mumbai'),
(4, 'Sneha', 23, 'Pune'),
(5, 'Rahul', 19, 'Chennai'),
(6, 'Anjali', 24, 'Kolkata'),
(7, 'Vikram', 22, 'Bangalore'),
(8, 'Neha', 21, 'Hyderabad'),
(9, 'Arjun', 25, 'Delhi'),
(10, 'Pooja', 20, 'Mumbai');

CREATE TABLE COURSE(
course_id int primary key,
course varchar(25));

INSERT INTO COURSE (course_id, course) VALUES
(101, 'DBMS'),
(102, 'Data Structures'),
(103, 'Operating System'),
(104, 'Computer Networks'),
(105, 'Machine Learning'),
(106, 'Artificial Intelligence'),
(107, 'Web Development'),
(108, 'Cloud Computing'),
(109, 'Cyber Security'),
(110, 'Software Engineering');

create table ENROLL (
student_id int,
foreign key (student_id) references STUDENT(student_id),
course_id int,
foreign key (course_id) references COURSE(course_id),
marks int not null
);

INSERT INTO ENROLL (student_id, course_id, marks) VALUES
(1, 101, 85),
(2, 101, 88),
(2, 103, 74),
(3, 105, 87),
(4, 104, 69),
(4, 105, 72),
(5, 103, 80),
(5, 106, 76),
(6, 101, 95),
(6, 107, 89),
(7, 102, 77),
(8, 109, 90),
(8, 105, 82),
(9, 101, 67),
(9, 110, 73),
(10, 106, 88),
(10, 107, 92);

select student_id,name from STUDENT 
where age > 20;

select name , age from STUDENT
order by age asc
limit 3;

select count(student_id) from STUDENT;
select avg(age) from STUDENT;
SELECT MIN(marks) FROM ENROLL;

SELECT COUNT(student_id), city FROM STUDENT
GROUP BY city;

SELECT S.name, C.course 
FROM STUDENT AS S
JOIN ENROLL AS E ON S.student_id = E.student_id
JOIN COURSE AS C ON E.course_id = C.course_id;

select distinct(S.name) 
from STUDENT as S
join ENROLL as E on S.student_id = E.student_id
join COURSE as C on E.course_id = C.course_id;

select S.name 
from STUDENT AS S
LEFT JOIN ENROLL AS E ON S.student_id = E.student_id
where E.student_id = NULL;

select C.course,count(E.student_id) as Student_count
from STUDENT as S
join ENROLL as E on S.student_id = E.student_id
join COURSE as C on E.course_id = C.course_id
group by C.course;

select course,avg(marks) as Average
from STUDENT as S
join ENROLL as E on S.student_id = E.student_id
join COURSE as C on E.course_id = C.course_id
group by course;

select name,course,marks
from STUDENT as S
join ENROLL as E on S.student_id = E.student_id
join COURSE as C on E.course_id = C.course_id
having marks > (select avg(marks) from ENROLL);

SELECT C.course
FROM COURSE AS C
JOIN ENROLL AS E ON C.course_id = E.course_id
GROUP BY C.course
HAVING COUNT(E.student_id) >= 2;

SELECT C.course, AVG(E.marks)
FROM COURSE AS C 
JOIN ENROLL AS E ON C.course_id = E.course_id
GROUP BY C.course
HAVING AVG(E.marks) > 80;

select C.course, avg(E.marks) as AVG_Marks
from COURSE AS C
JOIN ENROLL AS E ON C.course_id = E.course_id
group by C.course
order by AVG_Marks desc;

select S.name, E.marks , C.course
from STUDENT AS S
JOIN ENROLL AS E ON S.student_id = E.student_id
join COURSE as C on C.course_id = E.course_id
where E.marks > (select avg(E.marks)
				  from COURSE AS C 
                  JOIN ENROLL AS E ON C.course_id = E.course_id);
                  
select city, count(student_id) as Count
from STUDENT
group by city
having Count >= 2;

select C.course, avg(E.marks) as Average
from COURSE AS C 
JOIN ENROLL AS E ON C.course_id =E.course_id
group by C.course
having Average > 75;

select S.name, C.course, E.marks
from STUDENT as S
join ENROLL as E on S.student_id = E.student_id
join COURSE AS C on C.course_id = E.course_id
where (C.course_id, E.marks) in
		(select course_id , max(marks)
        from ENROLL
        group by course_id);
        
