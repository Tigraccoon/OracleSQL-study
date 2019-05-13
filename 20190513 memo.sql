select * from memo;

drop table memo;

--���� �޸��� ���̺�
create table memo (
idx number not null primary key,
writer varchar2(50) not null,
memo varchar2(300) not null,
post_date date default sysdate
);

-- �޸� �߰�
insert into memo(idx, writer, memo)
values (1, 'kim', 'ù��° �޸�');
insert into memo(idx, writer, memo)
values (2, 'park', '�ι�° �޸�');

commit;

delete from memo;
-- �۹�ȣ �ڵ����(��������)
select max(idx)+1 from memo; -- �Խù��� �ϳ��� ���� ���� null 
-- nvl( A, B ) A�� ���� null�� �� ==> B
select nvl( max(idx)+1, 1) from memo;

-- �۹�ȣ �ڵ������ insert�� ���� select���� ó��(����������)
insert into memo ( idx, writer, memo )
values ( (select nvl( max(idx)+1, 1) from memo), 'park', '�޸�'); 

--�޸� ����
delete from memo where idx=4;

--1�� �Խù� ����
select * from memo where idx=1;
--�Խù� ����
update memo set writer='kim', memo='memo1' where idx=1;

-- �Խù� ����
delete from memo where idx=9; 

-- �Խù� ���� ���
select count(*) from memo; 

-- �Խù� �˻�
select * from memo

where memo like '%�ȳ�%';
--where writer like '%%'; --��� ���ڵ尡 ��ȸ��
--where writer like '%ȫ%'; -- �̸��� 'ȫ'�ڰ� ���� ��� ���ڵ�

-- �̸� + �޸�� �˻�
select * from memo
where writer like '%�޸�%' or memo like '%�޸�%';

commit;

--�������� ã��
 
 SELECT idx, writer, memo, tochar(post_date,'yyyy-<<-dd hh24:mi:ss') post_date 
 from memo 
 where memo like '%�޸�%'
 order by idx desc;
 
 
 --insert
 --    insert into memo ( idx, writer, memo ) values 
 --   ( (select nvl( max(idx)+1, 1) from memo)
 --   , #{writer}, #{memo}) 

 --SELECT
 --   SELECT idx,writer,memo,to_char(post_date,'yyyy-mm-dd hh24:mi:ss') post_date 
 -- 	FROM memo 
 --		WHERE ${searchkey} like '%'||#{search}||'%'  
 --		ORDER BY idx DESC
