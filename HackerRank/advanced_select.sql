/*  Type of Triangle
https://www.hackerrank.com/challenges/what-type-of-triangle/problem?isFullScreen=true */

select
if(a + b > c and a + c > b and b + c > a,
   if(a = b and b = c, 'Equilateral',
     if(a = b or b = c or a = c, 'Isosceles',
       'Scalene')),
  'Not A Triangle')
from triangles


/* The PADS
https://www.hackerrank.com/challenges/the-pads/problem?isFullScreen=true */

select
    concat(name, '(', substring(occupation, 1, 1), ')') as name_occ
from occupations
order by name;
select
    concat('There are a total of ', count(occupation), ' ', lower(occupation), 's.') as str_occ
from occupations
group by occupation
order by count(occupation);

/* New Companies
https://www.hackerrank.com/challenges/the-company/problem?isFullScreen=true */



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
