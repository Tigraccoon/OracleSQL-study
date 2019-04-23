create table memo(
    idx number not null primary key,   -- �۹�ȣ
    writer varchar2(50) not null,           -- �ۼ���
    memo varchar2(4000) not null,       -- ����
    post_date date default sysdate       -- ��¥
);

desc memo;

insert into memo(idx, writer, memo) values(1, 'kim', '�޸�~');
insert into memo(idx, writer, memo) values(2, 'hong', '�޸�~!');
insert into memo(idx, writer, memo) values(3, 'park', '�޸�~~!');

select * from memo;

commit;