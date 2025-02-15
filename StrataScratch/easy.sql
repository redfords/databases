# Most Lucrative Products
# https://platform.stratascratch.com/coding/2119-most-lucrative-products?code_type=1

select product_id, sum(units_sold * cost_in_dollars) as revenue
from online_orders
where date between '2022-01-01' and '2022-06-30'
group by product_id
order by sum(units_sold * cost_in_dollars) desc
limit 5

# April Admin Employees
# https://platform.stratascratch.com/coding/9845-find-the-number-of-employees-working-in-the-admin-department?code_type=1

