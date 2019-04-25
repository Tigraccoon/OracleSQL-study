create table member(
    userid varchar2(50) not null primary key,
    passwd varchar2(50) not null,
    name varchar2(50) not null,
    email varchar2(100),
    hp varchar2(50),
    zipcode varchar2(10),
    address1 varchar2(300),
    address2 varchar2(300),
    join_data date default sysdate
);

desc member;

select * from member;

insert into member(userid, passwd, name, email) values('kim','1234','±èÃ¶¼ö','kim@kim.com');
insert into member(userid, passwd, name, email) values('park','1234','¹ÚÃ¶¼ö','park@park.com');
insert into member(userid, passwd, name, email) values('hong','1234','È«Ã¶¼ö','hong@hong.com');

commit;

select name from member where userid='kim' and passwd='1234';
