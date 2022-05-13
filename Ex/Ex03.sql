/*******************************
    그룹함수
*******************************/
/*
******표현불가******
select  first_name,
        sum(salary)
from employees;
*/

-- 그룹함수 count()
select  count(*),
        count(commission_pct),   -- null은 count에서 제외
        count(department_id)
from employees;

select count(salary)
from employees
where salary > 16000;


-- 그룹함수 sum()
select  count(*),
        sum(salary) 
from employees;

-- 그룹함수 avg()
select  avg(salary),   -- null 값 미포함 평균계산
        avg(nvl(salary, 0)), -- null 값 0으로 바꾼 후 평균계산
        round(avg(salary), 0),  -- 반올림
        count(*),
        sum(salary)
from employees;

-- 그룹함수 amx() / min()
select  max(salary),
        min(salary)
from employees;

/*  group by 절  */
select  first_name
from employees
where salary > 10000
order by salary desc;

/*
select  department_id,  -- 부서별 데이터 여러개
        avg(salary)     -- 전체평균 1개
from employees;
*/

select  department_id,
        job_id,
        avg(salary),     -- (department_id) 부서별 평균
        sum(salary),     -- (department_id) 부서별 합계
        count(salary)    -- (department_id) 부서별 카운트
from employees
group by department_id, job_id
order by department_id asc;

/*
select  department_id,
        count(*),
        sum(salary)
from employees
where sum(salary) >= 20000  -- where 절에는 그룹함수 사용불가
group by department_id;
*/

-- having 절 (그룹함수를 사용할 때 where 절을 사용하고 싶을 때!!!! 잊지않기)
-- having 절도 마찬가지로 and or 등 연산자 사용가능
-- 다만 having 절에는 그룹함수와 group by 절에 참여한 컬럼만 사용이 가능하다.
select  department_id,
        count(*),
        sum(salary)
from employees
group by department_id
having sum(salary) >= 20000 
and sum(salary) <=100000
and department_id = 90;

/*
select  department_id,
        count(*),
        sum(salary)
from employees
group by department_id
having sum(salary) >= 20000 
and sum(salary) <=100000
and department_id = 90
--잘못된 방법 (having절에는 그룹함수,group by에 참여한 컬럼만 사용가능
and hire_date >= '04/01/01';   
*/

-- CASE ~ END 문
select  
        employee_id,
        first_name,
        job_id,
        salary,
        -- case문은 = (equals)인경우 추가로 decode를 사용할 수 있다.
        case when job_id = 'AC_ACCOUNT' then salary + salary * 0.1
             when job_id = 'SA_REP' then salary + salary * 0.2
             when job_id = 'ST_CLERK' then salary + salary * 0.3
        end realSalary
from employees;

-- DECODE 문
select  
        employee_id,
        first_name,
        job_id,
        salary,
        decode(job_id,  'AC_ACCOUNT', salary + salary * 0.1, 
                        'SA_REP', salary + salary * 0.2, 
                        'ST_CLERK', salary + salary * 0.3,
                salary) bounus
from employees;

--예제)  
--  직원의 이름, 부서, 팀을 출력하세요팀은 코드로 결정하며 부서코드가 10~50 이면 
--  ‘A-TEAM’60~100이면 ‘B-TEAM’  110~150이면 ‘C-TEAM’ 나머지는 ‘팀없음’ 으로 출력하세요.

select  first_name,
        department_id,
        case when department_id >= 10 and department_id <= 50 then 'A-TEAM'
             when department_id >= 60 and department_id <= 100 then 'B-TEAM'
             when department_id >= 110 and department_id <= 150 then 'C-TEAM'
             else '팀없음'
        end  TEAM      
from employees
order by department_id asc;

/*********************
--      JOIN        --
*********************/
select *
from employees, departments;

select  em.employee_id,
        first_name,
        salary,
        department_name,
        de.department_id
from employees em, departments de
where em.department_id = de.department_id;

--예제)모든 직원이름, 부서이름, 업무명 을 출력하세요

select  em.first_name 이름,
        em.salary 월급,
        de.department_name 부서명,
        jo.job_title 업무명,
        de.department_id 부서아이디,
        jo.job_id 업무아이디
from employees em, departments de, jobs jo
where em.department_id = de.department_id
and jo.job_id = em.job_id
and salary >= 7000;



    



