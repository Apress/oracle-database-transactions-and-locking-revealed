-- Check for undindexed foreign key

drop table emp;
drop table dept;

create table dept 
  as select * from scott.dept;

create table emp
  as select * from scott.emp;

alter table dept
  add constraint dept_pk
  primary key(deptno);

alter table emp
  add constraint emp_pk
  primary key(empno);

alter table emp
  add constraint emp_fk_dept
  foreign key (deptno)
  references dept(deptno);

COLUMN columns FORMAT A30 word_wrapped
COLUMN table_name FORMAT A15 word_wrapped
COLUMN constraint_name FORMAT A15 word_wrapped

select table_name, constraint_name,
cname1 || nvl2(cname2,','||cname2,null) ||
nvl2(cname3,','||cname3,null) || nvl2(cname4,','||cname4,null) ||
nvl2(cname5,','||cname5,null) || nvl2(cname6,','||cname6,null) ||
nvl2(cname7,','||cname7,null) || nvl2(cname8,','||cname8,null)
   columns
from ( select b.table_name,
         b.constraint_name,
         max(decode( position, 1, column_name, null )) cname1,
         max(decode( position, 2, column_name, null )) cname2,
         max(decode( position, 3, column_name, null )) cname3,
         max(decode( position, 4, column_name, null )) cname4,
         max(decode( position, 5, column_name, null )) cname5,
         max(decode( position, 6, column_name, null )) cname6,
         max(decode( position, 7, column_name, null )) cname7,
         max(decode( position, 8, column_name, null )) cname8,
         count(*) col_cnt
         from (select substr(table_name,1,30) table_name,
                     substr(constraint_name,1,30) constraint_name,
                     substr(column_name,1,30) column_name,
                           position
                          from user_cons_columns ) a,
                       user_constraints b
                 where a.constraint_name = b.constraint_name
                   and b.constraint_type = 'R'
                 group by b.table_name, b.constraint_name
              ) cons
        where col_cnt > ALL
                ( select count(*)
                    from user_ind_columns i,
                         user_indexes     ui
                   where i.table_name = cons.table_name
                     and i.column_name in
                       (cname1, cname2, cname3, cname4,
                        cname5, cname6, cname7, cname8 )
                     and i.column_position <= cons.col_cnt
                     and ui.table_name = i.table_name
                     and ui.index_name = i.index_name
                     and ui.index_type IN ('NORMAL','NORMAL/REV')
                   group by i.index_name
                );

create index empfkidx on emp(deptno);

select table_name, constraint_name,
cname1 || nvl2(cname2,','||cname2,null) ||
nvl2(cname3,','||cname3,null) || nvl2(cname4,','||cname4,null) ||
nvl2(cname5,','||cname5,null) || nvl2(cname6,','||cname6,null) ||
nvl2(cname7,','||cname7,null) || nvl2(cname8,','||cname8,null)
   columns
from ( select b.table_name,
         b.constraint_name,
         max(decode( position, 1, column_name, null )) cname1,
         max(decode( position, 2, column_name, null )) cname2,
         max(decode( position, 3, column_name, null )) cname3,
         max(decode( position, 4, column_name, null )) cname4,
         max(decode( position, 5, column_name, null )) cname5,
         max(decode( position, 6, column_name, null )) cname6,
         max(decode( position, 7, column_name, null )) cname7,
         max(decode( position, 8, column_name, null )) cname8,
         count(*) col_cnt
         from (select substr(table_name,1,30) table_name,
                     substr(constraint_name,1,30) constraint_name,
                     substr(column_name,1,30) column_name,
                           position
                          from user_cons_columns ) a,
                       user_constraints b
                 where a.constraint_name = b.constraint_name
                   and b.constraint_type = 'R'
                 group by b.table_name, b.constraint_name
              ) cons
        where col_cnt > ALL
                ( select count(*)
                    from user_ind_columns i,
                         user_indexes     ui
                   where i.table_name = cons.table_name
                     and i.column_name in
                       (cname1, cname2, cname3, cname4,
                        cname5, cname6, cname7, cname8 )
                     and i.column_position <= cons.col_cnt
                     and ui.table_name = i.table_name
                     and ui.index_name = i.index_name
                     and ui.index_type IN ('NORMAL','NORMAL/REV')
                   group by i.index_name
                );

