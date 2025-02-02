/* Managers with at Least 5 Direct Reports
https://leetcode.com/problems/managers-with-at-least-5-direct-reports/description/ */

with manager as(
    select managerId
    from employee
    group by managerId
    having count(managerId) >= 5
)
select name
from employee
inner join manager on employee.id = manager.managerId

/* Confirmation Rate
https://leetcode.com/problems/confirmation-rate/description/ */

select
    s.user_id,
    coalesce(round(sum(case when c.action = 'confirmed' then 1 else 0 end) / count(c.action), 2), 0) as confirmation_rate
from
    signups s
    left join confirmations c on s.user_id = c.user_id
group by user_id

/* Monthly Transactions I
https://leetcode.com/problems/monthly-transactions-i/description/ */

select
    date_format(trans_date, '%Y-%m') as month, 
    country,
    count(id) as trans_count,
    sum(case when state = 'approved' then 1 else 0 end) as approved_count,
    sum(amount) as trans_total_amount,
    sum(case when state = 'approved' then amount else 0 end) as approved_total_amount
from
    transactions
group by
    date_format(trans_date, '%Y-%m'),
    country

/* Immediate Food Delivery II
https://leetcode.com/problems/immediate-food-delivery-ii/description/ */

with first_order as (
    select
        customer_id, min(order_date) as first_order_date, min(customer_pref_delivery_date) as delivery_date
    from delivery
    group by customer_id
)
select
    round(sum(case when first_order_date = delivery_date then 1 else 0 end) / count(customer_id) * 100, 2) as immediate_percentage
from first_order

/* Game Play Analysis IV
https://leetcode.com/problems/game-play-analysis-iv/description/ */

with first_login as
    (select player_id, min(event_date) as first_date
    from activity
    group by player_id)
select round(count(f.player_id) / (select count(distinct player_id) from activity), 2) as fraction
from first_login f
inner join activity a on a.player_id = f.player_id
and datediff(f.first_date, a.event_date) = -1

/* Product Sales Analysis III
https://leetcode.com/problems/product-sales-analysis-iii/description/ */

with first_year as (
    select product_id, min(year) as first_year
    from sales
    group by product_id
    )
select s.product_id, fy.first_year, quantity, price
from sales s
inner join first_year fy on s.product_id = fy.product_id
and s.year = fy.first_year

/* Customers Who Bought All Products
https://leetcode.com/problems/customers-who-bought-all-products/description/ */

select customer_id
from customer
group by customer_id
having count(distinct product_key) = (
    select count(product_key) from product)

/* Product Price at a Given Date
https://leetcode.com/problems/product-price-at-a-given-date/description/ */

select
    product_id,
    COALESCE((
        select new_price
        from Products p2
        where p1.product_id = p2.product_id
            and p2.change_date <= '2019-08-16'
        order by p2.change_date desc
        limit 1
    ), 10) as price
from (
    select distinct product_id
    from Products) p1;

/* Last Person to Fit in the Bus
https://leetcode.com/problems/last-person-to-fit-in-the-bus/description/ */

with cumu_weight as (
select person_name, weight,		
sum(weight) over(
	order by turn	
	rows between UNBOUNDED PRECEDING	
	and current row) as runval	
from queue
)
select person_name
from cumu_weight
where runval = (select max(runval) from cumu_weight where runval <= 1000)

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
https://leetcode.com/problems/consecutive-numbers/description/ */

select distinct l1.num as ConsecutiveNums
from logs l1
inner join logs l2 on l1.num = l2.num and l1.id = l2.id + 1 
inner join logs l3 on l1.num = l3.num and l1.id = l3.id + 2
