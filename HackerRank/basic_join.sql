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

SELECT IF(g.Grade<8, NULL, s.Name), g.Grade, s.Marks
FROM Students AS s
JOIN Grades AS g ON s.Marks BETWEEN g.Min_Mark AND g.Max_Mark
ORDER BY g.Grade DESC, s.Name, s.Marks

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

