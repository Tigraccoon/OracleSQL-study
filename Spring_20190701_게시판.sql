-- cascade constraints 제약조건까지 모두 삭제
drop table board cascade constraints;

--게시판 테이블
create table board (
bno number not null, --게시물번호
title varchar2(200) not null, --제목
content clob, --본문
writer varchar2(50) not null, --작성자
regdate date default sysdate, --작성일자
viewcnt number default 0, --조회수
primary key(bno)
);

insert into board (bno,title,content,writer) values
(1,'제목','내용','kim');

select * from board;

commit;


--댓글 테이블
drop table reply cascade constraints;

create table reply (
rno number not null primary key,
bno number default 0,
replytext varchar2(1000) not null,
replyer varchar2(50) not null,
regdate date default sysdate,
updatedate date default sysdate
);
--foreign key 제약조건 추가
alter table reply add constraint fk_board
foreign key(bno) references board(bno);

--시퀀스 생성
drop sequence reply_seq;
create sequence reply_seq
start with 1
increment by 1;

--첨부파일 테이블
--drop table attach cascade constraints;
create table attach (
fullName varchar2(150) not null, --첨부파일 이름
bno number not null, --board 테이블의 글번호
regdate date default sysdate, --업로드 날짜
primary key(fullName) --uuid적용한 파일이름
);

--bno 컬럼에 foreign key 설정
alter table attach add constraint fk_board_attach
foreign key(bno) references board(bno);

commit;

select bno,writer,title,regdate,viewcnt
from board
order by bno desc;

-- writer의 id대신 이름이 나오게 하려면 member테이블과 조인
select bno,title,writer,name,regdate,viewcnt
from board b, member m
where b.writer=m.userid
order by bno desc;

select * from member;

-- board에 시퀀스를 추가
create sequence seq_board
start with 1
increment by 1;

delete from reply;
delete from board;

commit;

select * from attach;

--페이지 나누기 테스트를 위해 레코드 입력
declare --선언부
    i number := 1;
begin --실행부
    while i<=991 loop
        insert into board (bno,title,content,writer)
        values
        ( (select nvl(max(bno)+1,1) from board)
        ,'제목'||i, '내용'||i, 'park');
        i := i+1; --조건 변경
    end loop;
end;
/

select * from board;

--레코드 갯수 확인
select count(*) from board;

commit;

-- from => where => select => order by 절 순서로 실행됨
-- rownum : 레코드의 출력 순번
select *
from (
    select rownum as rn, A.*
    from (
        select bno,title,writer,name,regdate,viewcnt
        from board b, member m
        where b.writer=m.userid
        order by bno desc 
    ) A    
) where rn between 1 and 10;

--------------페이지 나누기 공식 참조-----------------
--11페이지
--	where rn between A and B
--	(현재페이지-1) x 페이지당 게시물수 + 1
--	= (11-1) x 10 + 1 = 101

--11페이지
--	[이전] 11 12 .... 20 [다음]
--
--	몇번째 블록
--	( 현재페이지-1) / 페이지블록단위 + 1
--	(11-1)/10 + 1 => 2번째 블록 ( 몇페이지 ~ 몇페이지 )
--
--  ( 현재블록-1) x 블록단위 + 1
--  (2-1) x 10 + 1 = 11페이지
--게시물 991개 / 10개 => 99.1 => 100페이지
--				100페이지 / 10개 => 페이지블록 10개
                
                
--글쓰기를 하기 위한 시퀀스 삭제
drop sequence seq_board;

--1000번부터 시작하는 시퀀스 생성
create sequence seq_board
start with 1000
increment by 1;
commit;

select * from attach;
select * from reply;

--board 테이블에 필드 추가
alter table board add show char(1) default 'Y';

desc board;

select * from board;

select bno,title,writer,name,regdate,viewcnt
   ,(select count(*) from reply where bno=b.bno) cnt
		, show
from board b, member m
where b.writer=m.userid
		and show='Y'
order by bno desc;

update board set show='N' where bno=1001;--해당게시물 번호로 처리
--위 update문은 실제 데이터가 지워지는건 아니지만 보여지지 않게 처리함.

commit;