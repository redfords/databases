/*
Exercise 1-1
Write a query that generates five copies of each employee row:
Tables involved: HR.Employees and dbo.Nums
*/

/*
Exercise 1-2 (optional, advanced)
Write a query that returns a row for each employee and day in the range June 12, 2016
through June 16, 2016:
Tables involved: HR.Employees and dbo.Nums
*/

/*
Exercise 2
Explain what’s wrong in the following query, and provide a correct alternative:

  SELECT Customers.custid, Customers.companyname, Orders.orderid, Orders.orderdate
  FROM Sales.Customers AS C
    INNER JOIN Sales.Orders AS O
      ON Customers.custid = Orders.custid;
*/

/*
Exercise 3
Return US customers, and for each customer return the total number of orders and total
quantities:
Tables involved: Sales.Customers, Sales.Orders, and Sales.OrderDetails
*/

/*
Exercise 4
Return customers and their orders, including customers who placed no orders:
Tables involved: Sales.Customers and Sales.Orders
*/

/*
Exercise 5
Return customers who placed no orders:
Tables involved: Sales.Customers and Sales.Orders
*/

/*
Exercise 6
Return customers with orders placed on February 12, 2016, along with their orders:
Tables involved: Sales.Customers and Sales.Orders
*/

/*
Exercise 7 (optional, advanced)
Write a query that returns all customers in the output, but matches them with their respective
orders only if they were placed on February 12, 2016:
Tables involved: Sales.Customers and Sales.Orders
*/

/*
Exercise 8 (optional, advanced)
Explain why the following query isn’t a correct solution query for Exercise 7:

  SELECT C.custid, C.companyname, O.orderid, O.orderdate
  FROM Sales.Customers AS C
    LEFT OUTER JOIN Sales.Orders AS O
      ON O.custid = C.custid
  WHERE O.orderdate = '20160212'
    OR O.orderid IS NULL;
*/

/*
Exercise 9 (optional, advanced)
Return all customers, and for each return a Yes/No value depending on whether the customer
placed orders on February 12, 2016:
Tables involved: Sales.Customers and Sales.Orders
*/
