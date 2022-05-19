
-- 작가 테이블 삭제
drop table author;

-- 작가 시퀀스 삭제
drop sequence seq_author_id;

-- 작가 테이블 생성
create table author (
    author_id number(10)
    ,author_name varchar2(100)  not null
    ,author_desc varchar2(500)
    ,primary key(author_id)
);

-- 시퀀스 생성
create sequence seq_author_id
increment by 1
start with 1
nocache;


-- 테이블 내 컬럼 데이터 추가
insert into author
values (seq_author_id.nextval, '이문열', '경북영양');

insert into author
values (seq_author_id.nextval, '박경리', '경상남도 통영');

insert into author
values (seq_author_id.nextval, '유시민', '17대 국회의원');

insert into author
values (seq_author_id.nextval, '기안84', '기안동에서 산 84년생');

insert into author
values (seq_author_id.nextval, '강풀', '온라인 만화가 1세대');

insert into author
values (seq_author_id.nextval, '김영하', '알쓸신잡');



-- 테이블 조회
select  *
from    author;
--------------------------------------------------------------



-- 책 테이블 생성
create table book (
    book_id number(10)
    ,title varchar2(100) not null
    ,pubs varchar2(500)
    ,pub_date date
    ,author_id number(10)
    ,primary key (book_id)
    ,constraint book_fk foreign key (author_id)
    references author (author_id)
);

-- 시퀀스 생성
create sequence seq_book_id
increment by 1
start with 1
nocache;


-- 테이블 내 컬럼 데이터 추가
insert into book
values (seq_book_id.nextval, '우리들의 일그러진 영웅', '다림', '1998/02/22', 1);

insert into book
values (seq_book_id.nextval, '삼국지', '민음사', '2002-03-01', 1);

insert into book
values (seq_book_id.nextval, '토지', '마로니에북스', '2012-08-15', 2);

insert into book
values (seq_book_id.nextval, '유시민의 글쓰기 특강', '생각의길', '2015-04-01', 3);

insert into book
values (seq_book_id.nextval, '패션왕', '중앙북스(books)', '2012-02-22', 4);

insert into book
values (seq_book_id.nextval, '순정만화', '재미주의', '2011-08-03', 5);

insert into book
values (seq_book_id.nextval, '오직두사람', '문학동네', '2017-05-04', 6);

insert into book
values (seq_book_id.nextval, '26년', '재미주의', '2012-02-04', 5);

--테이블 조회
select  *
from    book;
-----------------------------------------------------

select  book.book_id
        ,book.title
        ,book.pubs
        ,to_char(book.pub_date,'YYYY-MM-DD') pub_date
        ,book.author_id
        ,author.author_name
        ,author.author_desc
from    book,author
where   book.author_id = author.author_id;

-- 강풀의 author_desc 정보를 ‘서울특별시’ 로 변경해 보세요
update author
set author_desc = '서울특별시'
where author_id = 5;

-- author 테이블에서 기안84 데이터를 삭제해 보세요  삭제 안됨
-- 기안84 데이터가 삭제되지 않는것은 author 테이블에서 primary key(author_id)로 되어있고
-- book 테이블에서 book_fk로 foreign key (author_id)가 연결되어있기 때문에 삭제할수가 없다.
-- 그래서 기안84데이터를 삭제하고 싶다면 book 테이블에서 기안84가 연결되어 있는 값을 지워주면 된다.

