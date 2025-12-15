--WINDOW FUNCTIONS --
-- A window function performs calculations across related rows without reducing the rows
--Unlike Group By, Rows are not merged

--BASIC SYNTAX--
function() over(
partition by column
order by column0

)

CREATE TABLE employees (
    employeeid INT primary key,
    employeename VARCHAR(50),
   Department VARCHAR(50),
    salary decimal (10,2)
	);

INSERT INTO employees VALUES
(1, 'John',   'HR', 50000),
(2, 'Jane',   'HR', 55000),
(3, 'Bob',  'IT', 70000),
(4, 'Alice',  'IT', 75000), 
(5, 'Charlie', 'IT', 72000),
(6, 'Dave', 'Sales', 60000),
(7, 'Eve', 'Sales', 65000),
(8, 'Frank', 'Sales', 62000),
(9, 'Grace', 'HR', 53000),
(10, 'Heidi', 'IT', 68000);


select * from employees

--ROW NUMBERS --
--Assigns a unique number
--Starts from 1
--Resets for each partition

--Find Highest paid employee in each department--
select employeeid,employeename,department,salary,row_number()
over(partition by department order by salary desc) as row_num
from employees

-- fetching top paid employee in each department
select * from (select employeeid,employeename,department,salary,
row_number() over(partition by department order by salary desc)
as row_num from employees) as subquery where row_num=1;

--Lowest paid employee in each departmentloyees
select employeeid,employeename,department,salary,row_number()
over(partition by department order by salary asc)as row_num from 
employees

--Top 2 earners per department
SELECT employeeid,
       employeename,
       department,
       salary,
       row_num
FROM (
    SELECT employeeid,
           employeename,
           department,
           salary,
           ROW_NUMBER() OVER (PARTITION BY department ORDER BY salary DESC) AS row_num
    FROM employees
) t
WHERE row_num <= 2;

--“Who is the 3rd highest-paid employee per department?”
SELECT employeeid,employeename,salary,department,rn
from ( select employeeid,employeename,salary,department,row_number()
over(partition by department order by salary desc) as rn 
from employees) t where rn=3;

--RANK AND DENSERRANK--
--RANK
--assigns same rank to equal values and skips numbers after tie
--DENSERANK
--assigns same rank to equal values and does not skip numbers after tie

--Salary ranking inside each department
-- Using RANK()

select employeeid,
employeename,
salary,
department,
rank() over(partition by department order by salary desc)
as rank_num from employees

--using denserank
select employeeid,
employeename,
salary,
department,
dense_rank()
over(partition by department order by salary desc) as denserank
from employees;

--2nd highest salary per department (with ties)
--Using DENSE_RANK

select employeeid,
employeename, salary,
department,dense_rank
from (select employeeid,
employeename, salary,
department,dense_rank()
over(partition by department order by salary desc)
as dense_rank from employees) t where dense_rank=3

--NTILE--
--NTILE(n) divides rows into n nearly equal groups
--Each row is assigned a bucket number: 1, 2, 3, ... n

--Basic Syntax
Ntile(n) over (ordeer by column)
Ntile(n) over (partition by department order by column)

--Divide employees into 3 salary groups (company-wide)
select 
employeeid,
employeename,
salary,
department,
ntile(3) over(order by salary desc) as salary_bucket
from employees;

--Salary buckets within each department
select employeeid,
employeename,
salary,
department,
ntile(2) over(partition by department order by salary desc)
as dept_salary_level from employees

--Top 25% earners in each department
select employeeid,
employeename,
salary,
department from (select employeeid,
employeename,
salary,
department,
ntile(4) over(partition by department order by salary desc)
as quartile from employees)t where quartile=1;

--AVERAGE AND COUNT FUNCTIONS --

--Show each employee with the average salary of their department.

select employeeid,
employeename,
salary,
department,
avg(salary) over(partition by department) as avg_dept_salary
from employees;

--Company-wide average salary
SELECT
    employeeid,
    employeename,
    salary,
    AVG(salary) OVER () AS company_avg_salary
FROM employees;

--Number of employees per department
SELECT
    employeeid,
    employeename,
    department,
	count(*) over(partition by department) as emp_per_Dept
	from employees;

	--Total employees in the compan
	select employeeid,
	employeename,
	count(*) over() as total_employees
	from employees

--SUM TOTAL & RUNNING TOTAL--
--SUM() calculates total
--Running Adds current row’s value to all previous rows

--Total salary per department
SELECT
    employeeid,
    employeename,
    department,
    salary,
	sum(salary) over(partition by department) as total_dept_salary
	from employees;

--Running total of salaries within each department
SELECT
    employeeid,
    employeename,
    department,
    salary,
    SUM(salary) OVER (
        PARTITION BY department
        ORDER BY salary DESC
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_salary_total
FROM employees;

--Company-wide running total (highest salary first)
select employeeid,
employeename,
salary,
sum(salary) over(order by salary desc rows between unbounded
preceding and current row) as company_running_total
from employees;