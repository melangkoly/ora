select sysdate,
    to_char(sysdate, 'YYYY-MM-DD')"DATE"
from dual;

select first_name, to_char(salary * 12, '999,999.99') "SAL"
from employees;

----------------------
--- 변환함수-------------
------------------------

--  TO_NUMBER(s, fmt) : 문자열 -> 수치열
--  TO_DATE(s, fmt) : 문자열 -> 날짜형
--  TO_CHAR(o, fmt) : 숫자, 날짜 -> 문자형

--  TO_CHAR
select first_name, hire_date, to_char(hire_date, 'YYYY-MM-DD HH24:MI:SS')"a"
from employees;

--  현재 날짜 포맷
select sysdate, to_char(sysdate,  'YYYY-MM-DD HH24:MI:SS')
from dual;

select TO_CHAR(123456789.0123, '999,999,999.99')
from dual;

--  연봉 정보 문자열로 포맷
select first_name, to_char(salary * 12, '999,999.99')"SAL"
from employees;

--  TO_NUMBER : 문자열을 숫자로 변환 
select to_number('1,999', '999,999'), to_number('$1,350.99', '$999,999.99')
from dual;

--  TO_DATE : 문자열 -> 날짜
select TO_DATE('2021-05-05 12:30', 'YYYY-MM-DD HH24:MI')
from dual;

--  DATE 연산
--  DATE +(-) number : 날짜에 일수를 더한다 (뺀다) -> DATE
--  DATE - DATE : 날짜에서 날짜를 뺀 일수
--  DATE +(-) NUMBER / 24 : 날짜에 시간을 더할 때 일수를 시간을 24로 나눈 값을 더하거나 뺀다

select to_char(sysdate, 'YYYY-MM-DD HH24:MI'),
    sysdate + 1,    --  1일 후
    sysdate - 1,    --  1일 전
    sysdate - TO_DATE('2012-09-24', 'YYYY-MM-DD'),  --  두 날짜의 차이 일수
    TO_CHAR(sysdate + 13 / 24, 'YY/MM/DD HH24:MI')  --  13시간 후
from dual;

--  Null 관련 함수

--  NVL
select first_name, 
    salary, 
    commission_pct,
    salary + (salary * nvl(commission_pct, 0))
from employees;

--  NVL2
--  nvl2(표현식, null이 아닐 때의 식, null일 때의 식)
select first_name,
    salary,
    commission_pct,
    salary + nvl2(commission_pct, salary * commission_pct, 0)
from employees;
