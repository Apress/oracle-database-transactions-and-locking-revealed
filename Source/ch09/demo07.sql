-- Sanpshot too old query

SELECT
  TO_CHAR(begin_time,'YYYY-MM-DD HH24:MI:SS') "Begin",
  TO_CHAR(end_time,'YYYY-MM-DD HH24:MI:SS') "End ",
  undoblks "UndoBlocks",
  ssolderrcnt "ORA-01555"
FROM gv$undostat
WHERE ssolderrcnt > 0;

