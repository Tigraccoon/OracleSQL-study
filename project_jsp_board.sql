--게시판 테이블

drop table board; 

create table board (
num number not null primary key, --게시물번호 
writer varchar2(50) not null, --작성자
subject varchar2(50) not null, --제목
passwd varchar2(60) not null, --수정/삭제 비번 
reg_date date default sysdate, --작성일자 
readcount number default 0,	--조회수
ref number not null,		--게시물그룹 
re_step number not null,		--게시물그룹의 순번 
re_level number not null,	--답변 단계
content clob not null, --본문
ip varchar2(30) not null,	--작성자 ip 
filename varchar2(200),
filesize number default 0, 
down number default 0, --다운로드 횟수
show char(1) default 'y'    --게시판 출력 여부
);

--댓글 테이블
create table board_comment (
comment_num number not null primary key, --댓글 일련번호 
board_num number not null references board(num), --Foreign Key 
comment_writer varchar2(50) not null,
comment_content clob not null, --큰내용을 처리할 수 있게 clob을 써본다.
comment_step number not null,		--댓글의 순번 
comment_level number not null,       --댓글 단계
comment_date date default sysdate,
comment_show char(1) default 'y'    --댓글 출력 여부
);