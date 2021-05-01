/*
The following unnormalized table named PRODUCT is transformed to first normal form (1NF) by splitting
it into two tables which have X and Y rows (such that X <Y) respectively. Both the tables have Z
columns.

*Product-ID*    *Colors*    *Price*
1               Red,Green   15.0
2               Blue        18.0
3               Yellow,Pink 2.5

What are the values of X, Y, Z? Enter these integers, each on a new line, in the text-box below.

3
5
2
*/

/*
A particular database is normalized to satisfy a particular level of normalization (either 1NF or 2NF
or 3NF). One of the tables contains, among other fields, a column for the City and a column for the Zip
Code. Assuming that there is a many-to-one mapping between the set of Zip Code(s) and City, we may
conclude that the database is definitely NOT in xNF form. What is the integer x (1, 2, or 3)?

3
*/

/*
A database used by a college’s application stores the relationship between students and the courses they
are enrolled in. We have information for each STUDENT (such as name, date of birth, date of enrollment,
student-id) and COURSE (course code, instructor, etc.). In real life, a student takes several courses
simultaneously while a subject is studied by several students. We need to capture this many-to-many
relationship in our database. From the above information, what is the minimum number of tables required
to structure this database in accordance with the rules of 2NF normalization?

3
*/