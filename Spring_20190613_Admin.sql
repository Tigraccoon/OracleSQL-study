--������ ���̺�
drop table admin cascade constraints;

create table admin (
userid varchar2(50) not null,
passwd varchar2(50) not null,
name varchar2(50) not null,
email varchar2(100),
join_date date default sysdate,
primary key(userid)
);

insert into admin (userid, passwd, name ) values ('admin','admin','������');

delete from admin;

select * from admin;

commit;

--�α��� ����
select name from admin
where userid='admin' and passwd='1234';
--�α��� ����
select name from admin
where userid='admin' and passwd='2222';
