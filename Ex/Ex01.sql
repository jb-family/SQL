/************************************
select 문
    select 절
    from 절
    where 절
    order by 절
************************************/

-- 모든 컬럼 조회하기 

select *
from employees;

select *
from departments;

-- 원하는 컬럼만 조회하기
select employee_id, first_name, last_name
from employees;



--예제)
-- 사원의 이름(first_name)과 전화번호 입사일 연봉을 출력하세요

select *
from employees;

select first_name, phone_number, hire_date, salary
from employees;

--사원의이름(first_name)과성(last_name)급여, 전화번호, 이메일, 입사일을출력하세요

select first_name 
        ,last_name 
        ,salary 
        ,phone_number
        ,email
        ,hire_date
from employees;

--출력할 때 컬럼명 별명 사용하기
select  first_name "이름",
        phone_number "전화번호",
        hire_date "입사일",
        salary "급여"
from employees;


select  first_name as 이름,
        last_name 성,
        salary 급여,
        phone_number  "hp",
        email 이메일,
        hire_date 입사일
from employees;


--연결연산자 (컬럼 붙이기)

select  first_name,
        last_name
from employees;
-- 합쳐진 컬럼에 공백을 주고 싶다면 ||사이에 ' '(문자로 공백을주면된다.) || 
select  first_name || ' ' || last_name
from employees;

select first_name || ' hire date is ' ||hire_date 입사일
from employees;

--산술 연산자
-- 새로운 컬럼을 변형시켜 * 연산자를 사용하면 결과 값을 계산해서 보여준다.
select  first_name, 
        salary, 
        salary * 12,
        (salary + 300) * 12
from employees;

--예제)
select  job_id
from employees;

--예제) 전체직원의 정보를 다음과 같이 출력하세요
select  first_name || '-' ||last_name 성명,
        salary 급여,
        salary*12 연봉,
        (salary*12)+5000 연봉2,
        phone_number 전화번호
from employees;


/*  where 절  */
--예제) 부서번호가10인사원의이름을구하시오

select first_name 
from employees  -- employees 모든 값 출력
where department_id = 10;   -- 출력 값 중에서 department_id 가 10인 사람의 이름 모두 출력

--예제) 연봉이15000 이상인사원들의이름과월급을출력하세요
select  first_name,
        salary
from employees
where salary >= 15000;

--예제)   07/01/01 일이후에입사한사원들의이름과입사일을출력하세요
select  first_name,
        hire_date
from employees
where hire_date >= '07/01/01';

--예제   이름이Lex인직원의연봉을출력하세요
select  salary*12
from employees
where first_name = 'Lex';

-- 14000이상 17000 이하
select  first_name,
        salary
from employees
where salary >= 14000 
and salary <= 17000;

--예제 연봉이14000이하 17000이상인 사원의 이름과 연봉을 구하시오
--연봉 14000이하 값들과 17000이상 값들이 나옴.
select  first_name,
        salary
from employees
where salary <= 14000
or salary >= 17000;


--예제 입사일이 04/01/01 ~ 05/12/31 사이의 사원의 이름과 입사일을 출력하세요
select  first_name,
        hire_date   
from employees
where hire_date >= '04/01/01' 
and hire_date <= '05/12/31';

--예제 연봉이14000이상 17000이하인 사원의 이름과 연봉을 구하시오
-- salary >= 14000 and salary <= 17000 다른표현.
-- salary > 14000 and salary < 17000 이렇게 표현하고싶다면 between 사용하면안됨.
select  first_name,
        salary
from employees
where salary between 14000 and 17000;

--IN 연산자로 여러 조건을 검사하기
select  first_name,
        last_name,
        salary
from employees
where first_name = 'Neena'
or first_name = 'Lex'
or first_name = 'John';


select  first_name,
        last_name,
        salary
from employees
where first_name in ('Neena', 'Lex','John');

--예제) 연봉이2100, 3100, 4100, 5100인 사원의 이름과 연봉을 구하시오
select  first_name,
        salary
