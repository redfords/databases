/* Big Countries
A country is big if it has an area of bigger than 3 million square km or a population of more
than 25 million. Write a SQL solution to output big countries' name, population and area. */

select name, population, area
from world
where area > 3000000 or
population > 25000000

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
Write an SQL query to find all dates' id with higher temperature compared to its previous dates
(yesterday). Return the result table in any order. */

select a.id
from weather a, weather b
where datediff(a.recorddate, b.recorddate) = 1 and
a.temperature > b.temperature

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
