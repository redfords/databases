/*
Finding Updated Records

We have a table with employees and their salaries, however, some of the records are old and contain outdated salary information.
Find the current salary of each employee assuming that salaries increase each year. Output their id, first name, last name,
department ID, and current salary. Order your list by employee ID in ascending order.

ms_employee_salary
id: int
first_name: varchar
last_name: varchar
salary: int
department_id: int
*/

with max_salary as (
  select
  id,
  first_name,
  last_name,
  department_id,
  salary,
  rank () over (partition by id order by salary desc) as rank
  from ms_employee_salary )
select
id,
first_name,
last_name,
department_id,
salary
from max_salary
where rank = 1
order by id asc;


/*
Find the base pay for Police Captains

Output the employee name along with the corresponding base pay.

sf_public_salaries
id: int
employeename: varchar
jobtitle: varchar
basepay: float
overtimepay: float
otherpay: float
benefits: float
totalpay: float
totalpaybenefits: float
year: int
notes: datetime
agency: varchar
status: varchar
*/

select
employeename,
basepay
from sf_public_salaries
where jobtitle like '%CAPTAIN%POLICE%';

