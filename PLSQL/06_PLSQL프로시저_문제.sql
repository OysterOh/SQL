/*
���ν����� guguProc
������ �� ���޹޾� �ش� �ܼ��� ����ϴ� procedure�� �����ϼ���. 
*/
CREATE PROCEDURE gugudan
    (
    A IN NUMBER
    )
IS
--A NUMBER := 1;
BEGIN
dbms_output.put_line(A|| '��');
FOR B IN 1..9 

    LOOP
        dbms_output.put_line(A||'x'||B||'='||A*B);
        END LOOP;
END;    

EXEC gugudan(8);
ROLLBACK;
/*
�μ���ȣ, �μ���, �۾� flag(I: insert, U:update, D:delete)�� �Ű������� �޾� 
depts ���̺� 
���� INSERT, UPDATE, DELETE �ϴ� depts_proc �� �̸��� ���ν����� ������.
�׸��� ���������� commit, ���ܶ�� �ѹ� ó���ϵ��� ó���ϼ���.
*/
ALTER TABLE depts ADD CONSTRAINT depts_pk PRIMARY KEY(department_id);

CREATE OR REPLACE PROCEDURE depts_proc
    (p_department_id IN departments.department_id%TYPE,
    p_department_name IN departments.department_name%TYPE,
    p_flag IN VARCHAR2
    )
IS

    v_cnt NUMBER:= 0;
BEGIN

    SELECT COUNT(*)
    INTO v_cnt
    FROM depts
    WHERE department_id = p_department_id;


    IF p_flag = 'I' THEN
        INSERT INTO departments(department_id, department_name)
        VALUES(p_department_id, p_department_name);
    ELSIF p_flag = 'U' THEN 
        UPDATE departments
        SET department_name = p_department_name
        WHERE department_id =p_department_id;
     ELSIF p_flag = 'D' THEN
     
     IF v_cnt - 0 THEN
        dbmc_output.put_line('�����ϰ��� �ϴ� �μ��� �������� �ʴ´�.');
        RETURN;
    END IF;
    DELETE FROM depts
    WHERE department_id = p_department_id;
     
        DELETE FROM depts
        WHERE department_id = p_department_id;
    ELSE 
        dbms_output.put_line('�ش� flag�� ���� ������ �غ���� �ʾҾ��');
        
    END IF;
    COMMIT;

EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('���� �߻�');
        dbms_output.put_line('SQL ERROR CODE: ' || SQLCODE);
        dbms_output.put_line('SQL ERROR MSG: ' || SQLERRM);
    ROLLBACK;
    
END;

EXEC depts_proc(100, '������', 'I');

SELECT * FROM depts;


/*
employee_id�� �Է¹޾� employees�� �����ϸ�,
�ټӳ���� out�ϴ� ���ν����� �ۼ��ϼ���. (�͸��Ͽ��� ���ν����� ����)
���ٸ� exceptionó���ϼ���
*/
CREATE OR REPLACE PROCEDURE emp_out(
    p_employee_id IN employees.employee_id%TYPE,
    p_year OUT NUMBER
)
IS
    v_hire_date employees.hire_date%TYPE;
BEGIN
    SELECT hire_date
    INTO v_hire_date
    FROM employees
    WHERE employee_id = p_employee_id;
    
    p_year := TRUNC((sysdate - v_hire_date) / 365);
    
EXCEPTION WHEN OTHERS THEN
        dbms_output.put_line(p_employee_id||'�� ���� �������Դϴ�');
        dbms_output.put_line('SQL ERROR CODE: ' || SQLCODE);
        dbms_output.put_line('SQL ERROR MSG: ' || SQLERRM);    
END;        


DECLARE
    v_year NUMBER;
BEGIN
    emp_out(100, v_year);
    dbms_output.put_line(v_year);
END;        


/*
���ν����� - new_emp_proc
employees ���̺��� ���� ���̺� emps�� �����մϴ�.
employee_id, last_name, email, hire_date, job_id�� �Է¹޾�
�����ϸ� �̸�, �̸���, �Ի���, ������ update, 
���ٸ� insert�ϴ� merge���� �ۼ��ϼ���

������ �� Ÿ�� ���̺� -> emps
���ս�ų ������ -> ���ν����� ���޹��� employee_id�� dual�� select ������ ��.
*/
CREATE OR REPLACE PROCEDURE new_emp_proc(
    p_employee_id IN emps.employee_id%TYPE,
    p_last_name IN emps.last_name%TYPE,
    p_email IN emps.email%TYPE,
    p_hire_date IN emps.hire_date%TYPE,
    p_job_id IN emps.job_id%TYPE
    )
IS
BEGIN

MERGE INTO emps e
    USING (SELECT p_employee_id  FROM dual) b 
    ON ( e.employee_id = b.employee_id )
    WHEN MATCHED THEN
        UPDATE SET
            e.last_name = p_last_name,
            e.email = p_email,
            e.hire_date = p_hire_date,
            e.job_id = p_job_id

        WHEN NOT MATCHED THEN
            INSERT (e.employee_id, e.last_name, e.email, e.hire_date, e.job_id)
            VALUES (p_employee_id, p_last_name, p_email, p_hire_date, p_job_id);
        
END;

EXEC new_emp_proc(100, 'kim', 'abc1234', sysdate, 'test');

SELECT * FROM emps;