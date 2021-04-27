/* The Report
Ketty gives Eve a task to generate a report containing three columns: Name, Grade and Mark. Ketty
doesn't want the NAMES of those students who received a grade lower than 8. The report must be in
descending order by grade -- i.e. higher grades are entered first. If there is more than one student
with the same grade (8-10) assigned to them, order those particular students by their name
alphabetically. Finally, if the grade is lower than 8, use "NULL" as their name and list them by their
grades in descending order. If there is more than one student with the same grade (1-7) assigned to
them, order those particular students by their marks in ascending order. */

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
Julia just finished conducting a coding contest, and she needs your help assembling the leaderboard!
Write a query to print the respective hacker_id and name of hackers who achieved full scores for more
than one challenge. Order your output in descending order by the total number of challenges in which
the hacker earned a full score. If more than one hacker received full scores in same number of
challenges, then sort them by ascending hacker_id. */

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
Harry Potter and his friends are at Ollivander's with Ron, finally replacing Charlie's old broken wand.
Hermione decides the best way to choose is by determining the minimum number of gold galleons needed to
buy each non-evil wand of high power and age. Write a query to print the id, age, coins_needed, and
power of the wands that Ron's interested in, sorted in order of descending power. If more than one wand
has same power, sort the result in order of descending age.*/

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
Julia asked her students to create some coding challenges. Write a query to print the hacker_id, name,
and the total number of challenges created by each student. Sort your results by the total number of
challenges in descending order. If more than one student created the same number of challenges, then
sort the result by hacker_id. If more than one student created the same number of challenges and the
count is less than the maximum number of challenges created, then exclude those students. */

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
You did such a great job helping Julia with her last coding contest challenge that she wants you to work
on this one, too! The total score of a hacker is the sum of their maximum scores for all of the
challenges. Write a query to print the hacker_id, name, and total score of the hackers ordered by the
descending score. If more than one hacker achieved the same total score, then sort the result by
ascending hacker_id. Exclude all hackers with a total score of  from your result. */

select m.hacker_id, h.name, sum(m.score) as total_score
from (select hacker_id, challenge_id, max(score) as score
    from Submissions
    group by hacker_id, challenge_id) as m
join Hackers h
on h.hacker_id = m.hacker_id
group by m.hacker_id, h.name
having total_score > 0
order by total_score desc, h.hacker_id