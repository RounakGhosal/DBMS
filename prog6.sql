create database Window_Function;
use Window_Function;

CREATE TABLE Employee (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    department VARCHAR(30),
    salary INT,
    joining_date DATE
);

INSERT INTO Employee VALUES
(101,'Alice','HR',50000,'2022-01-10'),
(102,'Bob','IT',75000,'2021-05-18'),
(103,'Charlie','IT',75000,'2023-03-12'),
(104,'David','Finance',65000,'2020-11-01'),
(105,'Eva','HR',55000,'2021-09-15'),
(106,'Frank','Finance',72000,'2019-07-21'),
(107,'Grace','IT',90000,'2018-12-30'),
(108,'Helen','HR',50000,'2022-04-05'),
(109,'Ian','Finance',65000,'2023-01-17'),
(110,'Jack','IT',80000,'2022-10-25');


drop table Employee;
desc Employee;
select * from Employee;

select *,
ROW_NUMBER() OVER(ORDER BY salary DESC) as "Row"
from Employee;

select *,
ROW_NUMBER() OVER(PARTITION BY department ORDER BY salary desc) as "ROW"
from Employee;

select emp_name,department,salary
from (select emp_name,department,salary,
	row_number() over(PARTITION BY department ORDER BY salary desc) as RN
	from Employee) as T
where rn = 1;

select *,
RANK() OVER (ORDER BY salary) as "Rank"
from Employee; 

select emp_name,department,salary
from ( select *,
	   RANK() OVER(PARTITION BY department ORDER BY salary desc) as rn
       from Employee) as Temp
where rn between 1 and 2;

select emp_name,department,salary
from ( select *,
	   DENSE_RANK() OVER(PARTITION BY department ORDER BY salary desc) as rn
       from Employee) Temp
where rn=3;

select emp_name,salary,joining_date,
LAG(salary) OVER(ORDER BY joining_date) as "Previous_salary"
from Employee;

select emp_name,salary,joining_date,
lead(salary) OVER(ORDER BY joining_date) as "Next_salary"
from Employee;

select emp_name,salary,department,
FIRST_VALUE (salary) OVER(PARTITION BY department ORDER BY salary desc) as "Highest_salary"
from Employee;

select *
from(select *,
	NTILE(4) OVER (ORDER BY salary desc) as quartile
	from Employee
    ) t
where quartile = 1;

select *,
NTILE(5) OVER(PARTITION BY department ORDER BY salary desc) as "rank"
from Employee;

select emp_name,salary,department,
AVG(salary) OVER(PARTITION BY department) as avg_salary
from Employee;

select emp_name,joining_date,
SUM(salary) OVER (PARTITION BY department ORDER BY joining_date) as running_salary
from Employee;

WITH HIGHESTSALARY AS (
select *,
FIRST_VALUE(salary) OVER(PARTITION BY department ORDER BY salary desc) highest_salary
from Employee)
select * from HIGHESTSALARY;

with Average as (
select *,
AVG(salary) OVER(PARTITION BY department) as average_salary
from Employee)
select * from Average
where salary > average_salary;

select emp_name
from (select *,
	  MAX(salary) OVER () as max_salary
      from Employee
      ) t
where salary = max_salary;

with Maximum as (
select *,
RANK() OVER (order by salary desc) as rn
from Employee)
select emp_name,salary
from Maximum
where rn = 1;
      
