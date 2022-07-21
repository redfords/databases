
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
