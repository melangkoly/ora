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