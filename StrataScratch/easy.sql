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
