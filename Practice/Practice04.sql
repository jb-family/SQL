/*
1번문제
평균
급여보다 적은 급여을 받는 직원은 몇명인지 구하시요
(56건)
*/

-- 평균 급여구하기
select  avg(salary)
from employees;

select  count(salary)
from    employees
where   salary < (select  avg(salary)
                  from employees);


/*
2번문제
평균급여 이상 , 최대급여 이하의 월급을 받는 사원의
직원번호(employee_id), 이름 (first_name), 급여 (salary), 평균급여 , 최대급여를 급여의 
오름차순으로 정렬하여 출력하세요
(51건)
*/
select  emp.employee_id
        ,emp.first_name
        ,emp.salary
        ,emp2.avgSalary
        ,emp2.maxSalary
from    employees emp, (select  avg(salary) avgSalary
                                ,max(salary) maxSalary
                        from    employees) emp2
where   emp.salary >= emp2.avgSalary
and     emp.salary <= emp2.maxSalary
order by salary asc;

/*
3번문제
직원중 Steven(first_name) king(last_name) 이 소속된 부서 (departments)가 있는곳의 주소를 알아보려고 한다
도시아이디 (location_id), 거리명 (street_address), 우편번호 (postal_code), 도시명 (city), 
주(state_province), 나라아이디 (country_id) 를 출력하세요
(1건)
*/

select  loc.location_id
        ,loc.street_address
        ,loc.postal_code
        ,loc.city
        ,loc.state_province
        ,loc.country_id
from    locations loc
where   loc.location_id in (select  dep.location_id
                            from    employees emp, departments dep
                            where   emp.department_id = dep.department_id
                            and     first_name = 'Steven' and last_name = 'King');

/*
4번문제
job_id가 'ST_MAN' 인 직원의 급여보다 작은 직원의 사번 이름 급여를 급여의 내림차순으로
출력하세요 ANY 연산자 사용
(74건)
*/
select  employee_id
        ,first_name
        ,salary
from    employees
where   salary < any (select  salary
                      from    employees
                      where   job_id = 'ST_MAN')
order by salary desc;


/*
5번문제
각
부서별로 최고의 급여를 받는 사원의 직원번호 (employee_id), 이름 (first_name)과 
급여(salary) 부서번호 (department_id) 를 조회하세요
단, 조회결과는 급여의 내림차순으로 정렬되어 나타나야 합니다 .
조건절비교, 테이블조인 2 가지 방법으로 작성하세요
(11건) 
*/

-- where
select  employee_id
        ,first_name
        ,salary
        ,department_id
from    employees
where   (salary, department_id) in (select  max(salary)
                                            ,department_id
                                    from    employees
                                    group by department_id)
order by salary desc;

-- from
select  emp.employee_id
        ,emp.first_name
        ,emp.salary
        ,emp.department_id
from    employees emp , (select  max(salary) maxSalary
                                ,department_id
                        from    employees
                        group by department_id) emp2
where   emp.salary = emp2.maxSalary
and     emp.department_id = emp2.department_id
order by emp.salary desc;

/*
6번문제
각 업무 (job) 별로 연봉 (salary)의 총합을 구하고자 합니다 .
연봉 총합이 가장 높은 업무부터 업무명 (job_title) 과 연봉 총합을 조회하시오
(19건)
*/

select  job.job_title
        ,job2.sumSalary
from    jobs job, (select  sum(salary) sumSalary
                           ,job_id
                   from    employees
                   group by job_id)job2
where   job.job_id = job2.job_id
order by job2.sumSalary desc;


/*
7번문제
자신의 부서 평균 급여보다 연봉 (salary)이 많은 직원의 직원번호 (employee_id), 
이름(first_name) 과 급여 (salary)을 조회하세요
(38건)
*/

select  emp.employee_id
        ,emp.first_name
        ,emp.salary
from    employees emp, (select  avg(salary) avgSalary
                                ,department_id
                        from    employees
                        group by department_id) emp2
where   emp.department_id = emp2.department_id
and     emp.salary > emp2.avgSalary;


/*
8번문제
직원 입사일이 11 번째에서 15 번째의 직원의 사번 , 이름 , 급여 , 입사일을 입사일 순서로 
출력하세요
*/
select  rn
        ,employee_id
        ,first_name
        ,salary
        ,hire_date
from    (select  rownum rn
                ,employee_id
                ,first_name
                ,salary
                ,hire_date
        from    (select employee_id
                        ,first_name
                        ,salary
                        ,hire_date
                from    employees        
                order by hire_date asc) 
        )
where   rn >= 11
and     rn <= 15;
