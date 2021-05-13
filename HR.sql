select * from nls_session_parameters
where parameter = 'NLS_DATE_FORMAT';

--  ���� ��¥�� �ð�
select sysdate
from dual;  --  dual �������̺�κ��� Ȯ�� -> ������

select sysdate
from employees; --  ���̺�κ��� �޾ƿ��Ƿ� ���̺� �� �� ������ŭ ��ȯ

--  DATE    ���� �Լ�
select sysdate,  --  ���� ��¥�� �ð�
    ADD_MONTH(sysdate, 2),  --  ����κ��� 2������ ���� ��
    MONTHS_BETWEEN('99/12/31', sysdate),    --  1999�� 12�� 31�� - ������ �޼�
    NEXT_DAY(sysdate, 7),   --  ���� ��¥ ������ ù ��° 7����
    ROUND(TO_DATE('2021-05-17', 'YYYY-MM-DD'), 'MONTH'),    --  MONTH ������ �ݿø�
    TRUNC(TO_DATE('2021-05-17', 'YYYY-MM-DD'), 'MONTH')
FROM dual;

--  ���� ��¥ ����, �Ի����� �� ���� �����°�
SELECT first_name, 
    hire_date, 
    ROUND(MONTHS_BETWEEN(sysdate, hire_date))
from employees;
