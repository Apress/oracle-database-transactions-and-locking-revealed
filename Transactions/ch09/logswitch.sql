-- Bonus file, didn't put this in the book, shows logswitching

COL db_name NEW_VALUE h_db_name NOPRINT
COL db_date NEW_VALUE h_db_date NOPRINT
SET PAGES 90 LINES 150
SELECT name db_name, TO_CHAR(sysdate,'YYYY_MM_DD') db_date FROM v$database;
SPO &&h_db_name._LOG_&&h_db_date..lis
column "00:00" format 9999
column "01:00" format 9999
column "02:00" format 9999
column "03:00" format 9999
column "04:00" format 9999
column "05:00" format 9999
column "06:00" format 9999
column "07:00" format 9999
column "08:00" format 9999
column "09:00" format 9999
column "10:00" format 9999
column "11:00" format 9999
column "12:00" format 9999
column "13:00" format 9999
column "14:00" format 9999
column "15:00" format 9999
column "16:00" format 9999
column "17:00" format 9999
column "18:00" format 9999
column "19:00" format 9999
column "20:00" format 9999
column "21:00" format 9999
column "22:00" format 9999
column "23:00" format 9999
SELECT * FROM (
SELECT * FROM (
SELECT TO_CHAR(FIRST_TIME, 'DD/MM') AS "DAY"
, SUM(TO_NUMBER(DECODE(TO_CHAR(FIRST_TIME, 'HH24'), '00', 1, 0), '99')) "00:00"
, SUM(TO_NUMBER(DECODE(TO_CHAR(FIRST_TIME, 'HH24'), '01', 1, 0), '99')) "01:00"
, SUM(TO_NUMBER(DECODE(TO_CHAR(FIRST_TIME, 'HH24'), '02', 1, 0), '99')) "02:00"
, SUM(TO_NUMBER(DECODE(TO_CHAR(FIRST_TIME, 'HH24'), '03', 1, 0), '99')) "03:00"
, SUM(TO_NUMBER(DECODE(TO_CHAR(FIRST_TIME, 'HH24'), '04', 1, 0), '99')) "04:00"
, SUM(TO_NUMBER(DECODE(TO_CHAR(FIRST_TIME, 'HH24'), '05', 1, 0), '99')) "05:00"
, SUM(TO_NUMBER(DECODE(TO_CHAR(FIRST_TIME, 'HH24'), '06', 1, 0), '99')) "06:00"
, SUM(TO_NUMBER(DECODE(TO_CHAR(FIRST_TIME, 'HH24'), '07', 1, 0), '99')) "07:00"
, SUM(TO_NUMBER(DECODE(TO_CHAR(FIRST_TIME, 'HH24'), '08', 1, 0), '99')) "08:00"
, SUM(TO_NUMBER(DECODE(TO_CHAR(FIRST_TIME, 'HH24'), '09', 1, 0), '99')) "09:00"
, SUM(TO_NUMBER(DECODE(TO_CHAR(FIRST_TIME, 'HH24'), '10', 1, 0), '99')) "10:00"
, SUM(TO_NUMBER(DECODE(TO_CHAR(FIRST_TIME, 'HH24'), '11', 1, 0), '99')) "11:00"
, SUM(TO_NUMBER(DECODE(TO_CHAR(FIRST_TIME, 'HH24'), '12', 1, 0), '99')) "12:00"
, SUM(TO_NUMBER(DECODE(TO_CHAR(FIRST_TIME, 'HH24'), '13', 1, 0), '99')) "13:00"
, SUM(TO_NUMBER(DECODE(TO_CHAR(FIRST_TIME, 'HH24'), '14', 1, 0), '99')) "14:00"
, SUM(TO_NUMBER(DECODE(TO_CHAR(FIRST_TIME, 'HH24'), '15', 1, 0), '99')) "15:00"
, SUM(TO_NUMBER(DECODE(TO_CHAR(FIRST_TIME, 'HH24'), '16', 1, 0), '99')) "16:00"
, SUM(TO_NUMBER(DECODE(TO_CHAR(FIRST_TIME, 'HH24'), '17', 1, 0), '99')) "17:00"
, SUM(TO_NUMBER(DECODE(TO_CHAR(FIRST_TIME, 'HH24'), '18', 1, 0), '99')) "18:00"
, SUM(TO_NUMBER(DECODE(TO_CHAR(FIRST_TIME, 'HH24'), '19', 1, 0), '99')) "19:00"
, SUM(TO_NUMBER(DECODE(TO_CHAR(FIRST_TIME, 'HH24'), '20', 1, 0), '99')) "20:00"
, SUM(TO_NUMBER(DECODE(TO_CHAR(FIRST_TIME, 'HH24'), '21', 1, 0), '99')) "21:00"
, SUM(TO_NUMBER(DECODE(TO_CHAR(FIRST_TIME, 'HH24'), '22', 1, 0), '99')) "22:00"
, SUM(TO_NUMBER(DECODE(TO_CHAR(FIRST_TIME, 'HH24'), '23', 1, 0), '99')) "23:00"
FROM v$log_history
WHERE extract(year FROM FIRST_TIME) = extract(year FROM sysdate)
GROUP BY TO_CHAR(FIRST_TIME, 'DD/MM')
) ORDER BY TO_DATE(extract(year FROM sysdate) || DAY, 'YYYY DD/MM') DESC
)
WHERE ROWNUM <=14
/
SPO OFF
