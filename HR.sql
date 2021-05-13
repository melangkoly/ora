select * from nls_session_parameters
where parameter = 'NLS_DATE_FORMAT';

--  현재 날짜와 시간
select sysdate
from dual;  --  dual 가상테이블로부터 확인 -> 단일행

select sysdate
from employees; --  테이블로부터 받아오므로 테이블 내 행 갯수만큼 반환

--  DATE    관련 함수
select sysdate,  --  현재 날짜와 시간
    ADD_MONTH(sysdate, 2),  --  현재로부터 2개월이 지난 후
    MONTHS_BETWEEN('99/12/31', sysdate),    --  1999년 12월 31일 - 현재의 달수
    NEXT_DAY(sysdate, 7),   --  현재 날짜 이후의 첫 번째 7요일
    ROUND(TO_DATE('2021-05-17', 'YYYY-MM-DD'), 'MONTH'),    --  MONTH 정보로 반올림
    TRUNC(TO_DATE('2021-05-17', 'YYYY-MM-DD'), 'MONTH')
FROM dual;

--  현재 날짜 기준, 입사한지 몇 개월 지났는가
SELECT first_name, 
    hire_date, 
    ROUND(MONTHS_BETWEEN(sysdate, hire_date))
from employees;
