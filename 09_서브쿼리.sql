/*
# ���� ����
- ���������� ������� ()�ȿ� ����Ѵ�
- ������������ �������� 1�� ���Ͽ����Ѵ�
- �������������� ���� ����� �ϳ� �ݵ�� ���� �Ѵ�
- �ؼ��� ���� �������������� ���� �ؼ��Ѵ�
*/

--'Nancy'�� �޿����� �޿��� ���� ����� �˻��ϴ� ����
SELECT salary
FROM employees
WHERE first_name = 'Nancy'; --12008

SELECT * FROM employees
WHERE salary > (SELECT salary
                FROM employees
                WHERE first_name = 'Nancy');