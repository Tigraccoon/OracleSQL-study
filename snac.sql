create table snac(
    co varchar2(50),
    snak varchar2(50),
    price number,
    amo number
);

insert into snac values('����','������',1000,1);
insert into snac values('�Ե�','�ɰԶ�',1200,3);
insert into snac values('���̽�','�ຣ��',1300,5);

commit;

select * from snac;

