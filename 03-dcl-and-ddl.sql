--  사용자 관련 
-----------------
--  System 계정으로 수행
--  Create (생성), ALTER (수정), DROP(삭제), 키워드

--  사용자 생성
CREATE USER C##LCW IDENTIFIED by 1234;
--  비밀번호 변경
ALTER USER C##LCW IDENTIFIED by 4321;
--  사용자 삭제
DROP USER C##LCW 
--  경우에 따라 내부에 내용이 있는 사용자라면?
DROP USER C##LCW CASCADE; -- 폭포수라느 뜻 죄다 버려버림

--  다시 사용자를 만들자
CREATE USER C##LCW IDENTIFIED by 1234;
--  SQLPLUS로 접근을 해보자
--  사용자를 생성을 해도 권한이 없으면 암것도 할 수 없다

--  사용자 정보 확인
--  USER_USERS : 현재 사용자 정보
--  ALL_USERS : 모든 사용자 정보
--  DBA_USERS : DBA의 모든 사용자 정보
DESC USER_USERS;

select * from User_users;

DESC ALL_USERS;
SElect * from ALL_USERS;

DESC DBA_USERS;
select * from DBA_USERS;

--  사용자 계정에게 접근 권한을 부여(GRANT)
GRANT CREATE SESSION TO C##LCW;
--  일반적으로 데이터베이스 접속, 테이블을 만들려면
--  Connect, Resource 를 부여
GRANT connect, resource TO C##LCW;
--  ORACEL 12 이상에서는 사용자 테이블 스페이스에 공간 부여 필요
ALTER USER C##LCW DEFAULT TABLESPACE USERs QUOTA UNLIMITED ON USERS;

--  System Privilage 부여
--  GRANT 권한명 To 누구
--  시스템 권한의 박탈
--  Revoke 권한명 FROM 누구

--  스키마 객체에 대한 권한 부여
--  GRANT 권한 ON 객체 TO 누구
--  스키마 객체에 대한 권한 박탈
--  REVOKE 권한 ON 객체 FROM 누구

GRANT select ON hr.employees to C##LCW;
GRANT select ON hr.departments to C##LCW;

--  이하, 사용자 계정으로 수행 'ㅅ';
select * from hr.employees;
select * from hr.departments;

--  System 계정으로 hr.departments의 select 권한 회수
revoke select On hr.departments FROM C##LCW;

--  다시 사용자 계정으로
select * from hr.departments;

--------------------
--  DDL
----------

CREATE TABLE book(--    컬럼의 정의
    book_id NUMBER(5), --   5자리 정수 타입 -> PK로 변경할 것
    title VARCHAR(50),  --   50자리 가변 문자열
    author VARCHAr(10), --  10자리의 가변 문자열
    pub_date DATE DEFAULT sysdate --    날짜 타입 (기본값 = 현재 날짜)
);

DESC book;

--  서브 쿼리를 이용한 새 테이블 생성
--  hr.employees 테이블에서 일부 데이터를 추출, 새 테이블 생성
Select * from hr.employees where job_id Like 'IT_%'; -- 서브 쿼리 결과로 새 테이블 생성

CREATE TABLE it_emp as (
    select * from hr.employees
    where job_id like 'IT_%');
    
DESC it_emp;

select * from it_emp;

--  내가 가진 테이블의 목록
select * from tab;

--  테이블 삭제
DROP TABLE it_emp;

select * from tab;
--  휴지통 비우기
PURGE RecycleBin;

select * from tab;

--  테이블 추가
CREATE TABLE author (
    author_id NUMBER(10),
    author_name VARCHAR2(100) NOT NULL, --  컬럼 제약 조건 NOT NULL
    author_desc VARCHAR2(500),
    primary key (author_id) --  테이블 제약 조건 
);
DESC book;
DESC author;

--  book 테이블의 author컬럼은 삭제
--  나중에 author 테이블과 연결
ALTER TABLE book DROP COLUMN author;
DESC book;

--  author 테이블에 author_id를 참조하기 위한 author_id 컬럼을 book 테이블에 추가하자
Alter table book ADD(author_id NUMBER(10));
DESC book;

--  book.book_id를 넘버(10)으로 바꾸자
ALTER TABLE book MODIFY (book_id number(10));
desc book;

--  book.author_id -> author.author_id를 참조하도록 연결(FK)
ALTER TABLE book ADD CONSTRAINT fk_author_id FOREIGN KEY (author_id)
    REFERENCES author(author_id);
--  book 테이블의 author_id 컬럼에
--  author테이블의 author_id (PK)를 참조하는 외래키(FK) 추가
DESC book;

-----------------------
--  DATA DICTIONARY
-----------------------
--  오라클이 관리하는 데이터 베이스 관련 정보들을 모아둔 특별한 용도의 테이블
--  USER_ : 현재 로그인한 사용자 레벨의 객체들
--  ALL_ : 사용자 전체 정보
--  DBA_ : 데이터 베이스 전체에 관련된 정보들 (관리자 전용)

--  모든 딕셔너리 확인
Select * from DICTIONARY;

--  사용자 스키마 객체 확인 : USER_OBJECTS
select * from USER_OBJECTS;
select object_name, object_type from USER_OBJECTS;

--  내가 가진 제약 조건 : USER_CONSTRAINTS
Select * from USER_CONSTRAINTS;

--  BOOK 테이블에 걸려있는 제약 조건 확인
select CONSTRAINT_NAME,
    constraint_type,
    search_condition
from USER_CONSTRAINTS
where table_name = 'BOOK';