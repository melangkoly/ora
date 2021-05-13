--  CASE �Լ�
--  ���ʽ��� �����ϱ�� �ߴ�
--  AD���� �������Դ� 20%, SA ���� �������Դ� 10%, IT���� �������Դ� 8%
--  �������� 5%

select first_name, job_id, salary, SUBSTR(job_id, 1, 2),
    case substr(job_id, 1, 2) when 'AD' then salary * 0.2
                                when 'SA' then salary * 0.1
                                when 'IT' then salary * 0.08
                                else salary * 0.05
    end as bonus
from employees;

--  Decode
select first_name, salary, job_id, substr(job_id, 1, 2),
    decode(substr(job_id, 1, 2),
        'AD', salary * 0.2,
        'SA', salary * 0.1,
        'IT', salary * 0.08,
        salary * 0.05) as bonus
from employees;

--  Ǫ��Ƽ��
--  department_id <= 30 -> A-group
--  department_id <= 50 -> B-group
--  department_id <= 100 -> C-group
--  ������ : 
select first_name, department_id,
    case when department_id <= 30 then 'A-Group'
        when department_id <= 50 then 'B-Group'
        when department_id <= 100 then 'C-Group'
        else 'Remainder'
    end as team
from employees
order by team;
