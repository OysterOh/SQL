-- 오토커밋 여부 확인
SHOW AUTOCOMMIT;

SET AUTOCOMMIT ON;
SET AUTOCOMMIT OFF;

DELETE FROM emps WHERE employee_id = 304;

SELECT * FROM emps;
INSERT INTO emps
        (employee_id, last_name, email, hire_date, job_id)
VALUES 
        (305, 'lee', 'lee1234@gmail.com', sysdate, 1800);

-- 보류중인 모든 데이터 변경사항을 취소(폐기), 직전 커밋 단계로 회귀(돌아가기) 및 트랜잭션 종료
ROLLBACK;        
        
-- 세이브포인트 생성
-- 롤백할 포인트를 직접 이름을 붙여서 지정
-- ANSI 표준 문법이 아니기 때문에 그렇게 권장하진 않는다
SAVEPOINT insert_park;


INSERT INTO emps
        (employee_id, last_name, email, hire_date, job_id)
VALUES 
        (305, 'park', 'park4321@gmail.com', sysdate, 1800);
ROLLBACK TO SAVEPOINT insert_park;
-- 보류중인 모든 데이터 변경사항을 영구적으로 적용하면서 트랜잭션 종료
-- 커밋한 이후에는 어떠한 방법을 사용하더라도 되돌릴 수 없다
COMMIT;   

/* COMMIT과 ROLLBACK의 장점
- 데이터의 일관성 제공
- 데이터 영구적으로 변경하기 전에 데이터 변경을 미리보기 가능
- 관련된 작업을 논리적으로 그룹화
- 하나의 트랜잭션이 끝난 후 다음 실행 가능한 SQL 문장은 
  자동적으로 다음 트랜잭션을 시작
*/

