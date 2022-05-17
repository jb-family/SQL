
-- ‘Den’ 보다 급여를 많은 사람의 이름과 급여는?

select salary
from employees
where first_name = 'Den';


select  first_name
        ,salary
from employees
where salary >= (select salary
                from employees
                where first_name = 'Den')
order by salary asc;
                
               
select salary
from employees
where department_id = 110; -- 12008, 8300

select *
from employees
where salary in (12008, 8300);
                
select first_name,
        salary
from employees
where salary in (select salary
                 from employees
                 where department_id = 110)
order by salary asc;



-- 각 부서별로 최고급여를 받는 사원을 출력하세요 (where 절에 in 사용방법)
-- where 절에 사용하는 경우 테이블 컬럼 생성안된다.
-- 부서별 출력
select  max(salary)
        ,department_id
from employees
group by department_id;

-- (조건이 2개라고하면 순서에 맞게 조건을 달아줘야한다.)
-- 예) salary, department_id라고 하면 다른 select문에도 salary, department_id로 해야한다.
-- department_id, salary 하면 안된다.
select  employee_id
        ,first_name
        ,salary
        ,department_id
from employees
where (salary, department_id) in (select  max(salary)
                                  ,department_id
                                  from employees
                                  group by department_id);
                                  
                                  
-- 각 부서별 최고급여를 받는 사원을 출력하시오. (from 절에 새로운 테이블생성)
-- where 절과 다르게 from 절에 쓰이는 경우 테이블 컬럼 생성된다. 
-- e.salary와 s.salary와 조건이 같을때까지 값을 비교하고 값을 출력한다.
-- 즉 부서별 max(salary)와 e.salary와 같은 애들이 나올때까지 비교한다
select  e.department_id, 
        e.employee_id, 
        e.first_name, 
        e.salary
from employees e, (select department_id, max(salary) maxSalary
                   from employees
                   group by department_id) s 
where e.department_id = s.department_id
and e.salary = s.maxSalary;
                                  

-- 부서번호가 110인 직원의 급여 보다 큰 모든 직원의 
-- 사번, 이름, 급여를 출력하세요.(or연산--> 8300보다 큰

-- 부서번호 110인 직원의 월급 구하기
select  salary
from employees
where department_id = 110;

select  employee_id
        ,first_name
        ,salary
from    employees
where   salary > any (select    salary
                      from      employees
                      where     department_id = 110)
order by salary asc;

-- All <---> Any 비교

-- 부서번호가 110인 직원의 급여 보다 큰 모든 직원의 
-- 사번, 이름, 급여를 출력하세요.(and연산--> 12008보다 큰)


-- 부서번호 110인 직원 월급 구하기
select  salary
from employees
where department_id = 110;


select  employee_id
        ,first_name
        ,salary
from    employees
where   salary > all (select  salary
                      from employees
                      where department_id = 110)
order by salary asc;

-- 부서별로 평균 급여보다 높은 급여를 받는 사원은?
select department_id
        ,avg(salary)
from employees
group by department_id;

select  em.first_name
        ,em.salary
        ,em.department_id        
from    employees em, (select   department_id
                                ,avg(salary) avgSalary
                        from    employees
                        group by department_id) emp2
where   em.department_id = emp2.department_id
and     em.salary > emp2.avgSalary
order by em.department_id;



--------- 조건 확인용 ------------- 
select max(salary)
        ,department_id
from employees
group by department_id;

select *
from employees;
---------------------------------




                