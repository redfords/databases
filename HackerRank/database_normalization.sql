/*
The following unnormalized table named PRODUCT is transformed to first normal form (1NF) by splitting
it into two tables which have X and Y rows (such that X <Y) respectively. Both the tables have Z
columns.

*Product-ID*    *Colors*    *Price*
1               Red,Green   15.0
2               Blue        18.0
3               Yellow,Pink 2.5

What are the values of X, Y, Z? Enter these integers, each on a new line, in the text-box below.

Answer:
3
5
2
*/

/*
A particular database is normalized to satisfy a particular level of normalization (either 1NF or 2NF
or 3NF). One of the tables contains, among other fields, a column for the City and a column for the Zip
Code. Assuming that there is a many-to-one mapping between the set of Zip Code(s) and City, we may
conclude that the database is definitely NOT in xNF form. What is the integer x (1, 2, or 3)?

Answer:
3
*/

/*
A database used by a college’s application stores the relationship between students and the courses they
are enrolled in. We have information for each STUDENT (such as name, date of birth, date of enrollment,
student-id) and COURSE (course code, instructor, etc.). In real life, a student takes several courses
simultaneously while a subject is studied by several students. We need to capture this many-to-many
relationship in our database. From the above information, what is the minimum number of tables required
to structure this database in accordance with the rules of 2NF normalization?

Answer:
3
*/

/*
Let us take the example of a simple movie library. Each movie has a description, director, and serial
number. Customers have a name, address, and membership number. Assume only one copy of each movie exists
in the library. We are given the following relations and determinants.

Relations (The key is CAPITALIZED):
customer(name,addr,MEMBERNO)
movie(DESCRIPTION,director,serialno)
borrow(memberno,DATE,SERIALNO)

Determinants:
description->director,serialno
serialno->description
serialno->director
name,addr -> memberno
memberno -> name,addr
serialno,date -> memberno

The above relation is in x**NF form where x may take the following values {1,2,3,3.5} corresponding to
{1NF, 2NF, 3NF and BCNF} respectively.
What is the maximum possible value of **x such that the above relation satisfies the *x*NF form?

Answer:
3
*/

/*
The following table stores rows of information about pizza deliveries. The three columns correspond to
the Restaurant name, Crust, Delivery Area. We convert this table into Fourth Normal Form and so we end
up creating two tables, each with two columns and N rows. (Both the new tables have an equal number of
rows)

Restaurant  Crust       Delivery Area
-------------------------------------------
X Pizza     Thick       Whitefield
X Pizza     Thick       Greenville
X Pizza     Thick       Capital
X Pizza     Stuffed     Whitefield
X Pizza     Stuffed     Greenville
X Pizza     Stuffed     Capital
Papa Pizza  Thin        Capital
Papa Pizza  Stuffed     Capital
F1 Pizza    Thick       Whitefield
F1 Pizza    Thick       Greenville
F1 Pizza    Thin        Whitefield
F1 Pizza    Thin        Greenville

In the text box below, enter the value of the integer N.

Answer:
6
*/
