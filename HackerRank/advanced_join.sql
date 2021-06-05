/* SQL Project Planning
You are given a table, Projects, containing three columns: Task_ID, Start_Date and End_Date. It is
guaranteed that the difference between the End_Date and the Start_Date is equal to 1 day for each row
in the table.
If the End_Date of the tasks are consecutive, then they are part of the same project. Samantha is
interested in finding the total number of different projects completed.
Write a query to output the start and end dates of projects listed by the number of days it took to
complete the project in ascending order. If there is more than one project that have the same number
of completion days, then order by the start date of the project.*/

/*
Sales Data for All Customers and Products
Write a query that returns sales details of all customers and products. The query should return all
customers, even customers without invoices and also all products, even those products that were not
sold. Print "N/A" for a null customer or product name, and 0 for a null quantity.

For each row return customer name, product name and the quantity of the product sold. Order the
result ascending by customer id, product id and invoice item id.
*/

(select
    coalesce(customer_name, "N/A") as customer_name,
    coalesce(product_name, "N/A") as product_name,
    coalesce(quantity, 0) as quantity
from customer
left join invoice
on customer.id = invoice.customer_id
left join invoice_item
on invoice.id = invoice_item.invoice_id
left join product
on product.id = invoice_item.product_id
order by customer.id, product.id, invoice_item.id)
union
(select
    coalesce(customer_name, "N/A") as customer_name,
    coalesce(product_name, "N/A") as product_name,
    coalesce(quantity, 0) as quantity
from customer
inner join invoice
on customer.id = invoice.customer_id
inner join invoice_item
on invoice.id = invoice_item.invoice_id
right join product
on product.id = invoice_item.product_id
order by customer.id, product.id, invoice_item.id)
