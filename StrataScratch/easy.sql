/*
Finding Updated Records

We have a table with employees and their salaries, however, some of the records are old and contain outdated salary information.
Find the current salary of each employee assuming that salaries increase each year. Output their id, first name, last name,
department ID, and current salary. Order your list by employee ID in ascending order.

ms_employee_salary
id: int
first_name: varchar
last_name: varchar
salary: int
department_id: int
*/

with max_salary as (
  select
  id,
  first_name,
  last_name,
  department_id,
  salary,
  rank () over (partition by id order by salary desc) as rank
  from ms_employee_salary
  )
select
id,
first_name,
last_name,
department_id,
salary
from max_salary
where rank = 1
order by id asc;


/*
Find the base pay for Police Captains

Output the employee name along with the corresponding base pay.

sf_public_salaries
id: int
employeename: varchar
jobtitle: varchar
basepay: float
overtimepay: float
otherpay: float
benefits: float
totalpay: float
totalpaybenefits: float
year: int
notes: datetime
agency: varchar
status: varchar
*/

select
employeename,
basepay
from sf_public_salaries
where jobtitle like '%CAPTAIN%POLICE%';


/*
Find the most profitable company in the financial sector of the entire world along with its continent

Find the most profitable company from the financial sector. Output the result along with the continent.

forbes_global_2010_2014
company: varchar
sector: varchar
industry: varchar
continent: varchar
country: varchar
marketvalue: float
sales: float
profits: float
assets: float
rank: int
forbeswebpage: varchar
*/

select
company,
continent
from forbes_global_2010_2014
where profits = (
  select max(profits)
  from forbes_global_2010_2014
  );

/*
Number Of Bathrooms And Bedrooms

Find the average number of bathrooms and bedrooms for each city’s property types. Output the result along with the city name and
the property type.

airbnb_search_details
id: int
price: float
property_type: varchar
room_type: varchar
amenities: varchar
accommodates: int
bathrooms: int
city: varchar
bedrooms: int
*/

select
city,
property_type,
avg(bathrooms) as n_bathrooms_avg,
avg(bedrooms) as n_bedrooms_avg
from airbnb_search_details
group by
property_type,
city;

/*
Customer Details

Find the details of each customer regardless of whether the customer made an order. Output the customer's first name, last name,
and the city along with the order details.
You may have duplicate rows in your results due to a customer ordering several of the same items. Sort records based on the
customer's first name and the order details in ascending order.

customers
id: int
first_name: varchar
last_name: varchar
city: varchar
address: varchar
phone_number: varchar

orders
id: int
cust_id: int
order_date: datetime
order_details: varchar
total_order_cost: int
*/

select
first_name,
last_name,
city,
order_details
from customers
left join orders
on customers.id = orders.cust_id
order by
first_name,
order_details;
