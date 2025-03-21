# Most Lucrative Products
# https://platform.stratascratch.com/coding/2119-most-lucrative-products?code_type=1

select
  product_id, sum(units_sold * cost_in_dollars) as revenue
from
  online_orders
where
  date between '2022-01-01' and '2022-06-30'
group by
  product_id
order by
  sum(units_sold * cost_in_dollars) desc
limit 5

# Customer Details
# https://platform.stratascratch.com/coding/9891-customer-details?code_type=1

select
  first_name, last_name, city, order_details
from
  customers c
  left join orders o on c.id = o.cust_id

# Unique Users Per Client Per Month
# https://platform.stratascratch.com/coding/2024-unique-users-per-client-per-month?code_type=1

select
  client_id, extract(month from time_id) as month,
  count(distinct user_id)
from
  fact_events
group by
  client_id,
  extract(month from time_id)

# Order Details
# https://platform.stratascratch.com/coding/9913-order-details?code_type=1

select
  order_date, order_details, total_order_cost, first_name
from
  customers c
  inner join orders o on o.cust_id = c.id
where
  first_name in ('Jill', 'Eva')
order by c.id

# Average Salaries
# https://platform.stratascratch.com/coding/9917-average-salaries?code_type=1

with dept as (
    select department, avg(salary) as avg_salary
    from employee
    group by department
)
select
  e.department, e.first_name, e.salary, d.avg_salary
from
  employee e
  inner join dept d on e.department = d.department

# Salaries Differences
# https://platform.stratascratch.com/coding/10308-salaries-differences?code_type=1
  
select abs(
  max(case when department = 'engineering' then salary else 0 end) -
  max(case when department = 'marketing' then salary else 0 end)
)
from db_employee e
inner join db_dept d on e.department_id = d.id
where department in ('engineering', 'marketing')

# Number of violations
# https://platform.stratascratch.com/coding/9728-inspections-that-resulted-in-violations?code_type=1

select
  date_part('year', inspection_date) as year,
  count(violation_id) as total_violations
from
  sf_restaurant_health_violations
where
  violation_id is not NULL
  and business_name = 'Roxanne Cafe'
group by
  date_part('year', inspection_date)

# Popularity of Hack
# https://platform.stratascratch.com/coding/10061-popularity-of-hack?code_type=1

select
  location, avg(popularity) as avg_popularity
from
  facebook_employees
  inner join facebook_hack_survey on id = employee_id
group by location
