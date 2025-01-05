/* Revising the Select Query I

Query all columns for all American cities in the CITY table with populations larger than 100000.
The CountryCode for America is USA. */

select *
from CITY
where
  countrycode = 'USA' and
  population > 100000

/* Revising the Select Query II

Query the NAME field for all American cities in the CITY table with populations larger than 120000.
The CountryCode for America is USA. */

select name
from city
where
  countrycode = 'USA' and
  population > 120000

/* Select All
Query all columns (attributes) for every row in the CITY table. */

select *
from city

/* Select By ID
Query all columns for a city in CITY with the ID 1661. */

select *
from city
where id = 1661

/* Weather Observation Station 1
Query a list of CITY and STATE from the STATION table. */

select city, state
from station

/* Weather Observation Station 3
Query a list of CITY names from STATION for cities that have an even ID number.
Print the results in any order, but exclude duplicates from the answer.
*/

select distinct city
from station
where id % 2 = 0

/* Weather Observation Station 4
Find the difference between the total number of CITY entries in the table and
the number of distinct CITY entries in the table. */

select count(city) - count(distinct city)
from station

/* Weather Observation Station 5
Query the two cities in STATION with the shortest and longest CITY names, as well as their
respective lengths (i.e.: number of characters in the name). If there is more than one
smallest or largest city, choose the one that comes first when ordered alphabetically.*/

select top 1 city, len(city)
from station
order by len(city), city;
select top 1 city, len(city)
from station
order by len(city) desc;

/* Weather Observation Station 6
Query the list of CITY names starting with vowels (i.e., a, e, i, o, or u) from STATION.
Your result cannot contain duplicates. */

select distinct city
from station
where LEFT(city, 1) in ('A', 'E', 'I', 'O', 'U')

/* Weather Observation Station 7
Query the list of CITY names ending with vowels (a, e, i, o, u) from STATION.
Your result cannot contain duplicates. */

select distinct city
from station
where RIGHT(city, 1) in ('a', 'e', 'i', 'o', 'u')

/* Weather Observation Station 8
Query the list of CITY names from STATION which have vowels (i.e., a, e, i, o, and u) as
both their first and last characters. Your result cannot contain duplicates. */

select distinct city
from station
where LEFT(city, 1) in ('A', 'E', 'I', 'O', 'U') and
RIGHT(city, 1) in ('a', 'e', 'i', 'o', 'u')

/* Weather Observation Station 9
Query the list of CITY names from STATION that do not start with vowels.
Your result cannot contain duplicates. */

select distinct city
from station
where LEFT(city, 1) not in ('A', 'E', 'I', 'O', 'U')

/* Weather Observation Station 10
Query the list of CITY names from STATION that do not end with vowels.
Your result cannot contain duplicates. */

select distinct city
from station
where RIGHT(city, 1) not in ('a', 'e', 'i', 'o', 'u')

/* Weather Observation Station 11
Query the list of CITY names from STATION that either do not start with vowels
or do not end with vowels. Your result cannot contain duplicates. */

select distinct city
from station
where LEFT(city, 1) not in ('A', 'E', 'I', 'O', 'U') or
RIGHT(city, 1) not in ('a', 'e', 'i', 'o', 'u')

/* Higher Than 75 Marks
Query the Name of any student in STUDENTS who scored higher than 75 Marks.
Order your output by the last three characters of each name. If two or more students both
have names ending in the same last three characters, secondary sort them by ascending ID.
*/

select name
from students
where marks > 75
order by RIGHT(name, 3), id asc

/* Employee Names
Write a query that prints a list of employee names (i.e.: the name attribute) from
the Employee table in alphabetical order.*/

select name
from employee
order by name

/* Employee Salaries
Write a query that prints a list of employee names (i.e.: the name attribute) for employees in
Employee having a salary greater than $2000 per month who have been employees for less than 10
months. Sort your result by ascending employee_id.
*/

select name
from employee
where
  salary > 2000 and
  months < 10
order by employee_id
