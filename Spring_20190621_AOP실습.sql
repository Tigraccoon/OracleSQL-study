drop table tbl_user cascade constraints;

--����� ���� ���̺�
create table tbl_user (
userid varchar2(50) not null,
upw varchar2(50) not null,
uname varchar2(100) not null,
upoint number default 0,
primary key(userid)
);

--�޽��� ���̺�
create table tbl_message (
mid number not null,             --�޽��� �Ϸù�ȣ
targetid varchar2(50) not null,     --������ ���̵�
sender varchar2(50) not null,      --�߽��� ���̵�
message varchar2(4000) not null,  --�޽��� ����
opendate date ,                  --�����ð�
senddate date default sysdate,     --�߼۽ð�
primary key(mid)
);

--������ ����
create sequence message_seq
start with 1
increment by 1;

--���� ���� ����(foreign key ����)
-- add constraint ���������̸�
-- foreign key(�ʵ��) references ���̺�(�ʵ��)
alter table tbl_message add constraint fk_usertarget
foreign key (targetid) references tbl_user(userid);

alter table tbl_message add constraint fk_usersender
foreign key (sender) references tbl_user(userid);

--����� �߰�
insert into tbl_user (userid, upw, uname ) values ('user00','user00','kim');
insert into tbl_user (userid, upw, uname ) values ('user01','user01','park');
insert into tbl_user (userid, upw, uname ) values ('user02','user02','hong');
insert into tbl_user (userid, upw, uname ) values ('user03','user03','choi');
insert into tbl_user (userid, upw, uname ) values ('user04','user04','lee'); 
select * from tbl_user;

-- user02�� user00���� �޽����� ����
insert into tbl_message (mid, targetid, sender, message )
values ( message_seq.nextval, 'user00', 'user02', '�ȳ�...');
select * from tbl_message;

--user02���� ����Ʈ 10 �߰�
update tbl_user set upoint=upoint+10 where userid='user02';
select * from tbl_user;


-- user00�� �޽����ڽ� ��ȸ
select * from tbl_message where targetid='user00';

--�޽����� ���� �ð� ����
update tbl_message set opendate=sysdate where mid=1;
select * from tbl_message;

--�޽����� ������ 5 ����Ʈ ����
update tbl_user set upoint=upoint+5 where userid='user00';
select * from tbl_user;

--Ʈ�����
    --�۾��� + ����Ʈ 10�ο�
    --���б� + �����ð����� + ����Ʈ 5�ο�

--�޽��� ���̺� �ʱ�ȭ
delete from tbl_message;
--����� ����Ʈ �ʱ�ȭ
update tbl_user set upoint=0;

commit;

select * from tbl_message;

select * from tbl_user;
