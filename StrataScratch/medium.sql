
/*
Top Cool Votes
Find the review_text that received the highest number of  'cool' votes.
Output the business name along with the review text with the highest numbef of 'cool' votes.
yelp_reviews
business_name: varchar
review_id: varchar
user_id: varchar
stars: varchar
review_date: datetime
review_text: varchar
funny: int
useful: int
cool: int
*/

select
business_name,
review_text
from yelp_reviews
where cool = (
  select max(cool)
  from yelp_reviews
  );

/*
Number of violations

You're given a dataset of health inspections. Count the number of violation in an inspection in 'Roxanne Cafe' for each year. If an
inspection resulted in a violation, there will be a value in the 'violation_id' column. Output the number of violations by year in
ascending order.

sf_restaurant_health_violations
business_id: int
business_name: varchar
business_address: varchar
business_city: varchar
business_state: varchar
business_postal_code: float
business_latitude: float
business_longitude: float
business_location: varchar
business_phone_number: float
inspection_id: varchar
inspection_date: datetime
inspection_score: float
inspection_type: varchar
violation_id: varchar
violation_description: varchar
risk_category: varchar
*/

select
  date_part('year', inspection_date) as year,
  count(inspection_id) as n_inspections
from sf_restaurant_health_violations
where business_name = 'Roxanne Cafe'
group by year;

/*
Find the top 10 ranked songs in 2010

What were the top 10 ranked songs in 2010?
Output the rank, group name, and song name but do not show the same song twice.
Sort the result based on the year_rank in ascending order.

billboard_top_100_year_end
id: int
year: int
year_rank: int
group_name: varchar
artist: varchar
song_name: varchar
*/

select
  year_rank,
  group_name,
  song_name
from billboard_top_100_year_end
where year = 2010
group by
  year_rank,
  group_name,
  song_name
order by year_rank
limit 10;

/*
Find all wineries which produce wines by possessing aromas of plum, cherry, rose, or hazelnut

Find all wineries which produce wines by possessing aromas of plum, cherry, rose, or hazelnut. To make it more simple, look only for
singular form of the mentioned aromas.
Output unique winery values only.

winemag_p1
id: int
country: varchar
description: varchar
designation: varchar
points: int
price: float
province: varchar
region_1: varchar
region_2: varchar
variety: varchar
winery: varchar
*/

select
  distinct winery
from winemag_p1
where description ~* '\y(plum|cherry|rose|hazelnut)\y';

/*
Largest Olympics

Find the Olympics with the highest number of athletes. The Olympics game is a combination of the year and the season, and is
found in the 'games' column. Output the Olympics along with the corresponding number of athletes.

olympics_athletes_events
id: int
name: varchar
sex: varchar
age: float
height: float
weight: datetime
team: varchar
noc: varchar
games: varchar
year: int
season: varchar
city: varchar
sport: varchar
event: varchar
medal: varchar
*/

with games_athletes as (
  select
    games,
    count(distinct id) as athletes_count
  from olympics_athletes_events
  group by games
  )
select
  games,
  athletes_count
from games_athletes
where athletes_count = (
  select
    max(athletes_count)
  from games_athletes
  );
