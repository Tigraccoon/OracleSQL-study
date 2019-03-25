create table event(
fileName varchar2(2000),     --파일명
fileRealName varchar2(2000), --원본파일명
name varchar2(500),          --이름
phoneNum varchar2(500),      --핸드폰번호
email varchar2(1000)         --이메일주소
);

select * from event;
desc event;
drop table event;

commit;