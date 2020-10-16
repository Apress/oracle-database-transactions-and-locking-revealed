-- Setting NOLOGGING on an Index

set echo on
set serverout on

select log_mode, force_logging from v$database;

drop index t_idx;
create index t_idx on t(object_name);

variable redo number
exec :redo := get_stat_val( 'redo size' );

alter index t_idx rebuild;

exec dbms_output.put_line( (get_stat_val('redo size')-:redo) || ' bytes of redo generated...');

alter index t_idx nologging;

exec :redo := get_stat_val( 'redo size' );

alter index t_idx rebuild;

exec dbms_output.put_line( (get_stat_val('redo size')-:redo) || ' bytes of redo generated...');
