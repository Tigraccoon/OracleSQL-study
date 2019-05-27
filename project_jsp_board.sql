--�Խ��� ���̺�

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
content clob not null, --����
ip varchar2(30) not null,	--�ۼ��� ip 
filename varchar2(200),
filesize number default 0, 
down number default 0, --�ٿ�ε� Ƚ��
show char(1) default 'y'    --�Խ��� ��� ����
);

--��� ���̺�
create table board_comment (
comment_num number not null primary key, --��� �Ϸù�ȣ 
board_num number not null references board(num), --Foreign Key 
comment_writer varchar2(50) not null,
comment_content clob not null, --ū������ ó���� �� �ְ� clob�� �ẻ��.
comment_step number not null,		--����� ���� 
comment_level number not null,       --��� �ܰ�
comment_date date default sysdate,
comment_show char(1) default 'y'    --��� ��� ����
);