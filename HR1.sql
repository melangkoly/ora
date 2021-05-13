
--------------------------
--  단일행 함수 : 레코드를 입력으로 받음
-----------------------------

--  문자열 단일행 함수
select first_name, last_name
    concat(first_name, concat(' ', last_name)) -- 결합
from employees;

select first_name, last_name
    concat(first_name, concat(' ', last_name))
    INITCAP(first_name, || ' ' || last_name),   --  영어의 첫 글자만 대문자 나머지는 소문자
    LOWER(first_name),  --  전부 소문자로 출력
    UPPER(first_name),  --  전부 대문자로 출력
    LPAD(first_name, 20, '*'),  --  왼쪽에 20글자 만큼 * 채우기
    RPAD(first_name, 20, '*')   --  오른쪽에 20글자만큼 * 채우기
from employees;

select '       oracle     ',
    '********DATABASE*******'
from dual;

Select LTRIM('       oracle     ''), -- 왼쪽의 공백 제거
    RTRIM('       oracle     '), --   오른쪽 공백 제거
    TRIM('*' from '********DATABASE*******') -- 양쪽의 지정된 문자 제거
    SUBSTR('Oracle DataBast', 8, 4),    --  8번쨰 글자부터 4글자
    SUBSTR('Oracle Database', -8, 4)    --  뒤에서 8번째 글자부터 4글자
from dual;

--  수치형 단일행 함수
select ABS(-3, 14), --   절대값
    CEIL(3.14), --  소수점 올림 (천장)
    FLOOR(3.14),    --  소숫점 버림 (바닥)
    MOD(7, 3),  --  나머지
    POWER(2, 4)    --   제곱
    ROUND(3.5), --  반올림
    ROUND(3.4567, 2),   --  소숫점 2번째 자리까지 반올림 변환
    TRUNC(3.5), --  소숫점 아래 버림
    TRUNC(3.4567, 2)    --  소수점 2번 째 자리까지 버림으로 표시
from dual;


