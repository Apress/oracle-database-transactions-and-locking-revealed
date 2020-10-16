-- Consistent Reads and Current Reads

exec dbms_monitor.session_trace_enable
select * from t;
update t t1 set x = x+1;
update t t2 set x = x+1;
