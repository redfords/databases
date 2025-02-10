# Department Top Three Salaries
# https://leetcode.com/problems/department-top-three-salaries/description/

with highest_salary as (
    select
        salary,
        departmentid,
        row_number() over(partition by departmentid order by salary desc) as row_num
    from
        (select distinct salary, departmentid from employee) e
)
select
    d.name as Department, e.name as Employee, e.salary as Salary
from
    employee e
    inner join department d on d.id = e.departmentid
    inner join highest_salary h on e.salary = h.salary
        and e.departmentid = h.departmentid
        and row_num <= 3;

# 601. Human Traffic of Stadium
# https://leetcode.com/problems/human-traffic-of-stadium/description/

with
  stadium_group as (
    select
      id,
      visit_date,
      people,
      id - row_number() over(order by id) as group_id
    from Stadium
    where people >= 100
  )
select id, visit_date, people
from stadium_group
where group_id in (
    select group_id
    from stadium_group
    group by group_id
    having count(*) >= 3
  )
order by visit_date;

# 262. Trips and Users
# https://leetcode.com/problems/trips-and-users/description/

select request_at, count(id) as total
    from trips
    inner join users u1 on u1.users_id = client_id and u1.banned = 'No'
inner join users u2 on u2.users_id = driver_id and u2.banned = 'No'
where status = 'cancelled_by_driver' or status = 'cancelled_by_client'
and request_at between '2013-10-01' and '2013-10-03'
group by request_at
