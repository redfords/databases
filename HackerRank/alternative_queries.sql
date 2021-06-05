/*
Draw The Triangle 1
P(R) represents a pattern drawn by Julia in R rows. The following pattern represents P(5):
* * * * * 
* * * * 
* * * 
* * 
*
Write a query to print the pattern P(20).
*/

set @number = 21;
select repeat('* ', @number := @number - 1)
from information_schema.tables
limit 20

/*
Draw The Triangle 2
P(R) represents a pattern drawn by Julia in R rows. The following pattern represents P(5):
* 
* * 
* * * 
* * * * 
* * * * *
Write a query to print the pattern P(20).
*/

set @number = 0;
select repeat('* ', @number := @number + 1)
from information_schema.tables
limit 20