-- SQL to generate SQL to kill sessoins

select 'ALTER SYSTEM KILL SESSION ' || '''' || sid || ',' || serial# || '''' || ';'
from v$session
where username=UPPER('&schema');
