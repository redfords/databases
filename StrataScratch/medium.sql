
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
