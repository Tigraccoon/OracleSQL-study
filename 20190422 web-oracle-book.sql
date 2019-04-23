create table book(
    id number not null,
    title varchar2(50),
    author varchar2(20),
    price number default 0,
    qty number default 0,
    primary key(id)
);

desc book;

select nvl(max(id)+1,1) from book;

insert into book values((select nvl(max(id)+1,1) from book), 'OS', 'Wiley', 30700, 50);
insert into book values((select nvl(max(id)+1,1) from book), 'Java', 'Sun', 35000, 10);
insert into book values((select nvl(max(id)+1,1) from book), 'C++', 'MS', 40000, 40);
insert into book values((select nvl(max(id)+1,1) from book), 'HTML', '±æ¹þ', 30000, 30);
insert into book values((select nvl(max(id)+1,1) from book), 'Oracle', 'Oracle', 37000, 70);

select * from book;

select * from book where id=5;

commit;

