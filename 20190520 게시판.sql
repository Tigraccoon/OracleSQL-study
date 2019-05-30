--LOB(Large OBject)�� TEXT,�׷���,�̹���,����,���� �� ����ȭ���� ���� ���� �����͸� ����� ����Ѵ�.
--CLOB: ���� ���� ��ü (Character). Oracle Server�� CLOB�� VARCHAR2 ���̿� �Ͻ��� ��ȯ�� �����Ѵ�
--BLOB: ���� ���� ��ü (Binary), �̹���, ������, MP3��

drop table board; 

create table board (
num number not null primary key, --�Խù���ȣ 
writer varchar2(50) not null, --�ۼ���
subject varchar2(50) not null, --����
passwd varchar2(60) not null, --����/���� ��� 
reg_date date default sysdate, --�ۼ����� 
readcount number default 0,	--��ȸ��
ref number not null,		--�Խù��׷� 
re_step number not null,		--�Խù��׷��� ���� 
re_level number not null,	--�亯 �ܰ�
content varchar2(4000) not null, --����
ip varchar2(30) not null,	--�ۼ��� ip 
filename varchar2(200),
filesize number default 0, 
down number default 0 --�ٿ�ε� Ƚ��
);

--�ʵ� �߰�
alter table board add show char(1) default 'y';

update board set show='n' where num=3;

select * from board;

insert into board
(num,writer,subject,passwd,ref,re_step,re_level,content,ip) 
values
( (select nvl(max(num)+1,1) from board)
  ,'kim','����','1234'
  ,(select nvl(max(num)+1,1) from board)
  ,1,0,'����','127.0.0.1');

select * from board order by num desc;

commit;
--3�� �Խù��� ÷������ �̸�
select filename
from board
where num=5;

--�ٿ�ε�� ���� ó��
update board set down=down+1 where num=3; 
commit;

--��ȸ�� ���� ó��
update board set readcount=readcount+1 where num=3;

commit;

--1�� �Խù��� ���� ��ȸ
select * from board where num=1;

delete from board; 


--��� ���̺�
-- references ���̺�(�÷�)	Foreign Key(�ܷ�Ű) 
create table board_comment (
comment_num number not null primary key, --��� �Ϸù�ȣ 
board_num number not null references board(num), --Foreign Key 
writer varchar2(50) not null,
content clob not null, --ū������ ó���� �� �ְ� clob�� �ẻ��.
reg_date date default sysdate
);

select * from board_comment;
--1�� �Խù��� ��� �߰�  (���� 100���� ���� ���� ������ �������� ������ foreign key�����߾���)
insert into board_comment
(comment_num,board_num,writer,content) values
((select nvl(max(comment_num)+1,1) from board_comment)
, 1, 'kim', '���...');
--������ insert�غ�

commit;
--1�� �Խù��� ��� ��ȸ 
select * from board_comment where board_num=1
order by comment_num;

delete from board_comment;

--1�� �Խù��� ��� ����
select count(*) from board_comment where board_num=1;

--�ڹٿ��� while�� �������� ���������� ���������� ó��
select num,writer,subject,reg_date,readcount
,filename,filesize,down
,(select count(*) from board_comment 
where board_num=num) comment_count
from board
order by num desc;

--�������� ���
select num,writer,subject,reg_date,readcount
,(select count(*) from board_comment where board_num=b.num) comment_count
,filename,filesize,down ,ref,re_step,re_level from board b
order by ref desc, re_step asc;

--÷������ �̸� ��ȸ
select filename from board where num=134;

--�ٿ�ε� Ƚ�� ���� ó��
update board set down=down+1 where num=150; 
select * from board where num=14;
delete from board;
delete from board_comment;

--��й�ȣ üũ(14�� �Խù��� ��й�ȣ Ȯ��) 
select passwd from board
where num=14 and passwd='1234';

--14�� �Խù� ���� 
update board
set  writer='kim', subject='����...', content='	'
where num=1;
select * from board where num=11;

--affected rows : ������ ���� ���� ��
--	insert,delete,update

--�˻�
select * from board where writer like '%kim%'; 
select * from board where subject like '%kim%'; 
select * from board where content like '%kim%';
select * from board
where writer like '%kim%' or content like '%park%';

--�̸�+����+���� 
select * from board
where writer like 'kim%' or subject like 'kim%' or content like 'kim%';

--union(������)
select * from board where writer like 'kim%' union
select * from board where subject like 'kim%' union
select * from board where content like 'kim%';

--�Խù� ���
select num,writer,subject,reg_date,readcount
,(select count(*) from board_comment 
where board_num=b.num) comment_count
,filename,filesize,down ,ref,re_step,re_level from board b
order by ref desc, re_step asc;

--�Խù� ��� ������ ������ 
select * from (
select rownum as rn, A.* from (
select num,writer,subject,reg_date,readcount
,(select count(*) from board_comment where board_num=b.num) comment_count
,filename,filesize,down ,ref,re_step,re_level from board b
order by ref desc, re_step asc) A
) where rn between 1 and 10;

--��ü ���ڵ�  ī��Ʈ 
select count(*) from board;

--�˻��� ���ڵ� ī��Ʈ
select count(*) from board where writer like '%kim%';

rollback; 
commit;


--sql check
SELECT num, writer, subject, reg_date, readcount,filename,filesize,down 
			FROM board 
			ORDER BY num desc;
            
 SELECT *
			FROM (
 		 	select A.*, rownum as rn 
			from (
      			select num,writer,subject,reg_date,readcount,filename,filesize,down
			,(select count(*) from board_comment where board_num=num) comment_count
      				from board
      				order by num DESC
  				) A
			)
		where rn between 3 and 10;

