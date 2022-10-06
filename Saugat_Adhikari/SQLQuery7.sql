/*select
column_name
,count(*) key_count
from
INFORMATION_SCHEMA.columns
where column_name like '%total'
group by
COLUMN_NAME
having count(*) > 8*/

select
table_name
from 
INFORMATION_SCHEMA.TABLES
