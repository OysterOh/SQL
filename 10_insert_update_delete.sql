-- insert
-- ���̺� ���� Ȯ��
-- describe
DESC departments;

-- INSERT ������ �����Ͽ� ���̺� ���ο� ���� �߰��� �� �ִ�
-- VALUES ���� ������ �� ������ ���̺� �� ���� ���� �ϳ��� �ุ�� �߰��Ѵ�

-- INSERT�� ù��° ��� (��� �÷� �����͸� �� ���� ����)
INSERT INTO departments 
values(290, '������');
--, 100, 2300

-- ���ο� ���� ������ �� ���� �������� ���� ��� VALUES ������ ���̺��� ������ ����
-- ������ Ÿ�Կ� �°� ��� ���鿡 ���� �Է������� ���ԵǾ�� �Ѵ�  values(290, '������');

SELECT * FROM departments;
ROLLBACK;  -- ���� ������ �ٽ� �ڷ� �ǵ����� Ű����

-- INSERT�� �� ��° ��� (���� �÷��� �����ϰ� ����, NOT NULL Ȯ��)
INSERT INTO departments
    (department_id, department_name, location_id)
VALUES
    (280, '������', 1700);
    
-- �纻 ���̺� ����
-- �纻 ���̺��� ������ �� �׳� �����ϸ� -> ��ȸ�� �����ͱ��� ��� ����
-- WHERE���� false�� (1=2) �����ϸ� -> ���̺��� ������ �����ϰ� �����ʹ� ���� X
CREATE TABLE managers AS   -- CTAS
(SELECT employee_id, first_name, job_id, hire_date
FROM employees WHERE 1 = 2);   --false     -- 1=1 true ���� �ۼ� X

SELECT * FROM managers;
DROP TABLE managers;

-- INSERT (��������)
INSERT INTO managers
(SELECT employee_id, first_name, job_id, hire_date
FROM employees);

--------------------------------------------------------------------------------------------------------

-- UPDATE
CREATE TABLE emps AS(SELECT * FROM employees);
SELECT * FROM emps;

/*
CTAS�� ����ϸ� ���� ������ NOT NULL ����� ������� �ʴ´�
���������� ���� ��Ģ�� ��Ű�� �����͸� �����ϰ�, �׷��� ���� �͵���
DB�� ����Ǵ� ���� �����ϴ� �������� ����Ѵ�
*/

-- UPDATE�� ������ ���� ������ ������ �� �� �����ؾ� �Ѵ�
-- �׷��� ������ ���� ����� ���̺� ��ü�� ����ȴ�
UPDATE emp SET salary = 30000;  -- ���� �� salary���� �ٲ�� 
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

-- UPDATE (��������)
UPDATE emps
    SET(job_id, salary, manager_id) = 
    (SELECT job_id, salary, manager_id
    FROM emps
    WHERE employee_id = 100
    )
WHERE employee_id = 101;    
--101���� 100�� job_id, salary, manager_id �״�� ����
SELECT * FROM emps;

-- DELETE �� ��ü ����
DELETE FROM emps
WHERE employee_id = 103;
SELECT * FROM emps;
ROLLBACK;

SELECT * FROM emps
WHERE employee_id = 103;

-- �纻���̺� ����
CREATE TABLE depts AS (SELECT  *  FROM departments);
SELECT * FROM depts;

-- DELETE (��������)
DELETE FROM emps
WHERE department_id = (SELECT department_id FROM depts
                                        WHERE department_name = 'IT');                               