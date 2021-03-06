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

/* Nth Highest Salary
Write a SQL query to get the nth highest salary from the Employee table.

+----+--------+
| Id | Salary |
+----+--------+
| 1  | 100    |
| 2  | 200    |
| 3  | 300    |
+----+--------+

For example, given the above Employee table, the nth highest salary where n = 2 is 200. If there is no
nth highest salary, then the query should return null.
+------------------------+
| getNthHighestSalary(2) |
+------------------------+
| 200                    |
+------------------------+
*/

create function getNthHighestSalary(n int) returns int
begin
    set n = n - 1
    return (
        select distinct Salary from Employee order by Salary desc limit 1 offset n
    );
end


/*  Rank Scores
Write a SQL query to rank scores. If there is a tie between two scores, both should have the same
ranking. Note that after a tie, the next ranking number should be the next consecutive integer value.
In other words, there should be no "holes" between ranks.

+----+-------+
| Id | Score |
+----+-------+
| 1  | 3.50  |
| 2  | 3.65  |
| 3  | 4.00  |
| 4  | 3.85  |
| 5  | 4.00  |
| 6  | 3.65  |
+----+-------+

For example, given the above Scores table, your query should generate the following report (order by
highest score):
+-------+---------+
| score | Rank    |
+-------+---------+
| 4.00  | 1       |
| 4.00  | 1       |
| 3.85  | 2       |
| 3.65  | 3       |
| 3.65  | 3       |
| 3.50  | 4       |
+-------+---------+
*/

select score,
dense_rank() over (order by score desc) as ranking
from score

/* Consecutive Numbers
Write an SQL query to find all numbers that appear at least three times consecutively. Return the
result table in any order.

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| num         | varchar |
+-------------+---------+
 
The query result format is in the following example:

Logs table:
+----+-----+
| Id | Num |
+----+-----+
| 1  | 1   |
| 2  | 1   |
| 3  | 1   |
| 4  | 2   |
| 5  | 1   |
| 6  | 2   |
| 7  | 2   |
+----+-----+

Result table:
+-----------------+
| ConsecutiveNums |
+-----------------+
| 1               |
+-----------------+

1 is the only number that appears consecutively for at least three times.
*/

select distinct 11.Num as ConsecutiveNums from
Logs as 11, Logs as 12, Logs as 13
where 11.Num = 12.Num
and 12.Num = 13.Num
and 11.Id = 12.Id - 1
and 12.Id = 13.Id - 1
