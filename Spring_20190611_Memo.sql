drop table memo;

create table memo (
idx number not null primary key,
writer varchar2(50) not null,
memo clob,
post_date date default sysdate
);

insert into memo (idx,writer,memo) values (1,'kim','ù��° �޸�');
insert into memo (idx,writer,memo) values (2,'park','�ι�° �޸�');

select * from memo;
commit;
-------------------------------------------------------------------------------
delete from memo;
-- nvl(A,B) A�� null�̸� B
select nvl(max(idx)+1,1) from memo;

insert into memo (idx,writer,memo) values
((select nvl(max(idx)+1,1) from memo),'park','�޸�');

select * from memo order by idx desc;

select * from memo
where idx=47;
--�̸����� �˻�
select * from memo
where writer like '%ö%';
--�޸� �������� �˻�
select * from memo
where memo like '%����%';
--�̸�+�޸� �������� �˻�
select * from memo
where writer like '%ö��%' or memo like '%ö��%';
--�̸�+�޸� �������� �˻�(������)
select * from memo

where writer like '%ö��%'
union
select * from memo
where memo like '%ö��%';


delete from memo;
commit;
