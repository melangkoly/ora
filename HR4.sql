select sysdate,
    to_char(sysdate, 'YYYY-MM-DD')"DATE"
from dual;

select first_name, to_char(salary * 12, '999,999.99') "SAL"
from employees;

----------------------
--- ��ȯ�Լ�-------------
------------------------

--  TO_NUMBER(s, fmt) : ���ڿ� -> ��ġ��
--  TO_DATE(s, fmt) : ���ڿ� -> ��¥��
--  TO_CHAR(o, fmt) : ����, ��¥ -> ������

--  TO_CHAR
select first_name, hire_date, to_char(hire_date, 'YYYY-MM-DD HH24:MI:SS')"a"
from employees;

--  ���� ��¥ ����
select sysdate, to_char(sysdate,  'YYYY-MM-DD HH24:MI:SS')
from dual;

select TO_CHAR(123456789.0123, '999,999,999.99')
from dual;

--  ���� ���� ���ڿ��� ����
select first_name, to_char(salary * 12, '999,999.99')"SAL"
from employees;

--  TO_NUMBER : ���ڿ��� ���ڷ� ��ȯ 
select to_number('1,999', '999,999'), to_number('$1,350.99', '$999,999.99')
from dual;

--  TO_DATE : ���ڿ� -> ��¥
select TO_DATE('2021-05-05 12:30', 'YYYY-MM-DD HH24:MI')
from dual;

--  DATE ����
--  DATE +(-) number : ��¥�� �ϼ��� ���Ѵ� (����) -> DATE
--  DATE - DATE : ��¥���� ��¥�� �� �ϼ�
--  DATE +(-) NUMBER / 24 : ��¥�� �ð��� ���� �� �ϼ��� �ð��� 24�� ���� ���� ���ϰų� ����

select to_char(sysdate, 'YYYY-MM-DD HH24:MI'),
    sysdate + 1,    --  1�� ��
    sysdate - 1,    --  1�� ��
    sysdate - TO_DATE('2012-09-24', 'YYYY-MM-DD'),  --  �� ��¥�� ���� �ϼ�
    TO_CHAR(sysdate + 13 / 24, 'YY/MM/DD HH24:MI')  --  13�ð� ��
from dual;

--  Null ���� �Լ�

--  NVL
select first_name, 
    salary, 
    commission_pct,
    salary + (salary * nvl(commission_pct, 0))
from employees;

--  NVL2
--  nvl2(ǥ����, null�� �ƴ� ���� ��, null�� ���� ��)
select first_name,
    salary,
    commission_pct,
    salary + nvl2(commission_pct, salary * commission_pct, 0)
from employees;
