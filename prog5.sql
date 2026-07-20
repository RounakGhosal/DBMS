create database Day5;
use Day5;

create table Employee(
emp_id INT PRIMARY KEY,
emp_name VARCHAR(30),
dept VARCHAR(10),
salary INT,
age INT,
city VARCHAR(20)
);

insert into Employee values
(1,'Vikash Singh','IT',50000,26,'Lucknow'),
(2,'Vivek Roy','IT',40000,23,'Delhi'),
(3,'Disha Patani','HR',70000,36,'Mumbai'),
(4,'Amal Das','IT',50000,28,'Kolkata'),
(5,'Priti Ghosh','Acounts',30000,22,'Kolkata'),
(6,'Rahul Roy','IT',55000,26,'Jamshedpur'),
(7,'Bablu Pandit','HR',50000,30,'Kanpur'),
(8,'Anirban Dutta','IT',50000,32,'Delhi'),
(9,'Sabyasachi Chatterjee','Acounts',60000,36,'Kolkata'),
(10,'Bina Muthuswami','Acounts',40000,27,'Chennai');

SHOW COLUMNS FROM Employee;
DESC Employee;

select emp_name, salary from Employee;

select * from Employee
where dept = 'IT';

select dept, count(emp_id) as emp_count
from Employee
group by dept
having emp_count >= 3;

select dept, avg(salary) as avg_salary
from Employee
group by dept;

select dept, max(salary) as max_salary
from Employee
group by dept;

select dept, sum(salary) as total_salary
from Employee
group by dept;

select dept, avg(salary) as avg_salary
from Employee
group by dept
having avg_salary > 45000;

select distinct city
from Employee;

select * from Employee
order by salary DESC
limit 3;

select dept, emp_name, salary from(
	select *,ROW_NUMBER() OVER (partition by dept order by salary desc) as rn
    from Employee
) as t
where rn <=2;

select e.*
from Employee e
join (
	select dept, max(salary) as max_salary
    from Employee
    group by dept
) as m
on e.dept = m.dept
and e.salary = m.max_salary;