---------------------
--  CUD (CREATE, UPDATE, DELETE)
------------------------

DESC author;

--  INSERT : 테이블에 새 데이터 추가
--  데이터를 넣을 컬럼을 지정하지 않으면 전체 데이터를 제공
--  테이블 정의시 지정한 순서대로 INSERT

INSERT INTO author
VALUES(1, '박경리', '토지 작가');

--  특정 컬럼의 내용만 입력할 때는 컬럼의 목록지정
INSERT INTO author (author_id, author_name)
VALUES(2, '김영하');

Select * from author;

commit; --  변경 사항 저장

INSERT INTO author (author_id, author_name)
VALUES (3, '스티븐 찬');

SAvePoint a;
select * from author;

INSERT INTO author(author_id, author_name)
VALUES (4, '톨스토이');

select * from author;
Rollback to a;  --  SavePoint a로의 복구

Select * from author;

Rollback; --    커밋 이후의 트랜잭션 시작 위치로 복구
select * from author;

desc book;
Insert into book
Values (1, '토지', Sysdate, 1);

insert into book(book_id, title, author_id)
values (2, '살인자의 기억밥', 2);


--  무결성 제약 조건을 위반한 레코드는 삽입되지 않는다
INSERT INTO book(book_id, title, author_id)
VALUES (3, '쇼생크 탈출', 3);

select * from book;

Commit;

--  UPDATE 테이블 명 Set 컬럼 명 = 값, 컬러명 = 값
UPDATE author SET author_desc = '알쓸신잡 출연';

select * from author;

--  WHERE 절을 명시하지 않으면 모든 레코드(ROW)가 업데이트 되버린다
ROllback;

UPDATE author SET author_desc = '알쓸신잡 출연'
WHERE author_id = 2;

select * from author;

--     연습
--  hr.employees 테이블로부터 department_id가 10, 20, 30인 사람만
--  새 테이블 생성
CREATE table emp123 as 
    (select * from hr.employees
        where department_id IN(10, 20, 30));

DESC emp123;
select first_name, salary, department_id from emp123;

--  부서가 30인 직원들의 급여를 10% 인상
UPDATE emp123
SET salary = salary + salary * 0.1
WHERE department_id = 30;

select first_name, salary, department_id, job_id from emp123; 

ROllback;

--  DELETE : 테이블로부터 레코드 삭제
select * from emp123;
DElete from emp123;
-- WHERE 절 없이 DELETE 를 수행하면 모든 레코드가 삭제됨
ROLLback;
select * from emp123;

DELETE from emp123
where job_id like 'PU%';

select * from emp123;
ROLLback;

--  DELETE vs TRUNCATE
--  DELETE : Transaction의 대상 -> Rollback 가능
--  TRUNCATE : Transaction의 대상이 아님 -> ROllback 불가능
DELETE from emp123;
select * from emp123;
rollback;

TRUNCATE table emp123;
select * from emp123;
Rollback;   --  log가 남아있지 않기 때문에 롤백이 되지 않는다.
select * from emp123;

