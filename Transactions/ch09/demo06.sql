-- Reporting on undo

SELECT s.username,
       s.sid,
       s.serial#,
       t.used_ublk,
       t.used_urec,
       rs.segment_name,
       r.rssize,
       r.status
FROM   v$transaction t,
       v$session s,
       v$rollstat r,
       dba_rollback_segs rs
WHERE  s.saddr = t.ses_addr
AND    t.xidusn = r.usn
AND    rs.segment_id = t.xidusn
ORDER BY t.used_ublk;

SELECT
  s.inst_id,
  s.username,
  s.sid,
  s.serial#,
  s.machine,
  NVL(s.client_info,'nada') client_info,
  NVL(s.sql_id, s.prev_sql_id) sql_id,
  NVL(sqlcom.command_name,'nada') sqlcommand,
  s.module,
  s.action,
  s.program,
  t.status,
  t.start_date,
  ROUND((SYSDATE-t.start_date)*24*60*60) AS secondsopen,
  SUM(t.used_urec) as undorecordsinuse,
  SUM(t.used_ublk) as undoblocksinuse
FROM
  gv$transaction t,
  gv$session s,
  gv$sqlcommand sqlcom
WHERE t.addr = s.taddr
AND sqlcom.command_type=s.command
AND t.inst_id = s.inst_id
GROUP BY
  s.inst_id,
  s.username,
  s.sid,
  s.serial#,
  s.machine,
  s.client_info,
  NVL(s.sql_id, s.prev_sql_id),
  NVL(sqlcom.command_name,'nada'),
  s.module,
  s.action,
  s.program,
  t.status,
  t.start_date,
  (SYSDATE-t.start_date)*24*60*60
ORDER BY
  undoblocksinuse DESC;
