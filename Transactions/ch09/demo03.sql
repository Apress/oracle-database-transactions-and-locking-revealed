-- Advanced blocking example

COL blocker FORM A10
COL blockee FORM A10

select
 (select username from v$session where sid=a.sid) blocker,
  a.sid,' is blocking ',
 (select username from v$session where sid=b.sid) blockee,
  b.sid
    from v$lock a, v$lock b
   where a.block = 1
     and b.request > 0
     and a.id1 = b.id1
     and a.id2 = b.id2;

select
  sblocker.username AS blocker
 ,blocker.sid
 ,sblocker.serial#
 ,'is blocking '
 ,sblockee.username AS blockee
 ,blockee.sid
 ,sblockee.seconds_in_wait secondsWait
from v$lock    blocker
    ,v$session sblocker
    ,v$lock    blockee
    ,v$session sblockee
where blocker.block = 1
and   blockee.request > 0
and   blocker.id1 = blockee.id1
and   blocker.id2 = blockee.id2
and   blocker.sid = sblocker.sid
and   blockee.sid = sblockee.sid;

