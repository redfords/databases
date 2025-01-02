# Databases

HackerRank and LeetCode practice on databases, SQL and data modeling.


## Use Docker to set up a local database

1.
```
docker volume create test_vol
```
2.
```
docker run --rm --name test_pg -e POSTGRES_PASSWORD=pass -p 5433:5432 -v test_vol:/var/lib/postgresql/data postgres
```

3.
From another terminal:
```

docker exec -it test_pg psql -U postgres

create database test_db;
\l
\c test_db
create schema test;

create table plants (plant text, color text);
insert into plants values
    ('roses', 'red'),
    ('tulip', 'red');
\dt

\q

docker stop test_pg
```

## Resources

[SQL Cookbook](https://www.oreilly.com/library/view/sql-cookbook/0596009763/) by Anthony Molinaro and Robert de Graaf

[Advanced SQL Puzzles](https://advancedsqlpuzzles.com/) by Scott Peters

[T-SQL Fundamentals](https://www.oreilly.com/library/view/t-sql-fundamentals-third/9781509302031/) by Itzik Ben-Gan

[T-SQL Window Functions](https://www.oreilly.com/library/view/t-sql-window-functions/9780135861554/) by Itzik Ben-Gan