from employees
where salary in (2100, 3100, 4100, 5100);

select  first_name,
        salary
from employees
where salary = 2100
or salary = 3100
or salary = 4100
or salary = 5100;

--Like 연산자로 비슷한 것들 모두 찾기
-- % : 임의의길이의문자열(공백문자가능)
-- _ : 한글자길이
select  first_name,
        last_name,
        salary
from employees
where first_name like 'L%';

select  first_name,
        last_name,
        salary
from employees
where first_name like 'L___'; -- L___ L과 _3개포함(4글자) 즉 L로시작하면서4글자인사람 출력

select  first_name,
        last_name,
        salary
from employees
where first_name like '%s%'; 





--예제) 이름에am을 포함한 사원의 이름과 연봉을 출력하세요
select  first_name,
        salary
from employees
where first_name like '%am%';

--예제) 이름의 두번째 글자가 a인 사원의 이름과 연봉을 출력하세요
select  first_name,
        salary
from employees
where first_name like '_a%';

--예제) 이름의 네번째 글자가 a인 사원의 이름을 출력하세요
select first_name
from employees
where first_name like '___a%';

--예제) 이름이 4글자인 사원 중 끝에서 두번째 글자가 a인 사원의 이름을 출력하세요

select first_name
from employees
where first_name like '__a_';


select  first_name,
        salary,
        commission_pct,
        salary*commission_pct
from employees
where salary between 13000 and 15000;

select  first_name,
        salary,
        commission_pct,
        salary*commission_pct
from employees
where commission_pct is not null; 
-- null 값을 가진 사람만 찾고싶다면 is null을 사용해야 한다.
-- null 값이 없는 사람만 찾고싶다면 is not null을 사용해야 한다.

--예제) 커미션 비율이 있는 사원의 이름과 연봉 커미션 비율을 출력하세요
select  first_name,
        salary,
        commission_pct
from employees
where commission_pct is not null;


--예제) 담당 매니저가 없고 커미션 비율이 없는 직원의 이름을 출력하세요
select first_name
from employees
where  manager_id is null 
and commission_pct is null;


select  first_name,
        salary
from employees
where salary >= 10000;

--order by 절을 사용해보기 좋게 정렬하기
-- 어떤 컬럼을 정렬하고싶은지 쓰면된다.
select  first_name, 
        salary
from employees
order by salary asc;
-- 오름차순 order by salary asc;
-- 내림차순 order by salary desc ;

select  first_name, 
        salary
from employees
where salary >= 9000
order by salary asc;

select *
from employees
order by first_name asc;

--예제)부서번호를오름차순으로정렬하고부서번호, 급여, 이름을출력하세요
select  department_id,
        salary,
        first_name
from employees
order by department_id asc;

--예제)급여가10000 이상인 직원의 이름 급여를 급여가 큰직원부터 출력하세요
select  first_name,
        salary
from employees
where salary >= 10000
order by salary desc;

--예제)부서번호를 오름차순으로 정렬 //하고부서번호가같으면급여가높은사람부터 부서번호급여이름을출력하세요
select  department_id,
        salary,
        first_name
from employees
order by department_id asc, salary desc, first_name desc;



-- 단일행 함수
-- 문자함수–INITCAP(컬럼명)
-- 영어의 첫글자만 대문자로 출력하고 나머지는 전부 소문자로 출력하는 함수

-- 부서번호 100인 직원의 이메일주소와 부서번호를 출력하세요
select  email,
        initcap(email) "email",
        department_id
from employees
where department_id = 100;

-- 문자함수–LOWER(컬럼명) / UPPER(컬럼명)
-- 입력되는 값을 전부 소문자 / 대문자로 변경하는 함수
-- 모두 대문자 출력 upper()
-- 모두 소문자 출력 lower()
select  first_name,
        upper(first_name) upper, 
        lower(first_name) lower
from employees
where department_id = 100;

-- 문자함수–SUBSTR(컬럼명, 시작위치, 글자수)
-- 주어진 문자열에서 특정 길이의 문자열을 구하는 함수
-- substr(first_name,1,3) 앞에서 첫번째에서 세번째까지 글자만 출력
-- substr(first_name,-3,2) 뒤에서 세번째부터 두번째까지 글자만 출력
select  first_name,
        substr(first_name,1,3) frontstr,
        substr(first_name,-3,2) backstr
from employees
where department_id = 100;



-- 문자함수–LPAD(컬럼명, 자리수, ‘채울문자’) / RPAD(컬럼명, 자리수, ‘채울문자’)
-- LPAD() :왼쪽공백에특별한문자로채우기
-- RPAD() :오른쪽공백에특별한문자로채우기
select  first_name,
        lpad(first_name, 10, '*'),
        rpad(first_name, 10, '*')
        --rpad(lpad(first_name,10, '*'), 15, '*')
from employees;

-- 문자함수–REPLACE (컬럼명, 문자1, 문자2)
-- 컬럼명에서 문자1을 문자2로 바꾸는 함수
select  first_name,
        replace(first_name, 'a', '*'),
        substr(first_name,2, 3),
        replace(first_name, substr(first_name,2, 3), '***')
from employees
where department_id = 100;

-- 가상테이블(테스트용)
select replace('abcdefg', 'bc', '******')
from dual;

select  substr('900123-1234234', 8, 1),
        substr('900123-2234234', 8, 1)
from dual;

-- 숫자함수의종류
-- ROUND(m,n) 소수점 아래 n자리까지 반올림
--round(123.346, 2) .뒤 2자리 반올림 123.35출력
-- round(123.346, 0) 123 반올림 123출력
-- round(123.346, -1) 123의 12자리를 반올림 120 출력
select  round(123.346, 2) r2,
        round(123.346, 0) r0,
        round(123.346, -1) "r-1"
from dual;

-- 숫자함수–TRUNC(숫자, 출력을원하는자리수)
-- 주어진 숫자의 버림을 하는 함수
-- trunc(123.346,2) round와 같으나 소숫점 버리는 함수
select  trunc(123.346,2) r2,
        trunc(123.456,0) r0,
        trunc(123.456,-1) "r-1"
from dual;
-- 날짜함수–SYSDATE()
select sysdate
from dual;

-- 단일함수>날짜함수–MONTHS_BETWEEN(d1, d2) (d1, d2 개월수를 출력하는 함수)
select MONTHS_BETWEEN('22/12/12','22/05/12')
from dual;

select MONTHS_BETWEEN(sysdate, hire_date)
from employees
where department_id = 110;

-- 변환함수의종류
-- TO_CHAR(숫자, ‘출력모양’) 숫자형문자형으로변환하기
select  first_name,
        to_char(salary*12,'$099,999')
from employees
where department_id = 110;

select  to_char(9876, '999999'),
        to_char(9876, '099,999'),
        to_char(9876, '$99,999'),
        to_char(9876, '9999.99'),
        to_char(987654321, '999,999,999'),
        to_char(987654321, '999,999,999.999')
from dual;

-- 단일함수>변환함수>TO_CHAR(날짜, ‘출력모양’) 날짜문자형으로변환하기
select  sysdate,
        to_char(sysdate, 'YYYY-MM-DD'),
        to_char(sysdate, 'YYYY/MM/DD HH24:MI:SS'),
        to_char(sysdate, 'YYYY"년" MM"월" DD"일" HH24"시" MI"분" SS"초"'),
        to_char(sysdate, 'YY'),
        to_char(sysdate, 'MM'),
        to_char(sysdate, 'DD'),
        to_char(sysdate, 'MONTH'),
        to_char(sysdate, 'DAY'),
        to_char(sysdate, 'HH24'),
        to_char(sysdate, 'MI'),
        to_char(sysdate, 'SS')
from dual;




