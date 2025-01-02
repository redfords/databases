# Databases

Solutions to exercises on databases, SQL and data modeling.


## How to set up a local database

1. In the terminal run the following commands:
```shell
# create a docker volume
docker volume create test_v
# create and run a postgres container
docker run -d --name mypostgres -p 5432:5432 -e POSTGRES_PASSWORD=pass \
-v test_v:/var/lib/postgresql/data postgres
# if the port is in use you can stop it
sudo service postgresql stop
```

2. From another terminal:
```shell
# connect to the database
docker exec -it mypostgres psql -U postgres
# run any psql commands you need
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

3. Execute the .sql scripts in the container:
```shell
docker exec -i mypostgres postgres -u root -p pass < /scripts/create_table.sql
```


## Resources

[SQL Cookbook](https://www.oreilly.com/library/view/sql-cookbook/0596009763/) by Anthony Molinaro and Robert de Graaf

[Advanced SQL Puzzles](https://advancedsqlpuzzles.com/) by Scott Peters

[T-SQL Fundamentals](https://www.oreilly.com/library/view/t-sql-fundamentals-third/9781509302031/) by Itzik Ben-Gan

[T-SQL Window Functions](https://www.oreilly.com/library/view/t-sql-window-functions/9780135861554/) by Itzik Ben-Gan
