-- Log switching

SELECT
 TRUNC(completion_time) as DAY
,COUNT(1)
,TRUNC(sum(blocks*block_size)/1024/1024) as MB
FROM gv$archived_log
WHERE first_time > TRUNC(sysdate-7)
GROUP BY TRUNC(completion_time)
ORDER BY TRUNC(completion_time);

SELECT
 thread#
,TRUNC(completion_time) as DAY
,COUNT(1)
,TRUNC(sum(blocks*block_size)/1024/1024/1024) as GB
,TRUNC(sum(blocks*block_size)/1024/1024) as MB
FROM gv$archived_log
WHERE first_time > TRUNC(sysdate-7)
AND dest_id = (SELECT dest_id FROM gv$archive_dest_status WHERE status='VALID' AND type='LOCAL')
GROUP BY thread#, TRUNC(completion_time)
ORDER BY thread#, TRUNC(completion_time);

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
