-- Dealing with ORA-00054 Resource busy

select session_id
,owner
,mode_held
,mode_requested
from dba_dml_locks;

select a.sid, a.serial#
from v$session a
    ,v$locked_object b
    ,dba_objects c
where b.object_id = c.object_id
and a.sid = b.session_id
and object_name='DEPT';

