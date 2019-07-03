-- spring °èÁ¤¿¡¼­ ½ÇÇà
create table member (
userid varchar2(50) not null primary key,
passwd varchar2(50) not null,
name varchar2(50) not null,
email varchar2(50),
join_date date default sysdate
);

insert into member (userid,passwd,name,email)
values ('kim','1234','±èÃ¶¼ö','kim@gmail.com');
insert into member (userid,passwd,name,email)
values ('park','1234','±èÃ¶¼ö','kim@gmail.com');
select * from member;

select count(*) from member
where userid='kim' and passwd='1234';

select * from member;

commit;
