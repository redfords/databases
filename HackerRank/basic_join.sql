/* Population Census
https://www.hackerrank.com/challenges/asian-population/problem?isFullScreen=true */

select
    sum(city.population) as sum_population
from
    city
    inner join country on city.countrycode = country.code
where
    country.continent = 'Asia';

/* African Cities
https://www.hackerrank.com/challenges/african-cities/problem?isFullScreen=true */

select
    city.name
from
    city
    inner join country on city.countrycode = country.code
where
    country.continent = 'Africa';

/* Average Population of Each Continent
https://www.hackerrank.com/challenges/average-population-of-each-continent/problem?isFullScreen=true */

select
    country.continent,
    floor(avg(city.population)) as avg_city_population
from
    country
    inner join city on country.code = city.countrycode
group by
    country.continent;

/* The Report
https://www.hackerrank.com/challenges/the-report/problem?isFullScreen=true */

select
    if(grade < 8, NULL, name),
    grade,
    marks
from
    students
    inner join grades on marks between min_mark and max_mark
order by
    grade desc,
    name,
    marks

/* Top Competitors
https://www.hackerrank.com/challenges/full-score/problem?isFullScreen=true */

select
    h.hacker_id,
    h.name
from
    submissions s
    inner join hackers h on h.hacker_id = s.hacker_id
    inner join challenges c on c.challenge_id = s.challenge_id
    inner join difficulty d on d.difficulty_level = c.difficulty_level
where
    s.score = d.score
group by
    h.hacker_id,
    h.name
having
    count(*) > 1
order by
    count(*) desc,
    h.hacker_id;

/* Ollivander's Inventory
https://www.hackerrank.com/challenges/harry-potter-and-wands/problem?isFullScreen=true */

/* MS SQL Server to support window functions*/
with RankedWands as (
    SELECT
        w.id,
        wp.age,
        w.coins_needed,
        w.power,
        ROW_NUMBER() OVER (PARTITION BY w.power, wp.age ORDER BY w.coins_needed ASC) as rn
    FROM Wands w
    JOIN Wands_Property wp ON w.code = wp.code
    WHERE wp.is_evil = 0
)
SELECT id, age, coins_needed, power
FROM RankedWands
WHERE rn = 1
ORDER BY power DESC, age DESC;

select
    id, age, m.coins_needed, m.power
from (
    select
        code,
        power,
        MIN(coins_needed) AS coins_needed
    from
        wands
    group by
        code, power) as m
    join wands as w
    on m.code = w.code and m.power = w.power and m.coins_needed = w.coins_needed
    join wands_property as wp
    on m.code = wp.code
where
    wp.is_evil = 0
order by
    m.power desc,
    age desc

/* Challenges
https://www.hackerrank.com/challenges/challenges/problem?isFullScreen=true */

/* MS SQL Server to support window functions*/
with total_ch as (
    select hacker_id, count(challenge_id) as challenges
    from challenges
    group by hacker_id
    ),
total_ch_by_h as (
    select tc.hacker_id, h.name,
    challenges,
    count(tc.hacker_id) OVER(PARTITION BY challenges) AS total_by_h
    from total_ch tc
    inner join hackers h on h.hacker_id = tc.hacker_id
)
select hacker_id, name, challenges
from total_ch_by_h
where total_by_h = 1
or (total_by_h > 1 and challenges =
      (select top 1 count(challenge_id)
    from challenges
    group by hacker_id
    order by count(challenge_id) desc))
order by challenges desc, hacker_id
;
    
select c.hacker_id, h.name, count(c.challenge_id) as challenges_created
from Hackers h
join Challenges c
on h.hacker_id = c.hacker_id
group by c.hacker_id,  h.name
having challenges_created =
    (select count(c1.challenge_id)
    from Challenges c1
    group by c1.hacker_id
    order by count(*) desc
    limit 1)
or challenges_created not in
    (select count(c2.challenge_id)
    from Challenges c2
    group by c2.hacker_id
    having c2.hacker_id <> c.hacker_id)
order by challenges_created desc, c.hacker_id

/* Contest Leaderboard
https://www.hackerrank.com/challenges/contest-leaderboard/problem?isFullScreen=true */

with max_scores as (
    select hacker_id, max(score) as max_score, challenge_id
    from submissions
    group by hacker_id, challenge_id)
select
    ms.hacker_id, h.name, sum(ms.max_score) as total_score
from
    max_scores ms
    inner join hackers h on ms.hacker_id = h.hacker_id
group by
    ms.hacker_id, h.name
having
    sum(ms.max_score) > 0
order by
    sum(ms.max_score) desc, hacker_id
;

/*
Cities With More Customers Than Average
*/

select country_name, city_name, count(customer.id)
from country
inner join city
on country.id = city.country_id
inner join customer
on customer.city_id = city.id
group by city_name, country_name
having count(customer.id) > (
    select avg(cust)
    from (
        select count(customer.id) as cust
        from city
        inner join customer
        on customer.city_id = city.id
        group by city_id) t_cust)
