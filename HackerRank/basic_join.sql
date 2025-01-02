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
*/

select name, grade, marks
from students a
inner join
grades b on a.marks between b.min_mark and b.max_mark
where grade > 7
union
select name = NULL, grade, marks
from students a
inner join
grades b on a.marks between b.min_mark and b.max_mark
where grade < 8
order by grade desc, name, marks

select if(g.Grade<8, NULL, s.Name), g.Grade, s.Marks
from Students s
join Grades g on s.Marks between g.Min_Mark and g.Max_Mark
order by g.Grade desc, s.Name, s.Marks

/* Top Competitors
. */

select h.hacker_id, h.name
from submissions s
join hackers h on s.hacker_id = h.hacker_id
join challenges c on s.challenge_id = c.challenge_id
join difficulty d on c.difficulty_level = d.difficulty_level
where s.score = d.score
group by h.hacker_id, h.name
having count(*) > 1
order by count(*)desc, h.hacker_id

/* Ollivander's Inventory
*/

select id, age, m.coins_needed, m.power
from
    (select code, power, MIN(coins_needed) AS coins_needed
    from Wands
    group by code, power) as m
join Wands as w
on m.code = w.code and m.power = w.power and m.coins_needed = w.coins_needed
join Wands_Property as wp
on m.code = wp.code
where wp.is_evil = 0
order by m.power desc, age desc

/* Challenges
*/

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
*/

select m.hacker_id, h.name, sum(m.score) as total_score
from (select hacker_id, challenge_id, max(score) as score
    from Submissions
    group by hacker_id, challenge_id) as m
join Hackers h
on h.hacker_id = m.hacker_id
group by m.hacker_id, h.name
having total_score > 0
order by total_score desc, h.hacker_id

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
