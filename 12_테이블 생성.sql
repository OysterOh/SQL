/*
- NUMBER (2) -> 정수를 2자리까지 저장할 수 있는 숫자형 타입
- NUMBER (5, 2) -> 정수부, 실수부를 합친 총 자리수 5자리, 소수점 2자리
- NUMBER -> 괄호를 생략할 시 (38, 0)으로 자동 지정된다
- VARCHAR2 (byte) -> 괄호 안에 들어올 문자열의 최대 길이를 지정(4000byte까지)
- CLOB -> 대용량 텍스트 데이터 타입 (최대 4GB)
- BLOB -> 이진형 대용량 객체 (이미지, 파일 저장시 사용)       
- DATE -> BC 4712년 1월 1일 ~ AD 9999년 12월 31일까지 지정 가능
- 시, 분, 초 지원 가능
*/

CREATE TABLE dept2(
    dept_no NUMBER(2), dept_name VARCHAR2(14),
    loca VARCHAR2(15),
    dept_date DATE,
    dept_bonus NUMBER(10)
);

ROLLBACK;

SELECT * FROM dept2;
DESC dept2;

INSERT INTO dept2
VALUES(30, '경영지원', '서울', sysdate, 2000000000);

-- 컬럼 추가
/*
ALTER TABLE table_name
ADD (colume / datatype);
*/
ALTER TABLE dept2
ADD (dept_count NUMBER(3));

-- 열이름 변경
/*
ALTER TABLE table_name
RENAME COLUMN old_name TO new_name;
*/
ALTER TABLE dept2
RENAME COLUMN dept_count TO emp_count;

-- 열 속성 수정
-- 만약 변경하고자 하는 컬럼에 데이터가 이미 존재한다면 그에 맞는 타입으로 변경해야한다
-- 맞지 않는 타입으로는 변경이 불가능하다(NUMBER 들어있는데 VARCHAR2로 변경하는 경우처럼)
ALTER TABLE dept2
MODIFY (dept_name VARCHAR2(20));
DESC dept2;

-- 열 삭제
ALTER TABLE dept2
DROP COLUMN emp_count;

SELECT * FROM dept2;
-- TRUNCATE 구문으로 데이터를 삭제하고 이름을 바꿨다
-- 아무것도 출력되지 않고 에러도 발생하지 않는다
-- 안의 데이터만 삭제했을 뿐

-- 테이블 이름 변경
ALTER TABLE dept2
RENAME TO dept3;

SELECT * FROM dept3;

-- 테이블 삭제 (구조는 남겨두고 내부 데이터만 모두 삭제)
TRUNCATE TABLE dept3;

DROP TABLE dept3;

ROLLBACK;  --의미없음 이미 삭제돼서

