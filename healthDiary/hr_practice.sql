CREATE TABLE member (
    member_number	NUMBER(10) PRIMARY KEY NOT NULL,
    member_name VARCHAR2(20) NOT NULL,
    phone_number VARCHAR(20) NOT NULL,
    grade VARCHAR2(10) DEFAULT 'BRONZE' NOT NULL,
    reg_date DATE DEFAULT sysdate NOT NULL,
    in_room	VARCHAR2(5)	DEFAULT 'false' NOT NULL
);

DROP TABLE member;

SELECT * FROM exercise;


CREATE TABLE exercise (
	exe_num	NUMBER(10)		NOT NULL,
	exe_name	VARCHAR2(30)		NOT NULL,
	exe_measure	VARCHAR2(20)		NULL
);

CREATE TABLE record (
	record_num	NUMBER(10)	NOT NULL PRIMARY KEY,
	member_number	NUMBER(10)	NOT NULL,
	exe_num	NUMBER(10)	NOT NULL,
	record_score NUMBER(10)	NOT NULL,
	exe_level	NUMBER(10)	NOT NULL,
	record_day DATE DEFAULT sysdate	NULL
);


SELECT * FROM member;
SELECT * FROM exercise;
SELECT * FROM record;
DROP TABLE exercise;

CREATE SEQUENCE member_seq
    START WITH 1
    MAXVALUE 10000;

CREATE SEQUENCE exercise_seq
    START WITH 1
    MAXVALUE 10000;

CREATE SEQUENCE record_seq
    START WITH 1
    MAXVALUE 10000;

DROP SEQUENCE exercise_seq;

INSERT INTO exercise
VALUES (exercise_seq.NEXTVAL, '스쿼트', 'C');
INSERT INTO exercise
VALUES (exercise_seq.NEXTVAL, '러닝머신', 'S');
INSERT INTO exercise
VALUES (exercise_seq.NEXTVAL,'푸시업', 'C');
INSERT INTO exercise
VALUES (exercise_seq.NEXTVAL,'벤치 프레스', 'C');
INSERT INTO exercise
VALUES (exercise_seq.NEXTVAL,'밀리터리 프레스','C');
INSERT INTO exercise
VALUES (exercise_seq.NEXTVAL, '자전거', 'S');
INSERT INTO exercise
VALUES (exercise_seq.NEXTVAL,'데드리프트','C');
INSERT INTO exercise
VALUES (exercise_seq.NEXTVAL, '천국의 계단','S');
INSERT INTO exercise
VALUES (exercise_seq.NEXTVAL,'해머 컬','C');
INSERT INTO exercise
VALUES (exercise_seq.NEXTVAL,'윗몸 일으키기','C');
commit;
SELECT * FROM exercise;
DELETE FROM exercise;