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

/*
Weather Department Statistics
There is a database that contains temperature and humidity statistics by state for various countries.
Return a list of states with their associated country names, For each record, return the state's
average humidity and average temperature during the month of November 2018. The average temperature
should be displayed as follows:
COLD if 0 <= average monthly temperature < 15.
WARM if 15 <= average monthly temperature < 30.
HOT if 30 <= average monthly temperature.

The result should be in the following format: state.name | country.name | average_monthly_humidity |
weather_type ordered descending by average humidity, and ascending by state nameif there is a tie.
*/

select
    state.name,
    country.name,
    avg(humidity) AS average_monthly_humidity, 
    case
    when avg(temperature) >= 0 and avg(temperature) < 15 then "COLD"
    when avg(temperature) >= 15 and avg(temperature) < 30 then "WARM"
    when avg(temperature) >= 30 then "HOT"
    end as weather_type
from country
inner join state
on state.country_id = country.id
inner join state_weather_stats
on state.id = state_weather_stats.state_id
where year(record_date) = 2018 and month(record_date) = 11
group by state.name, country.name
order by average_monthly_humidity desc, state.name asc