/*
view�� �������� �ڷḸ ���� ���� ����ϴ� ���� ���̺��� �����̴�
view�� �⺻ ���̺�� ������ ���� ���̺��̱� ������
�ʿ��� �÷��� �����صθ� ������ �����ϴ�
view�� �������̺�� ���� �����Ͱ� ���������� ����� ���´� �ƴϴ�
view�� ���ؼ� �����Ϳ� �����ϸ� ���� �����ʹ� �����ϰ� ��ȣ�� �� �ִ�
*/

SELECT * FROM user_sys_privs;  -- ���� Ȯ��

-- �ܼ� ��
-- ���� �÷� �̸��� �Լ����� ����ǥ�����̸� �ȵȴ�
SELECT
    employee_id,
    first_name||' '|| last_name,
    job_id, salary
FROM employees
WHERE department_id = 60;

CREATE VIEW view_emp AS (
    SELECT
    employee_id,
    first_name||' '|| last_name AS name,
-- ORA-00998: must name this expression with a column alias    
    job_id, salary
FROM employees
WHERE department_id = 60
);

SELECT * FROM view_emp;

-- ���� ��
-- ���� ���̺��� �����Ͽ� �ʿ��� �����͸� �����ϰ� ���� Ȯ���� ���� ���
CREATE VIEW view_emp_dept_jobs AS (
    SELECT
        e.employee_id, e.first_name||' '||last_name AS name, 
        d.department_name, j.job_title
    FROM employees e
    LEFT JOIN departments d
    ON e.department_id = d.department_id
    LEFT JOIN jobs j
    ON e.job_id = j.job_id
)
ORDER BY employee_id ASC;

SELECT * FROM view_emp_dept_jobs;

-- ���� ���� (CREATE OR REPLACE VIEW ����)
-- ���� �̸����� �ش� ������ ����ϸ� �����Ͱ� ����Ǹ鼭 ���Ӱ� �����ȴ�
CREATE OR REPLACE VIEW view_emp_dept_jobs AS (
    SELECT
        e.employee_id, e.first_name||' '||last_name AS name, 
        d.department_name, j.job_title,
        e.salary  -- �߰�
    FROM employees e
    LEFT JOIN departments d
    ON e.department_id = d.department_id
    LEFT JOIN jobs j
    ON e.job_id = j.job_id
)
ORDER BY employee_id ASC;

SELECT job_title, AVG(salary)
FROM view_emp_dept_jobs
GROUP BY job_title
ORDER BY AVG(salary) DESC;  -- SQL ������ ª������

-- �� ����
DROP VIEW view_emp;

/*
VIEW�� INSERT�� �Ͼ�� ��� ���� ���̺��� �ݿ��� �ȴ�
�׷��� VIEW�� INSERT, UPDATE, DELETE�� ���� ��������� ������
���� ���̺��� NOT NULL�� ��� VIEW�� INSERT�� �Ұ����ϴ�
VIEW���� ����ϴ� �÷��� ������ ��쿡�� �ȵȴ�
*/

-- �� ��° �÷��� 'name'�� ����(virtual column)�̱� ������ INSERT�� �ȵȴ�

INSERT INTO view_emp_dept_jobs
VALUES(300, 'test', 'test', 'test', 10000);

-- JOIN�� ���� ��� �� ���� ������ �� ����
--  cannot modify more than one base table through a join view
INSERT INTO view_emp_dept_jobs
(employee_id, department_name, job_title, salary)
VALUES(300, 'test', 'test', 10000);

-- ���� ���̺��� null�� ������� �ʴ� �÷� ������ �� �� ����
INSERT INTO view_emp
(employee_id, job_id, salary)
VALUES(300, 'test', 10000);

-- WITH CHECK OPTION -> ���� ���� �÷�
-- ���ǿ� ���Ǿ��� �÷����� �並 ���ؼ� ������ �� ���� ���ִ� Ű����

CREATE OR REPLACE VIEW view_emp_test AS (
    SELECT 
        employee_id, first_name, last_name, email, 
        hire_date, job_id, department_id
    FROM employees
    WHERE department_id = 60
)
WITH CHECK OPTION CONSTRAINT view_emp_test_ck;

SELECT * FROM view_emp_test;

UPDATE view_emp_test
SET job_id = 'test'
WHERE employee_id = 106;

-- �б� ���� �� -> WITH READ ONLY(DML ������ ���´� -> SELECT�� ���)
-- cannot perform a DML operation on a read-only view
CREATE OR REPLACE VIEW view_emp_test AS (
    SELECT 
        employee_id, first_name, last_name, email, 
        hire_date, job_id, department_id
    FROM employees
    WHERE department_id = 60
) WITH READ ONLY;