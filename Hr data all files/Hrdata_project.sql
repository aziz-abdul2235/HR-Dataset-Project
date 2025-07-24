Create database hrdata;
use hrdata;
select * from employee;

select distinct ExitDate from employee;

--- 1.List all employees who joined in 2023:
select * from employee where HireDate >= '2023-01-01'
and HireDate < '2024-01-01';
--- or
create view employee_2023 as
select * from employee 
where Year(hiredate) = '2023';

select * from employee_2023;

--- 2.Get the number of employees by department:
create view Total_employee as
select Department,count(*)
from employee group by Department;

select * from Total_employee;

--- 3.Find the average age of employees in each job role.
create view AvgAge as
select jobrole,avg(age)
from employee group by jobrole;

select * from AvgAge;

--- 4.Get a list of employees who are currently active (not exited).
create view ActiveEmployee as
select * from employee where exitdate is null or exitdate = '';

select * from activeemployee;

--- 5.Count of employees by employment type (Full-time, Part-time, Contract.)
Create view employeetypecount as
select employmenttype,count(*) from employee group by employmenttype;

select * from employeetypecount;

--- 6.Find the top 5 departments with the highest attrition (most exits).
create view attritioncount as
select department,Count(*) as attritioncount
from employee where exitdate is not null
group by department
order by attritioncount desc limit 5;

drop view attritioncount;

select * from attritioncount;

--- 7.List employees who have worked more than 5 years and are still active (longest-serving).
create view longestservings as
select EmployeeID,Name,Department,round(datediff(current_date(),  hiredate)/365,2) as years
from employee
where exitdate is null
and datediff(current_date(),  hiredate)/365 >5
order by years desc;

select * from longestservings;

--- 8. Get gender diversity ratio by department (Male,Female count).
create view Gendercountdeptwise As
select department,
sum(case when gender = 'Male' then 1 else 0 end) as Malecount,
sum(case when gender = 'Female' then 1 else 0 end) as Femalecount
from employee
group by Department;

select * from Gendercountdeptwise;
