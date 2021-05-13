
--------------------------
--  ������ �Լ� : ���ڵ带 �Է����� ����
-----------------------------

--  ���ڿ� ������ �Լ�
select first_name, last_name
    concat(first_name, concat(' ', last_name)) -- ����
from employees;

select first_name, last_name
    concat(first_name, concat(' ', last_name))
    INITCAP(first_name, || ' ' || last_name),   --  ������ ù ���ڸ� �빮�� �������� �ҹ���
    LOWER(first_name),  --  ���� �ҹ��ڷ� ���
    UPPER(first_name),  --  ���� �빮�ڷ� ���
    LPAD(first_name, 20, '*'),  --  ���ʿ� 20���� ��ŭ * ä���
    RPAD(first_name, 20, '*')   --  �����ʿ� 20���ڸ�ŭ * ä���
from employees;

select '       oracle     ',
    '********DATABASE*******'
from dual;

Select LTRIM('       oracle     ''), -- ������ ���� ����
    RTRIM('       oracle     '), --   ������ ���� ����
    TRIM('*' from '********DATABASE*******') -- ������ ������ ���� ����
    SUBSTR('Oracle DataBast', 8, 4),    --  8���� ���ں��� 4����
    SUBSTR('Oracle Database', -8, 4)    --  �ڿ��� 8��° ���ں��� 4����
from dual;

--  ��ġ�� ������ �Լ�
select ABS(-3, 14), --   ���밪
    CEIL(3.14), --  �Ҽ��� �ø� (õ��)
    FLOOR(3.14),    --  �Ҽ��� ���� (�ٴ�)
    MOD(7, 3),  --  ������
    POWER(2, 4)    --   ����
    ROUND(3.5), --  �ݿø�
    ROUND(3.4567, 2),   --  �Ҽ��� 2��° �ڸ����� �ݿø� ��ȯ
    TRUNC(3.5), --  �Ҽ��� �Ʒ� ����
    TRUNC(3.4567, 2)    --  �Ҽ��� 2�� ° �ڸ����� �������� ǥ��
from dual;


