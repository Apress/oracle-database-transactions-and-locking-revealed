-- Setting NOLOGGING in SQL

set serverout on

select log_mode, force_logging from v$database;

set echo on
set serverout on

drop table t purge;

variable redo number
exec :redo := get_stat_val( 'redo size' );

create table t
as
select * from all_objects;

exec dbms_output.put_line( (get_stat_val('redo size')-:redo) || ' bytes of redo generated...' );

drop table t purge;

variable redo number
exec :redo := get_stat_val( 'redo size' );

create table t
NOLOGGING
as
select * from all_objects;

exec dbms_output.put_line( (get_stat_val('redo size')-:redo) || ' bytes of redo generated...' );
