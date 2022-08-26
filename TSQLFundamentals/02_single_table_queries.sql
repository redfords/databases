/*
Exercise 1
Write a query against the Sales.Orders table that returns orders placed in June 2015:
Tables involved: TSQLV4 database and the Sales.Orders table
*/

select orderid
from orders
where to_char(orderdate, 'YYYY-MM') = '2015-06';

select orderid
from orders
where date_part('year', orderdate) = '2015' and
date_part('month', orderdate) = '06';

select orderid
from orders
where orderdate >= '2015-06-01' and
orderdate < '2015-07-01';

/*
Exercise 2
Write a query against the Sales.Orders table that returns orders placed on the last day of the
month:
Tables involved: TSQLV4 database and the Sales.Orders table
*/



/*
Exercise 3
Write a query against the HR.Employees table that returns employees with a last name
containing the letter e twice or more:
Tables involved: TSQLV4 database and the HR.Employees table
*/



/*
Exercise 4
Write a query against the Sales.OrderDetails table that returns orders with a total value
(quantity * unitprice) greater than 10,000, sorted by total value:
Tables involved: TSQLV4 database and the Sales.OrderDetails table
*/



/*
Exercise 5
To check the validity of the data, write a query against the HR.Employees table that returns
employees with a last name that starts with a lowercase English letter in the range a through z.
Remember that the collation of the sample database is case insensitive
(Latin1_General_CI_AS):
Tables involved: TSQLV4 database and the HR.Employees table
*/



/*
Exercise 6
Explain the difference between the following two queries:
Click here to view code imag e
-- Query 1
SELECT empid, COUNT(*) AS numorders
FROM Sales.OrdersWHERE orderdate < '20160501'
GROUP BY empid;
-- Query 2
SELECT empid, COUNT(*) AS numorders
FROM Sales.Orders
GROUP BY empid
HAVING MAX(orderdate) < '20160501';
Tables involved: TSQLV4 database and the Sales.Orders table
*/



/*
Exercise 7
Write a query against the Sales.Orders table that returns the three shipped-to countries with the
highest average freight in 2015:
Tables involved: TSQLV4 database and the Sales.Orders table
*/



/*
Exercise 8
Write a query against the Sales.Orders table that calculates row numbers for orders based on
order date ordering (using the order ID as the tiebreaker) for each customer separately:
Tables involved: TSQLV4 database and the Sales.Orders table
*/



/*
Exercise 9
Using the HR.Employees table, write a SELECT statement that returns for each employee the
gender based on the title of courtesy. For ‘Ms.’ and ‘Mrs.’ return ‘Female’; for ‘Mr.’ return
‘Male’; and in all other cases (for example, ‘Dr.‘) return ‘Unknown’:
Tables involved: TSQLV4 database and the HR.Employees table
*/



/*
Exercise 10
Write a query against the Sales.Customers table that returns for each customer the customer
ID and region. Sort the rows in the output by region, having NULLs sort last (after non-NULL
values). Note that the default sort behavior for NULLs in T-SQL is to sort first (before non-
NULL values):
Tables involved: TSQLV4 database and the Sales.Customers table
*/
