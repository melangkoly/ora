--  문제 1
select first_name "이름", salary "월급", phone_number "전화 번호", hire_date "입사일"
from employees
order by hire_date ASC;

--  문제 2
select job_title, max_salary from jobs
order by max_salary DESC;

--  문제 3
Select first_name, manager_id, commission_pct, salary
from employees
where salary > 3000;

--  문제 4
select job_title, max_salary from jobs
where max_salary > 1000
order by max_salary desc;

--  문제 5
select first_name, salary, NVL(commission_pct, 0) from employees
where salary < 14000 AND salary >= 1000
order by salary DESC;

--  문제 6
select first_name, salary, TO_CHAR(hire_date, 'YYYY-MM-DD'), department_id
from employees
where department_id IN (10, 90, 100);

--  문제 7
select first_name, salary from employees
where first_name like '%s%';

--  문제 8
select department_name from departments
order by length(department_name);

--  문제 9
select upper(lc.country_id) from locations lc ,countries  ci 
where lc.country_id = ci.country_id
order by lc.country_id;

--  문제 10
select first_name, salary, replace(phone_number, '.', '-') phone_number, hire_date
from employees
where hire_date < '03/12/31'