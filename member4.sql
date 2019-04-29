create table member4(
    id varchar2(100) not null primary key,
    pwd varchar2(100) not null,
    name varchar2(100) not null,
    email varchar2(200),
    tel varchar2(100)
);


insert into member4 values('kim','1234','±èÃ¶¼ö','kim@kim.com','010-1111-1111');
insert into member4 values('park','1234','¹ÚÃ¶¼ö','park@park.com','010-2222-2222');
insert into member4 values('hong','1234','È«Ã¶¼ö','hong@hong.com','010-3333-3333');

select * from member4 where id='kim' and pwd='1234';

commit;
