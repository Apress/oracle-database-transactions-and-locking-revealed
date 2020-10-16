-- DDL locks

set echo on

drop table t purge;
create table t as select * from all_objects;

select object_id from user_objects where object_name = 'T';

create index t_idx on t(owner,object_type,object_name) ONLINE;

-- Run this from another session while the index is being built.
-- The query has to run while the index is still being built or you
-- won't see any output.

col username form a11
col lmode form 999999
col request form 999999
col block form 999999


select (select username
from v$session
where sid = v$lock.sid) username,
sid,
id1,
id2,
lmode,
request, block, type
from v$lock
where id1 = &&your_object_id
/
