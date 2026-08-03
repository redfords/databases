# Background

Relational model: set theory and predicate logic. A predicate is a property or expression that is either true or false.	In set thepry a relation is a representation of a set. 	Relation: set of related information (table). Operations on relations result in a relation (for example a join).
				
- DDL:	Data definition language (create, alter, drop)
- DML:	Data manipulation	(select, insert, update, delete, truncate)
- DCL:	Data control	(grant, revoke)
				
## Type of database systems				
OLTP online transactional processing: data entry, insert, update and delete data.

Data warehouse: data retrieval and reporting for an entire organization.

Star schema: the simplest dw design. Dimension tables and fact table.	

Data mart: only part of the organization or a subject matter area.	

Intentional redundancy, fewer tables and simpler relationships, more efficient queries.
				
ETL the process that pulls data from sources (OLTP and others) and loads it into the dw. Data staging area DSA is data cleansing between OLTP and DW.			
			
Order clauses are logically processed:				
1. from 2. where 3. group by 4. having 5. select 6. order by				
				
## Truncate vs. delete				
Delete based on filter. Truncate deletes all rows with no filter. Truncate is minimally logged, delete logs every deleted record.				
				
Truncate drops the table then re-creates it. Truncate is not available when the table is referenced by a foreign key constraint

## Row store databases vs. columnar store databases

Transactional databases are designed to be efficient at processing transactions (insert, update and delete) ex. MySQL and Postgres.
Through careful tuning and schema design, they can be used for analytics. 

We think of a table as rows and columns, but data has to be serialized for storage. A query searches a hard disk for the needed data. Hard disks are organized in a series of blocks of a fixed size. Scanning the hard disk takes both time and resources, so it's important to minimize the amout of disk that needs to be scanned to return query results.

Row-store databases serializes data in a row. When querying, the whole row is read into memory. This approach is fast when making row-wise updates, but it's slower when making calculations accross many
rows if only a few columns are needed. To reduce the width of tables, row-store databases are usually modeled in third normal form.

Column store databases store the values of a column together, rather than storing the values of a row together. This design is optimized for queries that read many records but not necessarily all the columns.
Popular column-store databases include Amazon Redshift and Snowflake.

Column-store databases are efficient at storing large volumes of data thanks to compression. Missing values and repeating values can be represented by very small marker values instead of the full value.
They do not enforce primary keys and do not have indexes. Repeated values are not problematic, due to compression.
