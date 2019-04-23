create table homework(
    id varchar2(30) not null primary key,
    name varchar2(50) not null,
    email varchar2(100) not null,
    hp varchar2(40) not null,
    in_date date default sysdate
);

desc homework;

insert into homework(id, name, email, hp) values('abc', 'ȫ�浿', 'abc@abc.com', '010-111-1234');
insert into homework(id, name, email, hp) values('aaa', '��ö��', 'aaa@abc.com', '010-222-1234');
insert into homework(id, name, email, hp) values('bbb', '�̼���', 'bbb@abc.com', '010-333-1234');

select * from homework;

commit;
