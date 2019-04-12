drop table member;

create table member(
    userid varchar2(100) not null primary key,
    pwd varchar2(100) not null,
    name varchar2(50) not null,
    email varchar2(100),
    hp varchar2(100),
    zipcode varchar2(20),
    address1 varchar2(200),
    address2 varchar2(200),
    join_date date default sysdate
);

desc member;

select * from member;

insert into member(userid, pwd, name, email) values('kim', '1234', '±è±æµ¿', 'kim@kimsmail.com');
insert into member(userid, pwd, name, email) values('user1', '1111', 'À¯Á®1', 'testuser1@user1smail.com');
insert into member(userid, pwd, name, email) values('user2', '2222', 'user2', 'testuser2@user2smail.com');

commit;

select * from member
 where userid = 'kim' and pwd = '1234';

select name from member
 where userid = 'kim' and pwd = '1234';
