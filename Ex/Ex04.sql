

/*
SubQuery
Query문 2개를 하나로 합치는 것을 SubQuery라고 한다.
SubQuery 부분은 where 절의 연산자 오른쪽에 위치해야 하며 괄호로 묶어야한다.
가급적 order by 를 하지 않는다. 
단일행 SubQuery 와 다중행 SubQuery 에 따라 연산자를 잘 선택해야함
현재 예제는 단일행  다중행과 구분해서 사용해야함

*/

/*
단일행 SubQuery 
단일행 SubQuery는 >, >=, <, <=, = 으로 끝난다.
*/

--예제) 'Den’ 보다 급여를 많은 사람의 이름과 급여는?

-- Den의 급여를 구한다.
select  first_name
        ,salary
from    employees
where   first_name = 'Den';     --11000

select  first_name
        ,salary
from    employees
where salary >= (select  salary
                 from    employees
                 where   first_name = 'Den')
order by salary desc;




-- 예제) 급여를 가장 적게 받는 사람의 이름, 급여, 사원번호는?

-- 가장 작은급여를 구한다.
select  min(salary)
from    employees;

select first_name
        ,salary
        ,employee_id
from employees
where salary = (select  min(salary)
                from    employees)
order by salary asc;


-- 예제) 평균 급여보다 적게 받는 사람의 이름, 급여를 출력하세요?

-- 평균 급여를 구한다.
select  avg(salary)
from    employees;


select  first_name
        ,salary
from    employees
where   salary < (select  avg(salary)
                  from    employees)
order by salary desc;


/* 다중행 SubQuery 
    subQuery의 결과가 여러 Row인 경우 >, >=, <, <=, = 사용안된다. in으로 해줘야함.
*/

/* 예제) 부서번호가 110인 직원의 급여와 같은 모든 직원의 
		 사번, 이름, 급여를 출력하세요 
*/

-- 부서번호가 110인 직원의 급여를 구한다.

select  salary
from    employees
where department_id = 110;

select  employee_id
        ,first_name
        ,salary
from    employees
where   salary = 12008
or      salary = 8300;

select  employee_id
        ,first_name
        ,salary
from    employees
where   salary in (select  salary
                   from    employees
                   where department_id = 110)   -- 12008, 8300

















