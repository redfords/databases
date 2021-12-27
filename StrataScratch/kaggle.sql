/*
UNIONs
As you've seen, JOINs horizontally combine results from different tables. If you instead would like to vertically concatenate columns,
you can do so with a UNION. The example query below combines the Age columns from both tables.

Note that with a UNION, the data types of both columns must be the same, but the column names can be different. (So, for instance, we
cannot take the UNION of the Age column from the owners table and the Pet_Name column from the pets table.)

We use UNION ALL to include duplicate values - you'll notice that 9 appears in both the owners table and the pets table, and shows up
twice in the concatenated results. If you'd like to drop duplicate values, you need only change UNION ALL in the query to UNION DISTINCT.




*/