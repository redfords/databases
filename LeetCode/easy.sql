/* Swap Salary
Write an SQL query to swap all 'f' and 'm' values with a single update statement and no
intermediate temp table(s). Note that you must write a single update statement, DO NOT write
any select statement for this problem.*/

update salary set sex = case
when sex = "f" then "m"
when sex = "m" then "f"
end;

/* Not Boring Movies
X city opened a new cinema. The cinema gives out a poster with the movies’ ratings and descriptions.
Write a SQL query to output movies with an odd numbered ID and a description that is not 'boring'.
Order the result by rating. */

select *
from cinema
where id % 2 <> 0 and
description <> "boring"
order by rating desc

/* Duplicate Emails
Write a SQL query to find all duplicate emails in a table named Person. */

select email
from person
group by email
having count(*) > 1

/* Combine two tables
Write a SQL query that provides the following information for each person in the Person table,
regardless if there is an address for each of those people: FirstName, LastName, City, State */

select firstname, lastname, city, state
from person
left join address on person.personid = address.personid

/*
Employees Earning More Than Their Managers
The Employee table holds all employees including their managers.
Every employee has an Id, and there is also a column for the manager Id. Given the Employee table,
write a SQL query that finds out employees who earn more than their managers.*/

select A.name as Employee
from Employee A, Employee B
where A.managerid = B.id and
A.salary > B.salary

/* Customers Who Never Order
Suppose that a website contains two tables, the Customers table and the Orders table.
Write a SQL query to find all customers who never order anything. */

select name as Customers
from customers
where id not in (
    select customerid
    from orders)

/* Delete Duplicate Emails
Write a SQL query to delete all duplicate email entries in a table named Person, keeping
only unique emails based on its smallest Id. */

delete a
from person a
left join (
    select min(id) id, email
    from person
    group by email)
    b on a.id = b.id and
    a.email = b.email
where b.id is null

/* Rising Temperature
https://leetcode.com/problems/rising-temperature/description/ */

select a.id
from weather a, weather b
where datediff(a.recorddate, b.recorddate) = 1 and
a.temperature > b.temperature

/* Average Time of Process per Machine
https://leetcode.com/problems/average-time-of-process-per-machine/description/ */

select
    a1.machine_id,
    round(avg(a2.timestamp - a1.timestamp), 3) as processing_time
from
    activity a1
    inner join activity a2 on a1.machine_id = a2.machine_id
    and a1.process_id = a2.process_id
where
    a1.activity_type = 'start'
    and a2.activity_type = 'end'
group by
    a1.machine_id

/* Students and Examinations
https://leetcode.com/problems/students-and-examinations/description/ */

with total_exams as (
    select student_id, subject_name, count(student_id) as total
    from examinations
    group by student_id, subject_name
)
select
    s.student_id, s.student_name, su.subject_name, coalesce(t.total, 0) as attended_exams
from
    students s
    join subjects su
    left join total_exams t on t.student_id = s.student_id
    and su.subject_name = t.subject_name
order by
    s.student_id, su.subject_name
    
/* Classes More Than 5 Students
There is a table courses with columns: student and class. List all classes which have more than
or equal to 5 students. */

select class
from courses
group by class
having count(distinct student) > 4

/* Second Highest Salary
Write a SQL query to get the second highest salary from the Employee table. */

select max(salary) as SecondHighestSalary
from employee
where salary < (
    select max(salary)
    from employee)

/* Average Selling Price
https://leetcode.com/problems/average-selling-price/description/ */

select
    p.product_id,
    coalesce(round(sum(us.units * p.price) / sum(us.units), 2), 0) as average_price
from
    prices p
    left join unitssold us on p.product_id = us.product_id
    and us.purchase_date between p.start_date and p.end_date
group by
    p.product_id

/* Percentage of Users Attended a Contest
https://leetcode.com/problems/percentage-of-users-attended-a-contest/description/ */

with total as (
    select
        contest_id,
        round(count(user_id) / (select count(user_id) from users) * 100, 2) as percentage
    from register
    group by contest_id
)
select contest_id, percentage
from total
order by percentage desc, contest_id

/* Queries Quality and Percentage
https://leetcode.com/problems/queries-quality-and-percentage/description/ */

select
    query_name, 
    round(sum(rating / position) / count(query_name), 2) as quality,
    round(sum(case when rating < 3 then 1 else 0 end) / count(query_name) * 100, 2) as poor_query_percentage
from queries
group by query_name

/* User Activity for the Past 30 Days I
https://leetcode.com/problems/user-activity-for-the-past-30-days-i/description/ */

select
    activity_date as day, count(distinct user_id) as active_users
from activity
where
    activity_date between '2019-07-27' - interval 29 day and '2019-07-27'
group by activity_date

/* The Number of Employees Which Report to Each Employee
https://leetcode.com/problems/the-number-of-employees-which-report-to-each-employee/description/ */

select
    e2.reports_to as employee_id,
    e1.name,
    count(e2.reports_to) as reports_count,
    round(avg(e2.age), 0) as average_age
from
    employees e1
    inner join employees e2 on e1.employee_id = e2.reports_to
group by e2.reports_to
order by e2.reports_to

/* Primary Department for Each Employee
https://leetcode.com/problems/primary-department-for-each-employee/description/ */

select employee_id, department_id
from employee
group by employee_id
having count(department_id) = 1
union
select employee_id, department_id
from employee
where primary_flag = 'Y'

/* Triangle Judgement
https://leetcode.com/problems/triangle-judgement/description/ */

select
    x, y, z,
    case
        when x + y > z AND x + z > y AND y + z > x THEN 'Yes'
        else 'No'
    end as 'triangle'
from triangle

/* Fix Names in a Table
https://leetcode.com/problems/fix-names-in-a-table/description/ */

select
    user_id,
    concat(upper(substr(name, 1, 1)), lower(substr(name, 2))) as name
from users
order by user_id
