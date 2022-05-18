/*1번문제
담당 매니저가 배정되어있으나 커미션비율이 없고 , 월급이 3000 초과인 직원의
이름, 매니저아이디 , 커미션 비율 , 월급 을 출력하세요
(45건)
*/
select  emp.first_name 이름
        ,emp.manager_id 매니저아이디
        ,emp.commission_pct "커미션 비율"
        ,emp.salary 월급
from    employees emp, employees man
where   emp.manager_id = man.employee_id
and     emp.commission_pct is null
and     emp.salary > 3000;

/*
2번문제
각 부서별로 최고의 급여를 받는 사원의 직원번호 (employee_id), 이름 (first_name, 
급여(salary), 입사일 (hire_date), 전화번호 (phone_number), 부서번호 (department_id)를 조회하세요
- 조건절비교 방법으로 작성하세요
- 급여의 내림차순으로 정렬하세요
- 입사일은 2001 01 13 토요일 형식으로 출력합니다
- 전화번호는 515 123 4567 형식으로 출력합니다
(11건)
*/
select  employee_id 사번
        ,first_name 이름
        ,salary 급여
        ,to_char(hire_date,'YYYY MM DD DAY') 입사일
        ,replace(phone_number, '.', ' ') 전화번호
        ,department_id 부서번호
from    employees
where   (department_id, salary) in (select  department_id
                                            ,max(salary)
                                    from    employees
                                    group by department_id)
order by hire_date desc;

/*
3번 문제
매니저별 담당직원들의 평균급여 최소급여 최대급여를 알아보려고 한다
- 통계대상 (직원)은 2005년 이후 (2005년 1월 1일 ~ 현재)의 입사자 입니다 
- 매니저별 평균급여가 5000 이상만 출력합니다 
- 매니저별 평균급여의 내림차순으로 출력합니다
- 매니저별 평균급여는 소수점 첫째자리에서 반 올림 합니다
- 출력내용은 매니저아이디 , 매니저이름 (first_name), 매니저별 평균급여 , 매니저별최소급여 , 매
니저별최대급여 입니다
(9 건)
*/
select *
from employees
where hire_date >= '2005/01/01'
order by manager_id asc;

select  emp.manager_id
        ,emp.first_name
        ,man.avgSalary
        ,man.minSalary
        ,man.maxSalary
        ,emp.hire_date
from    employees emp, (select  manager_id
                                ,round(avg(salary),0) avgSalary
                                ,min(salary) minSalary
                                ,max(salary) maxSalary
                        from    employees 
                        group by manager_id
                        having  avg(salary) >= 5000
                        order by avg(salary) desc) man
where   emp.manager_id = man.manager_id
and     emp.hire_date >= '2005/01/01';


select  manager_id
        ,round(avg(salary),0)
        ,min(salary)
        ,max(salary)
from    employees 
group by manager_id
having  avg(salary) >= 5000
order by avg(salary) desc;

select *
from employees;


select  man.manager_id
        ,man.first_name
        ,emp.avgSalary
        ,emp.minSalary
        ,emp.maxSalary
        ,man.hire_date
from    employees man, (select  employee_id
                                ,round(avg(salary),0) avgSalary
                                ,min(salary) minSalary
                                ,max(salary) maxSalary
                        from    employees 
                        group by employee_id
                        having  avg(salary) >= 5000
                        order by avg(salary) desc) emp
where   man.manager_id = emp.employee_id
and     man.hire_date >= '2005/01/01';

/*
4번문제
각 사원(employee)에 대해서 사번(employee_id),이름(first_name), 부서명(department_name), 
매니저(manager)의 이름(first_name)을 조회하세요.
부서가 없는 직원(Kimberely)도 표시합니다.
(106명)
*/
select  emp.employee_id 사번
        ,emp.first_name 이름
        ,dep.department_name 부서명
        ,man.first_name 매니저이름
from    employees emp, employees man, departments dep
where   emp.department_id = dep.department_id(+)
and     emp.manager_id = man.employee_id;

