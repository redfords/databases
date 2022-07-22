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

/*
Order Details

Find order details made by Jill and Eva.
Consider the Jill and Eva as first names of customers.
Output the order date, details and cost along with the first name.
Order records based on the customer id in ascending order.

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
order_date,
order_details,
total_order_cost
from customers
inner join orders
on customers.id = orders.cust_id
where first_name = 'Eva' or
first_name = 'Jill'
order by cust_id;

/*
Top Cool Votes

Find the review_text that received the highest number of  'cool' votes.
Output the business name along with the review text with the highest numbef of 'cool' votes.

yelp_reviews
business_name: varchar
review_id: varchar
user_id: varchar
stars: varchar
review_date: datetime
review_text: varchar
funny: int
useful: int
cool: int
*/

select
business_name,
review_text
from yelp_reviews
where cool = (
  select max(cool)
  from yelp_reviews
  );

/*
Lyft Driver Wages

Find all Lyft drivers who earn either equal to or less than 30k USD or equal to or more than 70k USD.
Output all details related to retrieved records.

lyft_drivers
index: int
start_date: datetime
end_date: datetime
yearly_salary: int
*/

select
index,
start_date,
end_date,
yearly_salary
from lyft_drivers
where yearly_salary <= 30000 or
yearly_salary >= 70000;

/*
Average Salaries

Compare each employee's salary with the average salary of the corresponding department.
Output the department, first name, and salary of employees along with the average salary of that department.

employee
id: int
first_name: varchar
last_name: varchar
age: int
sex: varchar
employee_title: varchar
department: varchar
salary: int
target: int
bonus: int
email: varchar
city: varchar
address: varchar
manager_id: int
*/

with avgs as (
  select department,
  avg(salary) as avg_salary
  from employee
  group by department
  )
select
employee.department,
first_name,
salary,
avg_salary
from employee
inner join avgs
on employee.department = avgs.department;
