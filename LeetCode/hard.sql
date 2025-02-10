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