/*
5번문제
2005년 이후 입사한 직원중에 입사일이 11 번째에서 20 번째의 직원의
사번, 이름 , 부서명 , 급여 , 입사일을 입사일 순서로 출력하세요.
*/
select  ort.rn
        ,ort.employee_id
        ,ort.first_name
        ,ort.department_name
        ,ort.salary
        ,ort.hire_date
from    (select  rownum rn
                 ,ot.employee_id
                 ,ot.first_name
                 ,ot.department_name
                 ,ot.salary
                 ,ot.hire_date
         from    (select  emp.employee_id
                          ,emp.first_name
                          ,dep.department_name
                          ,emp.salary
                          ,emp.hire_date
                  from    employees emp, departments dep
                  where   emp.department_id = dep.department_id
                  and     emp.hire_date >= '2005/01/01'
                  order by emp.hire_date asc) ot
        )ort
where   ort.rn >= 11
and     ort.rn <= 20;

/*
6번문제
가장 늦게 입사한 직원의 이름 (first_name last_name 과 연봉 (salary)과 근무하는 부서 이름
(department_name)은?
*/
select  emp.first_name || ' ' || last_name
        ,emp.salary
        ,dep.department_name
from    employees emp, departments dep
where   emp.department_id = dep.department_id
and     hire_date in (select  max(hire_date)
                      from    employees);

/*
7번문제
평균연봉(salary)이 가장 높은 부서 직원 들의 직원번호 (employee_id), 이름 (first_name), 
성(last_name) 과 업무(job_title), 연봉(salary)을 조회하시오.
*/
select  emp.employee_id 사번
        ,emp.first_name 이름
        ,emp.last_name 성
        ,emp.salary 급여
        ,emp2.avgSalary 평균급여
        ,job.job_title 업무명
from    employees emp, jobs job, (select  department_id
                                          ,avg(salary) avgSalary
                                  from    employees
                                  group by department_id
                                  having   avg(salary) > all  (select  min(salary)
                                                               from    employees
                                                               group by department_id)
                                  )emp2
where   emp.job_id = job.job_id
and     emp.department_id = emp2.department_id
order by emp.employee_id asc;

/*
8번문제
평균급여 (salary)가 가장 높은 부서는 ?
*/
select  dep.department_name
from    employees emp, departments dep 
where   emp.department_id = dep.department_id
group by dep.department_name, emp.department_id
having   avg(salary) >  all (select  min(salary)
                             from    employees
                             group by department_id);
-- 체크용
select  avg(salary)
        ,max(salary)
        ,min(salary)
        ,department_id
from    employees
group by department_id
order by department_id;

-- 부서별 평균급여
select  avg(salary)
        ,department_id
from    employees
group by department_id;
 
/*
9번문제
평균급여 (salary)가 가장 높은 지역은 ?
*/
select  reg.region_name
from    employees emp, departments dep, locations loc, countries con, regions reg
where   emp.department_id = dep.department_id
and     dep.location_id = loc.location_id
and     loc.country_id = con.country_id
and     con.region_id = reg.region_id
group by reg.region_name
having  avg(salary) > all (select  min(salary)
                           from    employees emp, departments dep, locations loc, countries con, regions reg
                           where   emp.department_id = dep.department_id
                           and     dep.location_id = loc.location_id
                           and     loc.country_id = con.country_id
                           and     con.region_id = reg.region_id
                           group by reg.region_name);

-- 체크용
select  avg(salary)
        ,min(salary)
from    employees emp, departments dep, locations loc, countries con, regions reg
where   emp.department_id = dep.department_id
and     dep.location_id = loc.location_id
and     loc.country_id = con.country_id
and     con.region_id = reg.region_id
group by reg.region_name;

/*
10번문제
평균급여 (salary)가 가장 높은 업무는 ?
*/
select  job.job_title
from    employees emp, jobs job
where   emp.job_id = job.job_id
group by job.job_title
having avg(salary) >= all (select  min(salary)
                            from    employees emp, jobs job
                            where   emp.job_id = job.job_id
                            group by job.job_title);

-- 체크용
select  avg(salary)
        ,min(salary)
        ,job.job_title
from    employees emp, jobs job
where   emp.job_id = job.job_id
group by job.job_title;





