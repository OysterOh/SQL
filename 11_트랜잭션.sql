-- ����Ŀ�� ���� Ȯ��
SHOW AUTOCOMMIT;

SET AUTOCOMMIT ON;
SET AUTOCOMMIT OFF;

DELETE FROM emps WHERE employee_id = 304;

SELECT * FROM emps;
INSERT INTO emps
        (employee_id, last_name, email, hire_date, job_id)
VALUES 
        (305, 'lee', 'lee1234@gmail.com', sysdate, 1800);

-- �������� ��� ������ ��������� ���(���), ���� Ŀ�� �ܰ�� ȸ��(���ư���) �� Ʈ����� ����
ROLLBACK;        
        
-- ���̺�����Ʈ ����
-- �ѹ��� ����Ʈ�� ���� �̸��� �ٿ��� ����
-- ANSI ǥ�� ������ �ƴϱ� ������ �׷��� �������� �ʴ´�
SAVEPOINT insert_park;


INSERT INTO emps
        (employee_id, last_name, email, hire_date, job_id)
VALUES 
        (305, 'park', 'park4321@gmail.com', sysdate, 1800);
ROLLBACK TO SAVEPOINT insert_park;
-- �������� ��� ������ ��������� ���������� �����ϸ鼭 Ʈ����� ����
-- Ŀ���� ���Ŀ��� ��� ����� ����ϴ��� �ǵ��� �� ����
COMMIT;   

/* COMMIT�� ROLLBACK�� ����
- �������� �ϰ��� ����
- ������ ���������� �����ϱ� ���� ������ ������ �̸����� ����
- ���õ� �۾��� �������� �׷�ȭ
- �ϳ��� Ʈ������� ���� �� ���� ���� ������ SQL ������ 
  �ڵ������� ���� Ʈ������� ����
*/

