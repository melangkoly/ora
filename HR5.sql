--  ���� 1
select first_name, last_name, salary, phone_number, hire_date
from employees
order by hire_date;
--  ����2
select job_id, salary
from employees
order by salary DESC;
--  ���� 3
select first_name, manager_id, nvl(commission_pct, 0), salary
from employees
WHERE salary > 3000;

--  ���� 4
select 
from employees;
