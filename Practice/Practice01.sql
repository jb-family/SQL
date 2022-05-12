-- 1번문제
select  first_name || ' ' || last_name 이름,
        salary 월급,
        phone_number 전화번호,
        hire_date 입사일
from employees
order by hire_date asc;

-- 2번문제
select  job_title 이름,
        max_salary 최대월급
from jobs
order by max_salary desc;

-- 3번문제
select  first_name 이름,
        manager_id 매니저아이디,
        commission_pct 커미션비율,
        salary 월급
from employees
where   commission_pct is null
and     salary > 3000
order by salary desc;

-- 4번문제
select  job_title 업무명,
        max_salary 최고월급
from jobs
where max_salary >= 10000
order by max_salary desc;

-- 5번문제
select  first_name 이름,
        salary 월급,
        commission_pct || 0 커미션비율
from employees
where salary < 14000
and salary >= 10000
and commission_pct is null
order by salary desc;

-- 6번문제
select  first_name 이름,
        salary 월급,
        to_char(hire_date,'YYYY-MM') 입사일,
        department_id 부서번호
from employees
where department_id in(10, 90, 100)
order by hire_date asc;

-- 7번문제
select  first_name,
        salary
from employees
where first_name like('%s%')
or first_name like ('%S%');


-- 8번문제
select *
from departments
order by length(department_name)desc;

-- 9번문제
select  country_id 나라아이디,
        replace(country_name,'Brazil', upper(country_name)) 지사있는나라,
        replace(country_name,'Australia', upper(country_name)) 지사있는나라2,
        replace(country_name,'China', upper(country_name)) 지사있는나라3,
        region_id 지역아이디
from countries
order by country_name asc;

-- 10번문제
select  first_name 이름,
        salary 월급,
        replace(phone_number,'.', '-') 전화번호,
        hire_date 입사일
from employees
where hire_date < '03/12/31'
order by hire_date asc;

