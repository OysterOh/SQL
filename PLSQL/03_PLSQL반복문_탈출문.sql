
-- WHILE문

DECLARE
    v_num NUMBER := 3;
    v_count NUMBER := 1;
BEGIN
    WHILE v_count <= 10
    LOOP
        dbms_output.put_line(v_num);
        v_count := v_count + 1;
    END LOOP;
END;


-- 탈출문

DECLARE
    v_num NUMBER := 3;
    v_count NUMBER := 1;
BEGIN
    WHILE v_count <= 10
    LOOP
        dbms_output.put_line(v_num);
        EXIT WHEN v_count = 5;    --
        v_count := v_count + 1;
        -- count++; 여기선 안됨
    END LOOP;
END;

-- FOR문
DECLARE
    v_num NUMBER := 3;
BEGIN
    FOR i IN 1..9  -- .을 두개 작성해서 범위를 표현
    -- A..B = A~B
    LOOP
        dbms_output.put_line(v_num || 'x' || i || '=' || v_num*i);
    END LOOP;
END;        

-- CONTINUE
DECLARE
    v_num NUMBER := 3;
BEGIN
    FOR i IN 1..9  -- .을 두개 작성해서 범위를 표현
    LOOP
        CONTINUE WHEN i = 5;
        dbms_output.put_line(v_num || 'x' || i || '=' || v_num*i);
    END LOOP;
END;       

-- 1. 모든 구구단을 출력하는 익명 블록을 만든다 (2~9단)
-- 중첩 for문
DECLARE
    A NUMBER :=2;
    B NUMBER :=1;
BEGIN 
    FOR A IN 2..9
    LOOP 
        FOR B IN 1..9
        LOOP
        dbms_output.put_line(A || 'x' || B || '=' || A*B);
        END LOOP;
        dbms_output.put_line('======');
     END LOOP;
END;

-- 2. INSERT를 300번 실행하는 익명 블록
-- board라는 이름의 테이블 생성 (bno, writer, title컬럼 존재)
-- bno는 SEQUENCE로 올리고, writer,title에 번호를 붙여 INSERT한다.
-- ex) 1, test1, title1 -> 2, test2, title2 -> 3, test3, tilte3 ...
CREATE TABLE board(
    bno NUMBER(50),   --boardNumber
    writer VARCHAR2(50),
    title VARCHAR2(50)
);

SELECT * FROM board;

CREATE SEQUENCE bno
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 10000
    NOCYCLE
    NOCACHE;

--DECLARE
--    bno VARCHAR2(50); writer VARCHAR2(50); title VARCHAR2(50);
--BEGIN
--    FOR bno IN 1..300
--    LOOP 
----     dbms_output.put_line(bno||' '|| writer||' '||title);
--     dbms_output.put_line(bno||', '||'test' ||bno||', '||'title'|| bno);
--     END LOOP;
--END;

DECLARE
    v_num NUMBER :=1;
BEGIN
    WHILE v_num <= 300
    LOOP
        INSERT INTO board
        VALUES(bno.NEXTVAL, 'test'||v_num, 'title'||v_num);
        v_num := v_num +1;
    END LOOP;
    COMMIT;
END;

SELECT * FROM board
ORDER BY bno DESC;