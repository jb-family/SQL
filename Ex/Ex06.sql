

-- rownum

-- 급여를 가장 많이 받는 5명의 직원의 이름을 출력하시오.
-- 급여순으로 정렬
-- 1~5등만 출력




select  rownum 
        ,ot.employee_id
        ,ot.first_name
        ,ot.salary
from    (select  employee_id
                  ,first_name
                  ,salary
          from    employees
          order by salary desc) ot
-- rownum 급여가 높은순 1번째 ~ 5번째는 구할 수 있지만
-- 급여가 높은순 3번째 ~ 5번째는 구할 수 없다.
-- rownum은 계속 1이기 때문임.
where   rownum >= 3
and     rownum <= 5;          

select  ort.rn
        ,ort.employee_id
        ,ort.first_name
        ,ort.salary
from    (select  rownum rn
                  ,ot.employee_id
                  ,ot.first_name
                  ,ot.salary
          from    (select  employee_id
                           ,first_name
                           ,salary
                   from    employees
                   order by salary desc) ot -- salary 정렬
         )ort -- rownum 번호 생성 (salary 정렬된 조건으로)
where   ort.rn >= 3
and     ort.rn <= 5;      


(select  employee_id
        ,first_name
        ,salary
from    employees
order by salary desc) ot ;



-- 예제) 07년에 입사한 직원중 급여가 많은 직원중 3에서 7등의 이름 급여 입사일은? 

select  ort.rn
        ,ort.first_name
        ,ort.salary
        ,ort.hire_date
from    (select  rownum rn
                 ,ot.first_name
                 ,ot.salary
                 ,ot.hire_date
        from    (select  first_name
                         ,salary
                         ,hire_date
                 from    employees
                 where   hire_date >= '07/01/01'
                 and     hire_date <= '07/12/31'
                 order by salary desc) ot
        ) ort
where   ort.rn >= 3
and     ort.rn <= 7;

------------------- DDL -------------------
-- (테이블 만들기)
-- 컬럼명과 자료형은 공백으로 구분한다.
-- 컬럼끼리는 ,로 구분한다.

-- book 테이블 생성 
create table book(
    book_id number(5)
    ,title varchar2(50)
    ,author varchar2(10)
    ,pub_date date
);

-- 테이블안에 컬럼 추가
alter table book add(pubs varchar2(50));

-- 테이블안에 컬럼 수정(자료형)
alter table book modify(title varchar2(100));

-- 테이블안에 컬럼 수정(컬럼명)
alter table book rename column title to subject;

-- 테이블 내 컬럼 삭제
alter table book drop (author);

-- 테이블명 변경
rename book to article;

-- 테이블 삭제
drop table article;

-- 테이블 조회
select  *
from    article;

