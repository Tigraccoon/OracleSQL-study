create table snac(
    co varchar2(50),
    snak varchar2(50),
    price number,
    amo number
);

insert into snac values('ÇØÅÂ','¸Àµ¿»ê',1000,1);
insert into snac values('·Ôµ¥','²É°Ô¶û',1200,3);
insert into snac values('¿ÀÀÌ½Ã','µàº£¸®',1300,5);

commit;

select * from snac;

