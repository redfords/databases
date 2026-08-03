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
				
## Data modification				
Delete based on filter. Truncate deletes all rows with no filter. Truncate is minimally logged, delete logs every deleted record.				
				
Truncate drops the table then re-creates it. Truncate is not available when the table is referenced by a foreign key constraint
