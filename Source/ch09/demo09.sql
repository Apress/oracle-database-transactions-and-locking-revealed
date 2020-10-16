-- Who is generating redo?

set lines 300
col username form a10
col program format a50
col module form a50
col redoSize form 999999999
col username form a10

select 
   s.username,
   s.sid,
   s.serial#,
   ss.value AS redoSize,
   s.program,
   s.module
from v$statname sn,
     v$sesstat ss,
     v$session s
where ss.statistic#=sn.statistic# 
and sn.name='redo size' 
and s.sid=ss.sid 
and ss.value>0
and s.username is not null
order by ss.value;

select table_owner, table_name, inserts, updates, deletes
from dba_tab_modifications
where table_owner !='SYS';
