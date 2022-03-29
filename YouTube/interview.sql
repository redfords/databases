/* Srouce: https://www.youtube.com/watch?v=Td-cmLfQ7uU */

-- Write a SQL query to count the number of unique users per day who logged in from both iPhone and web,
-- where iPhone logs and web logs are in distinct relations.

iphone: ts | userid | iphone_sessionid
web: ts | userid | web_sessionid

