/*
- NUMBER (2) -> ������ 2�ڸ����� ������ �� �ִ� ������ Ÿ��
- NUMBER (5, 2) -> ������, �Ǽ��θ� ��ģ �� �ڸ��� 5�ڸ�, �Ҽ��� 2�ڸ�
- NUMBER -> ��ȣ�� ������ �� (38, 0)���� �ڵ� �����ȴ�
- VARCHAR2 (byte) -> ��ȣ �ȿ� ���� ���ڿ��� �ִ� ���̸� ����(4000byte����)
- CLOB -> ��뷮 �ؽ�Ʈ ������ Ÿ�� (�ִ� 4GB)
- BLOB -> ������ ��뷮 ��ü (�̹���, ���� ����� ���)       
- DATE -> BC 4712�� 1�� 1�� ~ AD 9999�� 12�� 31�ϱ��� ���� ����
- ��, ��, �� ���� ����
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
VALUES(30, '�濵����', '����', sysdate, 2000000000);

-- �÷� �߰�
/*
ALTER TABLE table_name
ADD (colume / datatype);
*/
ALTER TABLE dept2
ADD (dept_count NUMBER(3));

-- ���̸� ����
/*
ALTER TABLE table_name
RENAME COLUMN old_name TO new_name;
*/
ALTER TABLE dept2
RENAME COLUMN dept_count TO emp_count;

-- �� �Ӽ� ����
-- ���� �����ϰ��� �ϴ� �÷��� �����Ͱ� �̹� �����Ѵٸ� �׿� �´� Ÿ������ �����ؾ��Ѵ�
-- ���� �ʴ� Ÿ�����δ� ������ �Ұ����ϴ�(NUMBER ����ִµ� VARCHAR2�� �����ϴ� ���ó��)
ALTER TABLE dept2
MODIFY (dept_name VARCHAR2(20));
DESC dept2;

-- �� ����
ALTER TABLE dept2
DROP COLUMN emp_count;

SELECT * FROM dept2;
-- TRUNCATE �������� �����͸� �����ϰ� �̸��� �ٲ��
-- �ƹ��͵� ��µ��� �ʰ� ������ �߻����� �ʴ´�
-- ���� �����͸� �������� ��

-- ���̺� �̸� ����
ALTER TABLE dept2
RENAME TO dept3;

SELECT * FROM dept3;

-- ���̺� ���� (������ ���ܵΰ� ���� �����͸� ��� ����)
TRUNCATE TABLE dept3;

DROP TABLE dept3;

ROLLBACK;  --�ǹ̾��� �̹� �����ż�

