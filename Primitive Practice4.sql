--  문제 1
Select Count(salary) from employees emp
where salary < (select AVG(salary) from employees);

--  문제 2
Select employee_id, first_name, salary, AVG(salary), max(salary)
from employees
where salary >= (select AVG(salary) from employees)
group by employee_id, first_name, salary
order by salary asc;

--  문제 3
Select emp.first_name || ' ' || emp.last_name as name, l.location_id, street_address, postal_code, city, state_province, country_id
from employees emp JOIn departments dept
    ON emp.department_id = dept.department_id
    JOIN locations l 
    ON dept.location_id = l.location_id
where emp.first_name = 'Steven' AND emp.last_name = 'King';

--  문제 4
Select employee_id, first_name, salary
from employees
where salary < ANY(select salary from employees emp 
    JOIN jobs j ON emp.job_id= j.job_id
    where j.job_id = 'ST_MAN')
order by salary DESC;

--  문제 5 WHERE
select emp.employee_id, first_name, emp.salary, emp.department_id 
from employees emp, (select department_id, max(salary)salary
    from employees group by department_id) sal
where emp.department_id = sal.department_id AND
    emp.salary = sal.salary
order by emp.salary DESC;

--  문제 5 JOIN
select emp.employee_id, first_name, emp.salary, emp.department_id
from employees emp JOIN (select department_id, Max(salary)salary
    from employees group by department_id)sal ON
        emp.department_id = sal.department_id AND
        emp.salary = sal.salary
order by emp.salary DESC;
    
--  문제 6
Select job_title, sum(salary) salary from employees emp JOIN jobs j ON
    emp.job_id = j.job_id
Group by job_title
order by salary DESC;

--  문제 7
Select e.employee_id 사번, e.department_id 부서번호, e.salary 연봉, vt.AVG 평균연봉
FROM employees e, (select department_id, ROUND(AVG(salary), 0)AVG
    From employees
    GRoup by department_id)vt
where e.department_id = vt.department_id AND
    e.salary > vt.AVG
order by vt.AVG DESC;

--  문제 8
Select employee_id 사번, first_name 이름, salary 급여, hire_date 입사일
From (Select a.*, rownum rn from (select * from employees order by hire_date)a
    WHere rn <= 15)
where rn >= 11;
