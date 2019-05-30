--LOB(Large OBject)은 TEXT,그래픽,이미지,비디오,사운드 등 구조화되지 않은 대형 데이터를 저장시 사용한다.
--CLOB: 문자 대형 객체 (Character). Oracle Server는 CLOB과 VARCHAR2 사이에 암시적 변환을 수행한다
--BLOB: 이진 대형 객체 (Binary), 이미지, 동영상, MP3등

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
content varchar2(4000) not null, --본문
ip varchar2(30) not null,	--작성자 ip 
filename varchar2(200),
filesize number default 0, 
down number default 0 --다운로드 횟수
);

--필드 추가
alter table board add show char(1) default 'y';

update board set show='n' where num=3;

select * from board;

insert into board
(num,writer,subject,passwd,ref,re_step,re_level,content,ip) 
values
( (select nvl(max(num)+1,1) from board)
  ,'kim','제목','1234'
  ,(select nvl(max(num)+1,1) from board)
  ,1,0,'내용','127.0.0.1');

select * from board order by num desc;

commit;
--3번 게시물의 첨부파일 이름
select filename
from board
where num=5;

--다운로드수 증가 처리
update board set down=down+1 where num=3; 
commit;

--조회수 증가 처리
update board set readcount=readcount+1 where num=3;

commit;

--1번 게시물에 대한 조회
select * from board where num=1;

delete from board; 


--댓글 테이블
-- references 테이블(컬럼)	Foreign Key(외래키) 
create table board_comment (
comment_num number not null primary key, --댓글 일련번호 
board_num number not null references board(num), --Foreign Key 
writer varchar2(50) not null,
content clob not null, --큰내용을 처리할 수 있게 clob을 써본다.
reg_date date default sysdate
);

select * from board_comment;
--1번 게시물에 댓글 추가  (만약 100번에 대한 글이 없으면 에러나기 때문에 foreign key설정했었음)
insert into board_comment
(comment_num,board_num,writer,content) values
((select nvl(max(comment_num)+1,1) from board_comment)
, 1, 'kim', '댓글...');
--여러번 insert해봄

commit;
--1번 게시물의 댓글 조회 
select * from board_comment where board_num=1
order by comment_num;

delete from board_comment;

--1번 게시물의 댓글 갯수
select count(*) from board_comment where board_num=1;

--자바에서 while문 쓰지말고 쿼리문에서 서브쿼리로 처리
select num,writer,subject,reg_date,readcount
,filename,filesize,down
,(select count(*) from board_comment 
where board_num=num) comment_count
from board
order by num desc;

--서브쿼리 사용
select num,writer,subject,reg_date,readcount
,(select count(*) from board_comment where board_num=b.num) comment_count
,filename,filesize,down ,ref,re_step,re_level from board b
order by ref desc, re_step asc;

--첨부파일 이름 조회
select filename from board where num=134;

--다운로드 횟수 증가 처리
update board set down=down+1 where num=150; 
select * from board where num=14;
delete from board;
delete from board_comment;

--비밀번호 체크(14번 게시물의 비밀번호 확인) 
select passwd from board
where num=14 and passwd='1234';

--14번 게시물 수정 
update board
set  writer='kim', subject='제목...', content='	'
where num=1;
select * from board where num=11;

--affected rows : 영향을 받은 행의 수
--	insert,delete,update

--검색
select * from board where writer like '%kim%'; 
select * from board where subject like '%kim%'; 
select * from board where content like '%kim%';
select * from board
where writer like '%kim%' or content like '%park%';

--이름+제목+내용 
select * from board
where writer like 'kim%' or subject like 'kim%' or content like 'kim%';

--union(합집합)
select * from board where writer like 'kim%' union
select * from board where subject like 'kim%' union
select * from board where content like 'kim%';

--게시물 목록
select num,writer,subject,reg_date,readcount
,(select count(*) from board_comment 
where board_num=b.num) comment_count
,filename,filesize,down ,ref,re_step,re_level from board b
order by ref desc, re_step asc;

--게시물 목록 페이지 나누기 
select * from (
select rownum as rn, A.* from (
select num,writer,subject,reg_date,readcount
,(select count(*) from board_comment where board_num=b.num) comment_count
,filename,filesize,down ,ref,re_step,re_level from board b
order by ref desc, re_step asc) A
) where rn between 1 and 10;

--전체 레코드  카운트 
select count(*) from board;

--검색된 레코드 카운트
select count(*) from board where writer like '%kim%';

rollback; 
commit;


--sql check
SELECT num, writer, subject, reg_date, readcount,filename,filesize,down 
			FROM board 
			ORDER BY num desc;
            
 SELECT *
			FROM (
 		 	select A.*, rownum as rn 
			from (
      			select num,writer,subject,reg_date,readcount,filename,filesize,down
			,(select count(*) from board_comment where board_num=num) comment_count
      				from board
      				order by num DESC
  				) A
			)
		where rn between 3 and 10;

