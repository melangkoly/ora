--  문제1
select employee_id, first_name, last_name,department_name
from employees emp, departments dept
where emp.department_id = dept.department_id
order by department_name, employee_id desc;

--  문제2
select employee_id, first_name, salary, department_name, job_title
from employees emp, departments dept, jobs j
where j.job_id = emp.job_id 
AND emp.department_id = dept.department_id
order by employee_id;

-- 문제  2-1
select employee_id, first_name, salary, department_name, job_title
from employees emp, departments dept, jobs j
where j.job_id = emp.job_id
AND emp.department_id = dept.department_id(+)
order by employee_id;

--  문제 3
select lc.location_id, city, department_name, department_id
from locations lc, departments dept
where lc.location_id = dept.location_id
order by location_id;

--  문제 3-1
select lc.location_id, city, department_name, department_id
from locations lc, departments dept
where lc.location_id = dept.location_id (+)
order by location_id;

--  문제 4
Select region_name, country_name
from regions rg, countries co
where co.region_id = rg.region_id
order by region_name, Country_name desc;

--  문제 5
select emp.employee_id,
    emp.first_name,
    emp.manager_id,
    emp.hire_date,
    man.first_name,
    man.hire_date
from employees emp JOIN employees man
                    ON emp.manager_id = man.employee_id
where emp.hire_date < man.hire_date;

--  문제 6
Select country_name, country_id, department_name, department_id
from departments dept Inner JOIN locations lc 
       USING(location_id)
       natural join countries
order by department_id;

--  문제 7
Select employee_id as "사번"
    , first_name||' '||last_name as "풀네임", 
    emp.job_id as "업무 아이디",
    start_date as "시작일",
    end_date as "종료일"
from employees emp Join job_history jh USING(employee_id)
where jh.job_id = 'AC_ACCOUNT';

--  문제 8
Select dept.department_id as "부서아이디",
    department_name as "부서명",
    emp.first_name as "매니저 이름",
    city as "도시명", 
    country_name as "나라 이름",
    region_name as "지역 이름"
from employees emp JOIN employees man
                    ON emp.manager_id = man.employee_id
                    JOIN departments dept USING(department_id)
                    JOIN locations lc ON dept.location_id = lc.location_id
                    JOIN countries co ON lc.country_id = co.country_id
                    JOIN regions rg ON co.region_id = rg.region_id;
                    
--  문제 9
Select emp.employee_id, emp.first_name, department_name, man.first_name
from employees emp JOIN employees man
                    ON emp.manager_id = man.employee_id
                    LEFT OUTER JOIN departments dept 
                    ON emp.department_id = dept.department_id;