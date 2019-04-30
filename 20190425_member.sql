drop table member;

create table member(
    userid varchar2(50) not null primary key,
    passwd varchar2(50) not null,
    name varchar2(50) not null,
    email varchar2(100),
    hp varchar2(50),
    zipcode varchar2(10),
    address1 varchar2(300),
    address2 varchar2(300),
    join_date date default sysdate
);

desc member;

select * from member;

insert into member(userid, passwd, name, email) values('kim','1234','��ö��','kim@kim.com');
insert into member(userid, passwd, name, email) values('park','1234','��ö��','park@park.com');
insert into member(userid, passwd, name, email) values('hong','1234','ȫö��','hong@hong.com');

commit;

select name from member where userid='kim' and passwd='1234';

update member set hp='010-1111-1111', zipcode='11111', address1='�����', address2='õȣ��' where userid='kim';
update member set hp='010-2222-2222', zipcode='22222', address1='��⵵', address2='��⵿' where userid='park';
update member set hp='010-3333-3333', zipcode='33333', address1='��õ��', address2='��õ��' where userid='hong';

