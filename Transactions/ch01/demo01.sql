-- Multiversioning example

--sqlplus / as sysdba

drop table t;

-- Time 1
create table t as select username from all_users where username like 'SYS%';
 
-- Time 2
set autoprint off
variable x refcursor;
begin
  open :x for select * from t;
  end;
/
 
-- Time 3
declare
  pragma autonomous_transaction;
  -- you could do this in another
  -- sqlplus session as well, the
  -- effect would be identical
begin
  delete from t;
  commit;
end;
/

-- Time 4
select * from t;
 
-- Time 5
print x
