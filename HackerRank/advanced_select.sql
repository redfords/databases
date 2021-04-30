/*  Type of Triangle
Write a query identifying the type of each record in the TRIANGLES table using its three side lengths.
Output one of the following statements for each record in the table:
Equilateral: It's a triangle with 3 sides of equal length.
Isosceles: It's a triangle with 2 sides of equal length.
Scalene: It's a triangle with 3 sides of differing lengths.
Not A Triangle: The given values of A, B, and C don't form a triangle. */

select
if(a + b > c and a + c > b and b + c > a,
   if(a = b and b = c, 'Equilateral',
     if(a = b or b = c or a = c, 'Isosceles',
       'Scalene')),
  'Not A Triangle')
from triangles


/* The PADS
Generate the following two result sets:
1. Query an alphabetically ordered list of all names in OCCUPATIONS, immediately followed by the first
letter of each profession as a parenthetical (i.e.: enclosed in parentheses).
2. Query the number of ocurrences of each occupation in OCCUPATIONS. Sort the occurrences in ascending
order, and output them in the following format:
There are a total of [occupation_count] [occupation]s.
where [occupation_count] is the number of occurrences of an occupation in OCCUPATIONS and [occupation]
is the lowercase occupation name. If more than one Occupation has the same [occupation_count], they
should be ordered alphabetically.*/

select concat(name, '(', left(occupation, 1), ')')
from occupations
order by name;
select concat('There are a total of ', count(occupation), ' ', lower(occupation), 's.')
from occupations
group by occupation
order by count(occupation), occupation