-- Undo Segments Are in Fact Too Small

set echo on
set serverout on

create undo tablespace undo_small
  datafile '/tmp/undo.dbf' size 2m
  autoextend off
/

alter system set undo_tablespace = undo_small;

drop table t purge;

create table t
  as
  select *
  from all_objects
order by dbms_random.random;

alter table t add constraint t_pk primary key(object_id);

exec dbms_stats.gather_table_stats( user, 'T', cascade=> true );

begin
for x in ( select rowid rid from t )
loop
  update t set object_name = lower(object_name) where rowid = x.rid;
  commit;
end loop;
end;
/

-- In another session run this:
set serverout on
declare
     cursor c is
     select /*+ first_rows */ object_name
     from t
     order by object_id;

     l_object_name t.object_name%type;
     l_rowcnt      number := 0;
begin
     open c;
     loop
         fetch c into l_object_name;
         exit when c%notfound;
         dbms_lock.sleep( 0.01 );
         l_rowcnt := l_rowcnt+1;
    end loop;
    close c;
exception
    when others then
        dbms_output.put_line( 'rows fetched = ' || l_rowcnt );
        raise;
end;
/
pause

set echo on
alter database
  datafile '/tmp/undo.dbf'
  autoextend on
  next 1m
maxsize 2048m;
set echo off

begin
for x in ( select rowid rid from t )
loop
  update t set object_name = lower(object_name) where rowid = x.rid;
  commit;
end loop;
end;
/

-- In another session, start this running:
declare
     cursor c is
     select /*+ first_rows */ object_name
     from t
     order by object_id;

     l_object_name t.object_name%type;
     l_rowcnt      number := 0;
begin
     open c;
     loop
         fetch c into l_object_name;
         exit when c%notfound;
         dbms_lock.sleep( 0.01 );
         l_rowcnt := l_rowcnt+1;
    end loop;
    close c;
exception
    when others then
        dbms_output.put_line( 'rows fetched = ' || l_rowcnt );
        raise;
end;
/
pause

select bytes/1024/1024
from dba_data_files
where tablespace_name = 'UNDO_SMALL';

/* Drop the undo small tablsepace:
connect AS SYS
alter system set undo_tablespace = UNDOTBS1;
disconnect
connect AS SYS 
drop tablespace undo_small including contents and datafiles;
*/
