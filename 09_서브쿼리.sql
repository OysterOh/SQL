/*
# 서브 쿼리
- 서브쿼리의 사용방법은 ()안에 명시한다
- 서브쿼리절의 리턴행이 1줄 이하여야한다
- 서브쿼리절에는 비교할 대상이 하나 반드시 들어가야 한다
- 해석할 때는 서브쿼리절부터 먼저 해석한다
*/

--'Nancy'의 급여보다 급여가 많은 사람을 검색하는 문장
SELECT salary
FROM employees
WHERE first_name = 'Nancy'; --12008

SELECT * FROM employees
WHERE salary > (SELECT salary
                FROM employees
                WHERE first_name = 'Nancy');