--���� 1.
--EMPLOYEES ���̺��� ��� ������� ��ձ޿����� ���� ������� �����͸� ��� �ϼ��� ( AVG(�÷�) ���)
--EMPLOYEES ���̺��� ��� ������� ��ձ޿����� ���� ������� ���� ����ϼ���
--EMPLOYEES ���̺��� job_id�� IT_PROG�� ������� ��ձ޿����� ���� ������� �����͸� ����ϼ���
-- 6461....
SELECT *
FROM employees 
WHERE salary > (
SELECT AVG(salary)
FROM employees);

SELECT COUNT(*)
FROM employees 
WHERE salary > (
SELECT AVG(salary)
FROM employees);


SELECT * FROM employees
WHERE salary >
(
SELECT AVG(salary)
FROM employees
WHERE job_id = 'IT_PROG');   -- 5760

--���� 2.
---DEPARTMENTS���̺��� manager_id�� 100�� ����� department_id��
--EMPLOYEES���̺��� department_id�� ��ġ�ϴ� ��� ����� ������ �˻��ϼ���.
SELECT 
(SELECT department_id
FROM employees e
WHERE e.department_id = d.department_id)
FROM departments d
WHERE d.manager_id = '100';

SELECT department_id
FROM departments
WHERE manager_id = '100';


SELECT * FROM employees
WHERE department_id =
(
SELECT department_id
FROM departments
WHERE manager_id = '100');

--���� 3.
---EMPLOYEES���̺��� ��Pat���� manager_id���� ���� manager_id�� ���� ��� ����� �����͸� ����ϼ���
---EMPLOYEES���̺��� ��James��(2��)���� manager_id�� ���� ��� ����� �����͸� ����ϼ���.
SELECT manager_id
FROM employees
WHERE first_name = 'Pat'; --201

SELECT * FROM employees
WHERE manager_id > (SELECT manager_id
FROM employees
WHERE first_name = 'Pat');

SELECT * FROM employees
WHERE manager_id IN
(SELECT manager_id FROM employees
WHERE first_name = 'James');

--���� 4.
---EMPLOYEES���̺� ���� first_name�������� �������� �����ϰ�, 41~50��° �������� �� ��ȣ, �̸��� ����ϼ���
SELECT * FROM
    (SELECT  ROWNUM AS rn, tbl.first_name 
    FROM 
        (SELECT *
        FROM employees 
        ORDER BY first_name DESC
        )tbl
)
WHERE rn > 40 AND rn <=50;

--���� 5.
---EMPLOYEES���̺��� hire_date�������� �������� �����ϰ�, 31~40��° �������� �� ��ȣ, ���id, �̸�, ��ȣ, 
--�Ի����� ����ϼ���.
SELECT * FROM
    (SELECT ROWNUM AS rn, employee_id, first_name, phone_number, hire_date
    FROM employees 
    ORDER BY hire_date ASC)
WHERE rn>30 AND rn<=40;



SELECT * FROM
(SELECT ROWNUM AS rn, tbl.* FROM
    (
    SELECT employee_id, first_name, phone_number, hire_date
    FROM employees
    ORDER BY hire_date ASC
    )tbl
)
WHERE rn>30 AND rn<=40;

--���� 6.
--employees���̺� departments���̺��� left �����ϼ���
--����) �������̵�, �̸�(��, �̸�), �μ����̵�, �μ��� �� ����մϴ�.
--����) �������̵� ���� �������� ����
SELECT e.employee_id, e.first_name||' '||e.last_name AS name, d.department_id, d.department_name
FROM employees e
LEFT JOIN departments d
ON e.department_id = d.department_id
ORDER BY employee_id ASC;

--���� 7.
--���� 6�� ����� (��Į�� ����)�� �����ϰ� ��ȸ�ϼ���
SELECT e.employee_id, e.first_name||' '||e.last_name AS name, e.department_id,
    (
        SELECT department_name
        FROM departments d 
        WHERE e.department_id = d.department_id
    ) AS  department_name
FROM  employees e
ORDER BY employee_id ASC;

--���� 8.
--departments���̺� locations���̺��� left �����ϼ���
--����) �μ����̵�, �μ��̸�, �Ŵ������̵�, �����̼Ǿ��̵�, ��Ʈ��_��巹��, ����Ʈ �ڵ�, ��Ƽ �� ����մϴ�
--����) �μ����̵� ���� �������� ����
SELECT d.department_id, d.department_name, d.manager_id, d.location_id, 
               lo.street_address, lo.postal_code, lo.city
FROM departments d
LEFT JOIN locations lo
ON d.location_id = lo.location_id
ORDER BY department_id ASC;

--���� 9.
--���� 8�� ����� (��Į�� ����)�� �����ϰ� ��ȸ�ϼ���
SELECT d.department_id, d.department_name, d.manager_id, d.location_id,
    (
    SELECT lo.street_address
    FROM locations lo
    WHERE d.location_id = lo.location_id
    ) AS street_address,(
    SELECT lo.postal_code
    FROM locations lo
    WHERE d.location_id = lo.location_id
    )AS postal_code, (
     SELECT lo.city
    FROM locations lo
    WHERE d.location_id = lo.location_id
    ) AS city,(
    SELECT lo.location_id
    FROM locations lo
    WHERE d.location_id = lo.location_id
    )AS location_id
FROM departments d
ORDER BY d.department_id ASC;
   

