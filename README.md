# Databases

Solutions to exercises on databases, SQL and data modeling.


## How to set up a local database

1. Create a volume in Docker:
```
docker volume create test_v
```

2. Create and run a PostgreSQL container:
```
docker run -d --name mypostgres -p 5432:5432 -e POSTGRES_PASSWORD=pass \
-v test_v:/var/lib/postgresql/data postgres
```

If the port is already in use you can stop it:
```
sudo service postgresql stop
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
```

4. Stop running the container:
```
docker stop test_pg
```

To restart the container:
```
docker start mypostgres
```

To execute a .sql script in the container:
```
docker exec -i mypostgres postgres -u root -p pass < /scripts/create_table.sql
```


## Resources

[SQL Cookbook](https://www.oreilly.com/library/view/sql-cookbook/0596009763/) by Anthony Molinaro and Robert de Graaf

[Advanced SQL Puzzles](https://advancedsqlpuzzles.com/) by Scott Peters

[T-SQL Fundamentals](https://www.oreilly.com/library/view/t-sql-fundamentals-third/9781509302031/) by Itzik Ben-Gan

[T-SQL Window Functions](https://www.oreilly.com/library/view/t-sql-window-functions/9780135861554/) by Itzik Ben-Gan
