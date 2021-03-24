/* Top Earners
We define an employee's total earnings to be their monthly salary x months worked, and the
maximum total earnings to be the maximum total earnings for any employee in the Employee table.
Write a query to find the maximum total earnings for all employees as well as the total number
of employees who have maximum total earnings. Print these values as 2 space-separated integers. */

select salary * months as earnings, count(*)
from employee
group by earnings
order by earnings desc
limit 1

/* Weather Observation Station 2
Query the following two values from the STATION table:
The sum of all values in LAT_N rounded to a scale of 2 decimal places.
The sum of all values in LONG_W rounded to a scale of 2 decimal places. */

select round(sum(lat_n), 2) lat, round(sum(long_w), 2) lon
from station

/* Weather Observation Station 13
Query the sum of Northern Latitudes (LAT_N) from STATION having values greater than 38.7880 and
less than 137.2345. Truncate your answer to 4 decimal places. */

select round(sum(lat_n), 4)
from station
where lat_n < 137.2345 and
lat_n > 38.7880

/* Weather Observation Station 14
Query the greatest value of the Northern Latitudes (LAT_N) from STATION that is less than 137.2345.
Truncate your answer to 4 decimal places. */

select round(max(lat_n), 4)
from station
where lat_n < 137.2345

/* Weather Observation Station 15
Query the Western Longitude (LONG_W) for the largest Northern Latitude (LAT_N) in STATION that is
less than 137.2345. Round your answer to 4 decimal places. */

select round(long_w, 4)
from station
where lat_n < 137.2345
order by lat_n desc
limit 1

/* Weather Observation Station 16
Query the smallest Northern Latitude (LAT_N) from STATION that is greater than 38.7780.
Round your answer to 4 decimal places. */

select round(min(lat_n), 4)
from station
where lat_n > 38.7780

/* Weather Observation Station 17
Query the Western Longitude (LONG_W)where the smallest Northern Latitude (LAT_N) in STATION is
greater than 38.7780. Round your answer to 4 decimal places. */

select round(long_w, 4)
from station
where lat_n > 38.7780
order by lat_n asc
limit 1

/* Weather Observation Station 18
Consider P1(a,b) and P2(b,c) to be two points on a 2D plane.
a happens to equal the minimum value in Northern Latitude (LAT_N in STATION).
b happens to equal the minimum value in Western Longitude (LONG_W in STATION).
c happens to equal the maximum value in Northern Latitude (LAT_N in STATION).
d happens to equal the maximum value in Western Longitude (LONG_W in STATION).
Query the Manhattan Distance between points P1 and P2 and round it to a scale of 4 decimal places. */

select round(abs(min(lat_n) - max(lat_n)) + abs(min(long_w) - max(long_w)), 4)
from station

/* Weather Observation Station 19
Consider P1(a,c) and P2(b,d) to be two points on a 2D plane where (a,b) are the respective minimum
and maximum values of Northern Latitude (LAT_N) and (c,d) are the respective minimum and maximum
values of Western Longitude (LONG_W) in STATION. Query the Euclidean Distance between points P1 and
P2 and format your answer to display 4 decimal digits. */

select round(sqrt(power(max(lat_n) - min(lat_n), 2) + power(max(long_w) - min(long_w), 2)), 4)
from station

/* Weather Observation Station 20
A median is defined as a number separating the higher half of a data set from the lower half. Query
the median of the Northern Latitudes (LAT_N) from STATION, round your answer to 4 decimal places. */

set @rowIndex := -1;
select round(avg(t.lat_n), 4) from (
    select @rowIndex := @rowIndex+1 as rowIndex, s.lat_n from station as s
    order by s.LAT_N
    ) as t
    where t.rowIndex in (floor(@rowIndex / 2), ceil(@rowIndex / 2));
    