--���� 10.
--locations���̺� countries ���̺��� left �����ϼ���
--����) �����̼Ǿ��̵�, �ּ�, ��Ƽ, country_id, country_name �� ����մϴ�
--����) country_name���� �������� ����
SELECT lo.location_id, lo.street_address, lo.city, co.country_id, co.country_name
FROM locations lo
LEFT JOIN countries co
ON co.country_id = lo.country_id
ORDER BY co.country_name ASC;

--���� 11.
--���� 10�� ����� (��Į�� ����)�� �����ϰ� ��ȸ�ϼ���
SELECT lo.location_id, lo.street_address, lo.city,

(SELECT
    country_id
FROM countries co
WHERE co.country_id = lo.country_id
) AS country_id,

(SELECT
    country_name
FROM countries co
WHERE co.country_id = lo.country_id
) AS country_name

FROM locations lo
ORDER BY country_name ASC;

--���� 12. 
--employees���̺�, departments���̺��� left���� hire_date�� �������� �������� 1-10��° �����͸� ����մϴ�
--����) rownum�� �����Ͽ� ��ȣ, �������̵�, �̸�, ��ȭ��ȣ, �Ի���, �μ����̵�, �μ��̸� �� ����մϴ�.
--����) hire_date�� �������� �������� ���� �Ǿ�� �մϴ�. rownum�� Ʋ������ �ȵ˴ϴ�.
SELECT e.phone_number, e.employee_id, e.first_name, e.hire_date, e.department_id, d.department_name
FROM
    (SELECT ROWNUM AS rn, tbl.*
     FROM 
    (SELECT  e.hire_date
     FROM employees e
     ORDER BY e.hire_date ASC
   ) tbl
    LEFT JOIN departments d
    ON e.department_id = d.department_id
    ) 
WHERE rn<=10;
-------------------------------�Ʒ� ����------------------------------------
SELECT * FROM
    (
    SELECT ROWNUM AS rn, a.*
    FROM
        (
        SELECT e.phone_number, e.employee_id, e.first_name, e.hire_date, e.department_id, d.department_name
        FROM employees e LEFT JOIN departments d
        ON e.department_id = d.department_id
        ORDER BY hire_date ASC
        ) a 
    )
WHERE rn<=10;

--���� 13. 
----EMPLOYEES �� DEPARTMENTS ���̺��� JOB_ID�� SA_MAN ����� ������ LAST_NAME, JOB_ID, 
--DEPARTMENT_ID,DEPARTMENT_NAME�� ����ϼ���.
SELECT e.last_name
FROM employees e
WHERE e. job_id = 'SA_MAN';

SELECT d.department_name
FROM departments d;

----
SELECT e.last_name, e.job_id,
    (
    SELECT d.department_name
    FROM departments d
    WHERE e.department_id = d.department_id
    )  AS department_name,
    (
    SELECT d.department_id
    FROM departments d
    WHERE e.department_id = d.department_id
    ) AS department_id
FROM employees e
WHERE e.job_id = 'SA_MAN';
----

--���� 14
--DEPARTMENT���̺��� �� �μ��� ID, NAME, MANAGER_ID�� �μ��� ���� �ο����� ����ϼ���.
--�ο��� ���� �������� �����ϼ���.
--����� ���� �μ��� ������� ���� �ʽ��ϴ�.
--INNER JOIN

SELECT COUNT(department_name)
FROM departments;

SELECT  COUNT(d.department_name), e.department_id, e.manager_id, e.employee_id
FROM employees e 
LEFT JOIN departments d 
ON e.department_id = d.department_id group by e.department_id, e.manager_id, e.employee_id
ORDER BY COUNT() DESC;
------------------------------------------------------------------------------------------
SELECT d.department_id, d.department_name, d.manager_id, a.total
FROM departments d
JOIN 
    (
    SELECT department_id, COUNT(*) AS total
    FROM employees
    GROUP BY department_id) a
ON d.department_id = a.department_id
ORDER BY a.total DESC;

--���� 15
--�μ��� ���� ���� ���ο�, �ּ�, �����ȣ, �μ��� ��� ������ ���ؼ� ����ϼ���.
--�μ��� ����� ������ 0���� ����ϼ���.
-------------------------------------------------------------------------------------
SELECT
    d.*, lo.street_address, lo.postal_code, NVL(tbl.result, 0) AS �μ�����ձ޿�
FROM departments d
JOIN locations lo
ON d.location_id = lo.location_id
LEFT JOIN
    (
    SELECT department_id, TRUNC(AVG(salary)) AS result
    FROM employees
    GROUP BY department_id) tbl
ON d.department_id = tbl.department_id;

-------------------------------------------------------------------------------------


SELECT *,
(SELECT street_address, postal_code
FROM locations
), (
SELECT AVG(salary)
FROM employees)
FROM  departments;

--���� 16
--���� 15 ����� ���� DEPARTMENT_ID�������� �������� �����ؼ� ROWNUM�� �ٿ� 1-10������ ������
--����ϼ���.
SELECT * FROM
    (
    SELECT ROWNUM AS rn, tbl2.*
    FROM 
        (
        SELECT
            d.*, lo.street_address, lo.postal_code, NVL(tbl.result, 0) AS �μ�����ձ޿�
        FROM departments d
        JOIN locations lo
        ON d.location_id = lo.location_id
        LEFT JOIN
            (
            SELECT department_id, TRUNC(AVG(salary)) AS result
            FROM employees
            GROUP BY department_id) tbl
        ON d.department_id = tbl.department_id
        ORDER BY d.department_id DESC
        ) tbl2
    )
WHERE rn > 0 AND rn <= 20;