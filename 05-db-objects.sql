----------------------
--  DB OBJECTS
----------------------

--  SYSTEM 계정으로 CREATE VIEW 권한 부여
GRANT CREATE VIEW TO c##LCW;

--  LCW로 복귀

--  SImple View
--  단일 테이블, 함수나 연산식을 포함한 컬럼이 없는 단순 그 자체
DROP TAble emp123;
CREATE TABLE emp123
    as select * from hr.employees
        WHERE department_id IN (10, 20, 30);
select * from emp123;

--  emp123 테이블을 기반으로 30번 부서 사람들만 보여주는 뷰 생성
CREATE OR REPLACE VIEW emp10
    as SELECT employee_id, first_name, last_name, salary
        from emp123
        where department_id = 10;
        
DESC emp10;
--  이런 뷰는 테이블처럼 SELECT 할 수 있다
--  다만 실제 데이터는 원본 테이블 내에 있는 데이터를 활용
select * from emp10;
Select first_name || ' ' || last_name name, salary from emp10;

--  SimpeView는 제약 사항에 위배되지 않는다면 내용을 갱신할 수 있다.
--  Salary를 2배로 올려봅시다 'ㅅ';
Select first_name, salary from emp10;

UPDATE emp10 set salary = salary * 2;
select first_name, salary from emp123;
Rollback;

Select first_name, salary from emp10;
--  But View는 가급적 조회용으로만 사용하도록 하자
--  READ ONLY 옵션 부여 VIEW 생성
CREATE OR REPLACE VIEW EMP10
    as Select employee_id, first_name, last_name, salary
        from emp123
        where department_id = 10
        with read only;

Select * from emp10;

UPDATE emp10 set salary = salary * 2;   --  일기 전용 뷰에서는 DML 수행 불가

--  복합 뷰
DESC author;
DESC book;
--  author 와 book을 join 정보를 출력한 복합 뷰생성
CREATE OR REPLACE VIEW book_detail
(book_id, title, author_name, pub_date)
as select book_id,
    title,
    author_name,
    pub_date
from book b, author a
where b.author_id = a.author_id;

DESC book_detail;

Select * from book_detail;

UPDATE book_detail set author_name = 'Unknown';
--  복합 뷰에서는 기본적으로 DML을 수행할 수 없다

--  View 확인을 위한 DICTIONARY
Select * from USER_VIEWS; -- 사용자의 VIEW를 확인해달라
--  특정 뷰의 정보 확인을 위해 WHERE 절에 뷰 네임을 지정하면 된다
Select View_name, text from USER_VIEWs
WHERE view_name = 'BOOK_DETAIL';

-- USER_OBJECTS 테이블을 이용한 확인
Select * from USER_OBJECTS
Where object_type = 'VIEW';

-- View의 삭제
DROP VIEW book_detail;
Select * from USER_VIEWs;

-- INDEx : 검색 속도 개선을 위한 데이터 베이스 스키마
--  hr.employees의 테이블을 기반으로 s_emp 생성
CREATE TABLE s_emp
    as select * from hr.employees;
    
--  s_emp 테이블의 employee_id 컬럼에 유니크 인덱스를 생성
Select * from s_emp;
Create Unique Index s_emp_id_pk
    ON s_emp (employee_id); --  s_emp테이블의 employee_id 컬럼에 유닉인덱스 부여

--  사용자가 가지고 있는 인덱스 확인
Select * from USER_INDEXES;

--  어느 컬럼에 인덱스가 걸려 있는지 확인
Select * from USER_IND_COLUMNS;
--  두 테이블 조인, 어느 인덱스가 어느 컬럼에 걸려 있는지 확인
Select t.index_name, 
    t.table_name, 
    c.column_name, 
    c.column_position
from USER_INDEXES t, USER_IND_COLUMNS c
WHERE t.index_name = c.index_name AND
    t.table_name = 's_emp';
    
--  INDEX는
--  WHERE절, JOIN절에서 빈번하게 사용되는 컬럼
--  자주 업데이트 되는 테이블의 경우 인덱스를 계속 갱신해야함
--  때문에 인덱스가 DB의 성능을 저하시킬 수도 있음
--  꼭 필요한 컬럼에만 인덱스를 부여하는 것을 권장함

--  인덱스의 제거 'ㅅ';
DROP INDEX s_emp_id_pk;
Select * from USER_INDEXes;

--  SEQUENCE 씨퀀스
--  author 테이블에 새 레코드 삽입
DESC author;
select * from author;

--  author.author_id max 값 확인
Select max(author_id) from author;

--  새로운 quthor 추가
INSERT INTO author(author_id, author_name)
    Values((select Max(author_id) + 1 from author), 'Unknown');
select * from author;

--  유일한 PK를 확보해야할 경우 위 방법은 안전하지 않을 수 있다
--  SEQUENCE를 이용, 'ㅅ' 유일한 정수 값을 확보할 필요가 있다.
Rollback;

--  Sequence 생성
Select Max(author_id) + 1 from author;

CREATE SEQUENCE seq_author_id
    START WITH 3
    INCREMENT BY 1
    MINVALUE 1
    MAXVALUE 10000000
    NOCACHE;

--  시퀀스를 이용한 PK 부여
INSERT INTO Author (author_id, author_name)
values (seq_author_id.nextVal, 'Steven King');

select * from author;
commit;

--  새 시퀀스 생성
CREATE SEQUENCE my_seq
    START WITH 1
    INCREMENT by 1
    MAXvalue 10
    NOCACHE;
    
--  
select my_seq.nextval from dual;    --  시퀀스를 하나 증가시키고 반환
select my_seq.currval from dual;    --  현재 시퀀스 반환

--  시퀀스 수정
ALTER sequence my_seq
    INCREMENT by 2
    Maxvalue 1000000;
    
select my_seq.CUrrval from dual;
select my_seq.nextval from dual;

--  시퀀스를 위한 딕셔너리
select * from USER_SEQUENCEs;

Select * from USER_OBJECTS where object_type = 'SEQUENCE';

--  book_id 를 위한 시퀀스도 추가 해보자 ㅅ'ㅅ
select Max(book_id) from book;

CREATE sequence seq_book_id
    START WITH 3
    INCREMENT by 1
    Minvalue 1
    maxvalue 1000000
    NOCACHE;
    
select * from USER_SEQUENCES;