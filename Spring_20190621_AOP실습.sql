drop table tbl_user cascade constraints;

--사용자 정보 테이블
create table tbl_user (
userid varchar2(50) not null,
upw varchar2(50) not null,
uname varchar2(100) not null,
upoint number default 0,
primary key(userid)
);

--메시지 테이블
create table tbl_message (
mid number not null,             --메시지 일련번호
targetid varchar2(50) not null,     --수신자 아이디
sender varchar2(50) not null,      --발신자 아이디
message varchar2(4000) not null,  --메시지 내용
opendate date ,                  --열람시각
senddate date default sysdate,     --발송시각
primary key(mid)
);

--시퀀스 생성
create sequence message_seq
start with 1
increment by 1;

--제약 조건 설정(foreign key 설정)
-- add constraint 제약조건이름
-- foreign key(필드명) references 테이블(필드명)
alter table tbl_message add constraint fk_usertarget
foreign key (targetid) references tbl_user(userid);

alter table tbl_message add constraint fk_usersender
foreign key (sender) references tbl_user(userid);

--사용자 추가
insert into tbl_user (userid, upw, uname ) values ('user00','user00','kim');
insert into tbl_user (userid, upw, uname ) values ('user01','user01','park');
insert into tbl_user (userid, upw, uname ) values ('user02','user02','hong');
insert into tbl_user (userid, upw, uname ) values ('user03','user03','choi');
insert into tbl_user (userid, upw, uname ) values ('user04','user04','lee'); 
select * from tbl_user;

-- user02가 user00에게 메시지를 전송
insert into tbl_message (mid, targetid, sender, message )
values ( message_seq.nextval, 'user00', 'user02', '안녕...');
select * from tbl_message;

--user02에게 포인트 10 추가
update tbl_user set upoint=upoint+10 where userid='user02';
select * from tbl_user;


-- user00의 메시지박스 조회
select * from tbl_message where targetid='user00';

--메시지를 읽은 시각 수정
update tbl_message set opendate=sysdate where mid=1;
select * from tbl_message;

--메시지를 읽으면 5 포인트 증가
update tbl_user set upoint=upoint+5 where userid='user00';
select * from tbl_user;

--트랜잭션
    --글쓰기 + 포인트 10부여
    --글읽기 + 열람시간수정 + 포인트 5부여

--메시지 테이블 초기화
delete from tbl_message;
--사용자 포인트 초기화
update tbl_user set upoint=0;

commit;

select * from tbl_message;

select * from tbl_user;
