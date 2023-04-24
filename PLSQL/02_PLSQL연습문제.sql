SET SERVEROUTPUT ON;
-- 1. 구구단 중 3단을 출력하는 익명 블록을 만들어 보자. (출력문 9개를 복사해서 쓴다)
DECLARE
    A NUMBER := 3;
BEGIN
    DBMS_OUTPUT.put_line('3x1 = '|| TO_CHAR(A));
    DBMS_OUTPUT.put_line('3x2 = '|| TO_CHAR(A*2));
    DBMS_OUTPUT.put_line('3x3 = '|| TO_CHAR(A*3));
    DBMS_OUTPUT.put_line('3x4 = '|| TO_CHAR(A*4));
    DBMS_OUTPUT.put_line('3x5 = '|| TO_CHAR(A*5));
    DBMS_OUTPUT.put_line('3x6 = '|| TO_CHAR(A*6));
    DBMS_OUTPUT.put_line('3x7 = '|| TO_CHAR(A*7));
    DBMS_OUTPUT.put_line('3x8 = '|| TO_CHAR(A*8));
    DBMS_OUTPUT.put_line('3x9 = ' || TO_CHAR(A*9));
END;

-- 2. employees 테이블에서 201번 사원의 이름과 이메일 주소를 출력하는 익명 블록을 만든다.
DECLARE
    v_emp_first_name VARCHAR2(50);
--    v_emp_name employees.first_name%TYPE;
    v_emp_email VARCHAR2(50);
--    v_emp_name employees.email%TYPE;
BEGIN
    SELECT e.first_name, e.email
    INTO v_emp_first_name, v_emp_email
    FROM employees e
    WHERE e.employee_id = 201;
    DBMS_OUTPUT.put_line(v_emp_first_name||', '||v_emp_email);
END;

-- 3. employees 테이블에서 사원번호가 제일 큰 사원을 찾아낸 뒤 (MAX 함수 사용)
-- 이 번호 + 1번으로 아래의 사원을 emps테이블에
-- employee_id, last_name, hire_date, job_id를 신규 삽입하는 익명 블록을 만든다.
-- SELECT절 이후 INSERT문 사용 가능하다.
-- 사원명: steven
--이메일: stevenjobs
--입사일자: 오늘날짜
--job_id: CEO


DECLARE
    v_employee_id VARCHAR2(50);
BEGIN
    SELECT MAX(employee_id)
    INTO v_employee_id
    FROM employees e;
    DBMS_OUTPUT.put_line(v_employee_id);
    INSERT INTO emps
--    MAX(employee_id + 1) 
        (first_name, email, hire_date, job_id)
     VALUES
        ('steven', 'stevenjobs', sysdate, 'CEO');   
        DBMS_OUTPUT.put_line(first_name, email, hire_date, job_id);
END;



DECLARE
    v_max_empno employees.employee_id%TYPE;
BEGIN
    
    SELECT
        MAX(employee_id)
    INTO 
        v_max_empno
    FROM employees;
    
    INSERT INTO emps
        (employee_id, last_name, email, hire_date, job_id)
    VALUES
        (v_max_empno + 1, 'steven', 'stevenjobs', sysdate, 'CEO'); 
END;

SELECT * FROM emps
WHERE employee_id = 207;