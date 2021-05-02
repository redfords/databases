/* Exchange Seats
Mary is a teacher in a middle school and she has a table seat storing students' names and their
corresponding seat ids. The column id is continuous increment. Mary wants to change seats for the
adjacent students.

+---------+---------+
|    id   | student |
+---------+---------+
|    1    | Abbot   |
|    2    | Doris   |
|    3    | Emerson |
|    4    | Green   |
|    5    | Jeames  |
+---------+---------+

For the sample input, the output is:
+---------+---------+
|    id   | student |
+---------+---------+
|    1    | Doris   |
|    2    | Abbot   |
|    3    | Green   |
|    4    | Emerson |
|    5    | Jeames  |
+---------+---------+

Note: If the number of students is odd, there is no need to change the last one's seat. */

select
case
    when id % 2 = 1 and id = (select max(id) from seat) then id
    when id % 2 = 1 and id <> (select max(id) from seat) then (id + 1)
    when id % 2 = 0 then (id - 1)
end as id,
student
from seat
order by id

/* Department Highest Salary
The Employee table holds all employees. Every employee has an Id, a salary, and there is also a column
for the department Id.

+----+-------+--------+--------------+
| Id | Name  | Salary | DepartmentId |
+----+-------+--------+--------------+
| 1  | Joe   | 70000  | 1            |
| 2  | Jim   | 90000  | 1            |
| 3  | Henry | 80000  | 2            |
| 4  | Sam   | 60000  | 2            |
| 5  | Max   | 90000  | 1            |
+----+-------+--------+--------------+

The Department table holds all departments of the company.
+----+----------+
| Id | Name     |
+----+----------+
| 1  | IT       |
| 2  | Sales    |
+----+----------+

Write a SQL query to find employees who have the highest salary in each of the departments. For the
above tables, your SQL query should return the following rows (order of rows does not matter).
+------------+----------+--------+
| Department | Employee | Salary |
+------------+----------+--------+
| IT         | Max      | 90000  |
| IT         | Jim      | 90000  |
| Sales      | Henry    | 80000  |
+------------+----------+--------+
*/

with dept_salary as (
    select department.name as department, employee.name as employee, salary,
           dense_rank() over(partition by department.name order by salary desc) as rownum
        from employee
        inner join
        department on
        employee.departmentid = department.id
)
select department, employee, salary
    from dept_salary
    where rownum = 1;

select department, employee, salary
from (
    select department.name as department, employee.name as employee, salary,
        dense_rank() over(partition by department.name order by salary desc) as rownum
    from employee
    inner join
    department on
    employee.departmentid = department.id) dept_salary
where rownum = 1