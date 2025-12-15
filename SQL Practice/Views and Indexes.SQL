CREATE TABLE Workers (
    EmpID INT,
    EmpName VARCHAR(50),
    Department VARCHAR(50),
    Salary INT
);

INSERT INTO Workers VALUES
(1, 'Amit', 'IT', 60000),
(2, 'Neha', 'HR', 45000),
(3, 'Rahul', 'IT', 70000),
(4, 'Pooja', 'Finance', 50000);

--Creating the view

create view vw_it_workers as
select empid, empname, salary
from workers
where department = 'IT';

--Use the view
select * from vw_it_workers

-- View with calculations
create view vw_salary_status as
select
Empname,salary,
case when salary>=60000 then 'High Salary'
else 'Normal salary'
end as salarystatus
from workers;

select * from vw_salary_status

-- View with GROUP BY

create view vw_department_Avg_salary as
select 
department,
Avg(Salary) as avgsalary
from workers
group by department;

select * from vw_department_avg_salary

-- View With Joins --

CREATE TABLE Students (
    StudentID INT,
    StudentName VARCHAR(50),
    CourseID INT
);
INSERT INTO Students VALUES
(1, 'Aarav', 101),
(2, 'Meera', 102),
(3, 'Kunal', 101),
(4, 'Riya', 103);

CREATE TABLE Courses (
    CourseID INT,
    CourseName VARCHAR(50),
    Fee INT
);

INSERT INTO Courses VALUES
(101, 'Data Science', 60000),
(102, 'AI & ML', 75000),
(103, 'Cyber Security', 50000);

select* from students
select * from courses

create view vw_student_course_details as
select
s.studentname,
c.coursename,
c.fee
from students s
join courses c
on c.courseid = s.courseid;

select * from vw_student_course_details

-- view for only data_Science students
create view vw_datascience_students as
select
s.studentname,
c.coursename
from students s
join courses c
on s.courseid=c.courseid
where coursename = 'datascience';

select * from vw_datascience_students

-- INDEXES --
--(Indexes are mainly used in querying big data)

CREATE TABLE employyees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    department VARCHAR(50),
    city VARCHAR(50),
    salary INT,
    join_date DATE
);
INSERT INTO employyees VALUES
(1, 'Amit', 'IT', 'Mumbai', 60000, '2021-01-10'),
(2, 'Neha', 'HR', 'Pune', 45000, '2020-03-15'),
(3, 'Rahul', 'IT', 'Mumbai', 75000, '2019-07-22'),
(4, 'Sneha', 'Finance', 'Delhi', 80000, '2018-11-05'),
(5, 'Vikas', 'IT', 'Bangalore', 70000, '2022-06-01'),
(6, 'Pooja', 'HR', 'Mumbai', 48000, '2021-09-19');

-- Query WITHOUT Index
SELECT *
FROM employyees
WHERE department = 'IT';

-- Create a SIMPLE INDEX
create index idx_department
on employyees(department);

--Query WITH Index
select * from employyees
where department = 'IT';

--Index on City
create index ix_city
on employyees (city);

--Query with index
select emp_name, salary
from employyees
where city='Mumbai'

--COMPOSITE INDEX
--Used when queries filter on more than one column

create index idx_city_department
on employyees (department,city);

--Practice query
select * from employyees
where department = 'IT'
and city = 'Mumbai';

--Unique Index
create unique index idx_unique_empname
on employyees (emp_name);

INSERT INTO employyees VALUES
(7, 'Amit', 'IT', 'Delhi', 65000, '2023-01-01');
--(This will now fail)



