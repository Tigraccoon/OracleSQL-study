create table member2(
    userid varchar2(50) not null primary key,
    pwd varchar2(50) not null,
    name varchar2(50) not null,
    email varchar2(100),
    hp varchar2(50),
    zipcode varchar2(10),
    address1 varchar2(300),
    address2 varchar2(300),
    join_date date default sysdate,
    login_date date
);

drop table member2;

insert into member2(userid, pwd, name, email) values('kim','1234','±èÃ¶¼ö','kim@kim.com');
insert into member2(userid, pwd, name, email) values('park','1234','¹ÚÃ¶¼ö','park@park.com');
insert into member2(userid, pwd, name, email) values('hong','1234','È«Ã¶¼ö','hong@hong.com');

commit;

select * from member2 where userid='kim' and pwd='1234';

