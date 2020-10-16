-- Blocking basics

-- Open first session. 
sqlplus chewy/foo@localhost:1521/orcl

select username, sid, serial#
from v$session where username=(USER);

-- Then in second terminal connect as the DARTH user:
sqlplus darth/foo@localhost:1521/orcl

select username, sid, serial#
from v$session where username=(USER);

select
 username AS blked_user
,serial#  AS blked_serial#
,sid      AS blked_sid
,blocking_session AS blking_sid
,seconds_in_wait AS sec_in_wait
from v$session
where blocking_session is not NULL
order by blocking_session;

select
 username
,sid
,serial#
from v$session
where sid=&sid;

