-- cascade constraints �������Ǳ��� ��� ����
drop table board cascade constraints;

--�Խ��� ���̺�
create table board (
bno number not null, --�Խù���ȣ
title varchar2(200) not null, --����
content clob, --����
writer varchar2(50) not null, --�ۼ���
regdate date default sysdate, --�ۼ�����
viewcnt number default 0, --��ȸ��
primary key(bno)
);

insert into board (bno,title,content,writer) values
(1,'����','����','kim');

select * from board;

commit;


--��� ���̺�
drop table reply cascade constraints;

create table reply (
rno number not null primary key,
bno number default 0,
replytext varchar2(1000) not null,
replyer varchar2(50) not null,
regdate date default sysdate,
updatedate date default sysdate
);
--foreign key �������� �߰�
alter table reply add constraint fk_board
foreign key(bno) references board(bno);

--������ ����
drop sequence reply_seq;
create sequence reply_seq
start with 1
increment by 1;

--÷������ ���̺�
--drop table attach cascade constraints;
create table attach (
fullName varchar2(150) not null, --÷������ �̸�
bno number not null, --board ���̺��� �۹�ȣ
regdate date default sysdate, --���ε� ��¥
primary key(fullName) --uuid������ �����̸�
);

--bno �÷��� foreign key ����
alter table attach add constraint fk_board_attach
foreign key(bno) references board(bno);

commit;

select bno,writer,title,regdate,viewcnt
from board
order by bno desc;

-- writer�� id��� �̸��� ������ �Ϸ��� member���̺�� ����
select bno,title,writer,name,regdate,viewcnt
from board b, member m
where b.writer=m.userid
order by bno desc;

select * from member;

-- board�� �������� �߰�
create sequence seq_board
start with 1
increment by 1;

delete from reply;
delete from board;

commit;

select * from attach;

--������ ������ �׽�Ʈ�� ���� ���ڵ� �Է�
declare --�����
    i number := 1;
begin --�����
    while i<=991 loop
        insert into board (bno,title,content,writer)
        values
        ( (select nvl(max(bno)+1,1) from board)
        ,'����'||i, '����'||i, 'park');
        i := i+1; --���� ����
    end loop;
end;
/

select * from board;

--���ڵ� ���� Ȯ��
select count(*) from board;

commit;

-- from => where => select => order by �� ������ �����
-- rownum : ���ڵ��� ��� ����
select *
from (
    select rownum as rn, A.*
    from (
        select bno,title,writer,name,regdate,viewcnt
        from board b, member m
        where b.writer=m.userid
        order by bno desc 
    ) A    
) where rn between 1 and 10;

--------------������ ������ ���� ����-----------------
--11������
--	where rn between A and B
--	(����������-1) x �������� �Խù��� + 1
--	= (11-1) x 10 + 1 = 101

--11������
--	[����] 11 12 .... 20 [����]
--
--	���° ���
--	( ����������-1) / ��������ϴ��� + 1
--	(11-1)/10 + 1 => 2��° ��� ( �������� ~ �������� )
--
--  ( ������-1) x ��ϴ��� + 1
--  (2-1) x 10 + 1 = 11������
--�Խù� 991�� / 10�� => 99.1 => 100������
--				100������ / 10�� => ��������� 10��
                
                
--�۾��⸦ �ϱ� ���� ������ ����
drop sequence seq_board;

--1000������ �����ϴ� ������ ����
create sequence seq_board
start with 1000
increment by 1;
commit;

select * from attach;
select * from reply;

--board ���̺� �ʵ� �߰�
alter table board add show char(1) default 'Y';

desc board;

select * from board;

select bno,title,writer,name,regdate,viewcnt
   ,(select count(*) from reply where bno=b.bno) cnt
		, show
from board b, member m
where b.writer=m.userid
		and show='Y'
order by bno desc;

update board set show='N' where bno=1001;--�ش�Խù� ��ȣ�� ó��
--�� update���� ���� �����Ͱ� �������°� �ƴ����� �������� �ʰ� ó����.

commit;