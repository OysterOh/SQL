-- insert
-- 테이블 구조 확인
-- describe
DESC departments;

-- INSERT 문장을 실행하여 테이블에 새로운 행을 추가할 수 있다
-- VALUES 절을 가지는 이 문장은 테이블에 한 번에 오직 하나의 행만을 추가한다

-- INSERT의 첫번째 방법 (모든 컬럼 데이터를 한 번에 지정)
INSERT INTO departments 
values(290, '영업부');
--, 100, 2300

-- 새로운 행을 삽입할 때 열을 지정하지 않을 경우 VALUES 절에는 테이블을 정의할 때의
-- 순서와 타입에 맞게 모든 열들에 대한 입력정보가 포함되어야 한다  values(290, '영업부');

SELECT * FROM departments;
ROLLBACK;  -- 실행 시점을 다시 뒤로 되돌리는 키워드

-- INSERT의 두 번째 방법 (직접 컬럼을 지정하고 저장, NOT NULL 확인)
INSERT INTO departments
    (department_id, department_name, location_id)
VALUES
    (280, '개발자', 1700);
    
-- 사본 테이블 생성
-- 사본 테이블을 생성할 때 그냥 생성하면 -> 조회된 데이터까지 모두 복사
-- WHERE절에 false값 (1=2) 지정하면 -> 테이블의 구조만 복사하고 데이터는 복사 X
CREATE TABLE managers AS   -- CTAS
(SELECT employee_id, first_name, job_id, hire_date
FROM employees WHERE 1 = 2);   --false     -- 1=1 true 굳이 작성 X

SELECT * FROM managers;
DROP TABLE managers;

-- INSERT (서브쿼리)
INSERT INTO managers
(SELECT employee_id, first_name, job_id, hire_date
FROM employees);

--------------------------------------------------------------------------------------------------------

-- UPDATE
CREATE TABLE emps AS(SELECT * FROM employees);
SELECT * FROM emps;

/*
CTAS를 사용하면 제약 조건은 NOT NULL 말고는 복사되지 않는다
제약조건은 업무 규칙을 지키는 데이터만 저장하고, 그렇지 않은 것들이
DB에 저장되는 것을 방지하는 목적으로 사용한다
*/

-- UPDATE를 진행할 때는 누구를 수정할 지 잘 지목해야 한다
-- 그렇지 않으면 수정 대상이 테이블 전체로 지목된다
UPDATE emp SET salary = 30000;  -- 전부 다 salary값이 바뀐다 
SELECT * FROM emps;
ROLLBACK;

UPDATE emps SET salary = 30000
WHERE employee_id = 100;
SELECT * FROM emps;

UPDATE emps SET salary = salary + salary * 0.1
WHERE employee_id = 100;
SELECT * FROM emps;  --33000

UPDATE emps SET 
phone_number = '010.9876.5432', manager_id = 102
WHERE employee_id = 100;
SELECT * FROM emps;

-- UPDATE (서브쿼리)
UPDATE emps
    SET(job_id, salary, manager_id) = 
    (SELECT job_id, salary, manager_id
    FROM emps
    WHERE employee_id = 100
    )
WHERE employee_id = 101;    
--101에게 100의 job_id, salary, manager_id 그대로 적용
SELECT * FROM emps;

-- DELETE 행 전체 삭제
DELETE FROM emps
WHERE employee_id = 103;
SELECT * FROM emps;
ROLLBACK;

SELECT * FROM emps
WHERE employee_id = 103;

-- 사본테이블 생성
CREATE TABLE depts AS (SELECT  *  FROM departments);
SELECT * FROM depts;

-- DELETE (서브쿼리)
DELETE FROM emps
WHERE department_id = (SELECT department_id FROM depts
                                        WHERE department_name = 'IT');                               