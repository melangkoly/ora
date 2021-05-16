--  문제 1
Select COUNT(emp.employee_id) "haveMngCnt"
from employees emp, employees man
where emp.manager_id = man.employee_id;

--  문제 2
select max(salary) "최고 임금",
min(salary) "최저 임금",
max(salary) - min(salary) "임금차"
from employees;

--  문제  3
Select to_char(hire_date, 'YYYY"년"MM"월"DD"일"') as "마지막 입사일"
from (select hire_date 
from employees
order by hire_date desc)
WHERE ROWNUM = 1;

--  문제 4
Select department_id, Max(salary),Min(salary), Round(AVG(salary), 2) 
from employees
GROUP by department_id
order by department_id;

--  문제 5
Select ROUND(AVG(emp.SALARY)), j.min_salary, j.max_salary, j.job_id
from employees emp, jobs j
group by job_id
order by AVG(emp.SALARY) DESC;

--  문제 6
Select to_char(HD.hire_date, 'YYYY-MM-DD') as "입사일",
to_char(HD.hire_date, 'day') as "요일"
from (select hire_date from employees
order by Trunc(Sysdate - hire_date) desc) HD
where rownum = 1;

--  문제 7
Select department_id as "부서번호", 
    Round(avg(salary), 2) as "평균임금",
    min(salary) as "임금", 
    Trunc(avg(salary) - min(salary)) as "임금격차"
from employees
group by department_id
Having department_id < 2000
order by "임금격차" desc;

--  문제 8
select job_title as "업무명",
    max_salary as "최대 임금",
    min_salary as "최소 임금",
    Trunc(max_salary - min_salary) as "임금차이"
from jobs
order by "임금차이" desc;

select first_name,
    emp.department_id,
    dept.department_id,
    department_name
from employees emp LEFT OUTER JOIN departments dept 
                        ON emp.department_id = dept.department_id;
--   문제 9
Select manager_id as "매니저 번호",
    Round(AVG(salary), 1) as "평균급여",
    Max(salary) as "최대급여",
    Min(salary) as "최소급여"
from employees
where hire_date >= '05/01/01'
Group by manager_id
Having AVG(salary) >= 5000
order by AVG(SALARY) desc;

--  문제 10
select hire_date 입사일,
    case when hire_date <= '02/12/31' then '창립멤버'
    when hire_date >= '05/01/01' then '상장후 입사'
    when hire_date >= '04/01/01' then '04년 입사'
    when hire_date >= '03/01/01' then '03년 입사'
      end as "optDate"
from employees
order by hire_date;
