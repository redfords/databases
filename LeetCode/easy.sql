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

# 586. Customer Placing the Largest Number of Orders
# https://leetcode.com/problems/customer-placing-the-largest-number-of-orders/description/

select customer_number
from orders 
group by customer_number
order by count(order_number) desc
limit 1

# 607. Sales Person
# https://leetcode.com/problems/sales-person/description/

select name
from salesperson
where sales_id not in (
    select sales_id
    from orders o
    inner join company c on o.com_id = c.com_id
    where c.name = 'RED'
)
    
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

delete p1
from person p1, person p2
where p1.email = p2.email
and p1.id > p2.id

# 1407. Top Travellers
# https://leetcode.com/problems/top-travellers/description/

select name, coalesce(sum(distance), 0) as travelled_distance
from
    users u
    left join rides r on u.id = r.user_id
group by u.id
order by sum(distance) desc, name

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

# 1965. Employees With Missing Information
# https://leetcode.com/problems/employees-with-missing-information/description/

with id as (
    select employee_id
    from employees
    union all
    select employee_id
    from salaries
)
select employee_id
from id
group by employee_id
having count(employee_id) = 1
order by employee_id

# 1084. Sales Analysis III
# https://leetcode.com/problems/sales-analysis-iii/description/

select
    p.product_id, p.product_name
from
    product p
    inner join sales s on p.product_id = s.product_id
group by
    p.product_id, p.product_name
having
    min(s.sale_date) >= '2019-01-01'
    and max(s.sale_date) <= '2019-03-31'
    
select
    distinct p.product_id, p.product_name
from
    product p
    inner join sales s on p.product_id = s.product_id
where
    s.sale_date between '2019-01-01' and '2019-03-31'
    and p.product_id not in (
        select product_id
        from sales
        where sale_date < '2019-01-01' or sale_date > '2019-03-31'
    )
    
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

/* Delete Duplicate Emails
https://leetcode.com/problems/delete-duplicate-emails/description/ */

delete p1
from person p1, person p2
where p1.email = p2.email
and p1.id > p2.id

# 1179. Reformat Department Table
# https://leetcode.com/problems/reformat-department-table/description/
    
select 
    id,
    sum(case when month = 'Jan' then revenue end) as Jan_revenue,
    sum(case when month = 'Feb' then revenue end) as Feb_revenue,
    sum(case when month = 'Mar' then revenue end) as Mar_revenue,
    sum(case when month = 'Apr' then revenue end) as Apr_revenue,
    sum(case when month = 'May' then revenue end) as May_revenue,
    sum(case when month = 'Jun' then revenue end) as Jun_revenue,
    sum(case when month = 'Jul' then revenue end) as Jul_revenue,
    sum(case when month = 'Aug' then revenue end) as Aug_revenue,
    sum(case when month = 'Sep' then revenue end) as Sep_revenue,
    sum(case when month = 'Oct' then revenue end) as Oct_revenue,
    sum(case when month = 'Nov' then revenue end) as Nov_revenue,
    sum(case when month = 'Dec' then revenue end) as Dec_revenue
    from department
    group by id
    
/* 1484. Group Sold Products By The Date
https://leetcode.com/problems/group-sold-products-by-the-date/description/ */

select
    sell_date, COUNT(DISTINCT product) as num_sold, 
    group_concat(DISTINCT product) as products 
from Activities
group by sell_date
order by sell_date

/* 1327. List the Products Ordered in a Period
https://leetcode.com/problems/list-the-products-ordered-in-a-period/description/ */
select
    product_name,
    sum(unit) as unit
from
    orders o
    inner join products p on o.product_id = p.product_id
where
    date_format(order_date, '%Y-%m') = '2020-02'
group by product_name
having sum(unit) >= 100

/* 1517. Find Users With Valid E-Mails
https://leetcode.com/problems/find-users-with-valid-e-mails/description/ */

select user_id, name, mail
from users
where mail rlike '^[A-Za-z]+[A-Za-z0-9\.\_\-]*@leetcode[\.]com$'

# ^ means the beginning of the string
# [] means character set. [A-Z] means any upper case chars
# - means range
# notation: + or *
#    + means at least one of the character from the preceding charset, and * means 0 or more
# \ inside the charset mean skipping. \. means we want the dot as 
#    for example: if we would like to find - itself as a character? use \-. 
# @ refers to exact match
