SET SERVEROUTPUT ON;
-- 1. ������ �� 3���� ����ϴ� �͸� ����� ����� ����. (��¹� 9���� �����ؼ� ����)
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

-- 2. employees ���̺��� 201�� ����� �̸��� �̸��� �ּҸ� ����ϴ� �͸� ����� �����.
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

-- 3. employees ���̺��� �����ȣ�� ���� ū ����� ã�Ƴ� �� (MAX �Լ� ���)
-- �� ��ȣ + 1������ �Ʒ��� ����� emps���̺�
-- employee_id, last_name, hire_date, job_id�� �ű� �����ϴ� �͸� ����� �����.
-- SELECT�� ���� INSERT�� ��� �����ϴ�.
-- �����: steven
--�̸���: stevenjobs
--�Ի�����: ���ó�¥
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