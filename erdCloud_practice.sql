CREATE TABLE "members" (
	"id"	VARCHAR2(20)		NOT NULL,
	"name"	VARCHAR2(20)		NOT NULL,
	"reg_date"	DATE	DEFAULT sysdate	NOT NULL
);

COMMENT ON COLUMN "members"."id" IS '아이디가 들어갈 컬럼이다';

COMMENT ON COLUMN "members"."name" IS '회원의 이름';

COMMENT ON COLUMN "members"."reg_date" IS '가입일에 대한 정보';

CREATE TABLE "board" (
	"bno"	NUMBER(10)		NOT NULL,
	"title"	VARCHAR2(100)		NOT NULL,
	"content"	VARCHAR2(2000)		NULL,
	"writer"	VARCHAR2(20)		NOT NULL
);

COMMENT ON COLUMN "board"."bno" IS '글 번호.
Auto Increment';

COMMENT ON COLUMN "board"."title" IS '글 제목.';

COMMENT ON COLUMN "board"."content" IS '글 내용.';

COMMENT ON COLUMN "board"."writer" IS '아이디가 들어갈 컬럼이다.
회원 아이디를 통해 작성자를 판별합니다.';

CREATE TABLE "reply" (
	"rno"	NUMBER(10)		NOT NULL,
	"reply_content"	VARCHAR2(500)		NOT NULL,
	"bno"	NUMBER(10)		NOT NULL,
	"writer"	VARCHAR2(20)		NOT NULL
);

COMMENT ON COLUMN "reply"."rno" IS '댓글 번호.';

COMMENT ON COLUMN "reply"."reply_content" IS '댓글 내용';

COMMENT ON COLUMN "reply"."bno" IS '글 번호.
Auto Increment';

COMMENT ON COLUMN "reply"."writer" IS '아이디가 들어갈 컬럼이다';

ALTER TABLE "members" ADD CONSTRAINT "PK_MEMBERS" PRIMARY KEY (
	"id"
);

ALTER TABLE "board" ADD CONSTRAINT "PK_BOARD" PRIMARY KEY (
	"bno"
);

ALTER TABLE "reply" ADD CONSTRAINT "PK_REPLY" PRIMARY KEY (
	"rno"
);

