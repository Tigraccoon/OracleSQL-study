--���� ���̺�
create table guestbook (
idx int not null primary key, --�Խù� �Ϸ� ��ȣ
name varchar2(50) not null, --�̸�
email varchar2(50) not null, --�̸���
passwd varchar2(50) not null, --���������� ���
content varchar2(2000) not null, --����,
--varchar2�� 4000byte�� ��, ������ �̻� �Ѿ�� clob(4GB)�� ����ؾ��� 
-- ex)content clob not null,
post_date date default sysdate --�ۼ��Ͻ�
);

drop sequence guestbook_seq; 
-- �Խù� �Ϸù�ȣ �ο��� ���� ������  ����
create sequence guestbook_seq
start with 1 --1���� ����
increment by 1 --1�� ����
nomaxvalue --������ ����
nocache; --ĳ�� ��� ���� (�⺻���� ��������� �Ǿ�����)
--ĳ���� ����ϸ� ��ȣ�� �߸� �Էµ� �� ����(������ �߿��� ��� nocache��� )
/* cach�ɼ��� ����ϸ� �ӵ��� ������Ű�� ���� sequence ��ȣ�� �ѹ��� 
 *  ���� ���� �޸𸮿� �÷����� �۾��� �Ѵ�. �̷��� ��쿡 DB�� ������Ű�ų� 
 *  ������ off�Ǵ� ��쿡 �޸𸮿� �ִ� ��ȣ�� �����Ǳ� ������ ��ġ�ʴ� ��ȣ�� ������ �� �ִ� */

-- ������.nextval ==> ���� ��ȣ �߱�
-- ���� �׽�Ʈ ���ڵ� �߰�
insert into guestbook (idx, name, email, passwd, content) values
( guestbook_seq.nextval, 'kim', 'kim@daum.net', '1234', 'ù��° �Խù�'); 
-- ���� ����Ʈ
select * from guestbook; 
commit;
--��й�ȣ üũ
select count(*) from guestbook where idx=1 and passwd='123'; 

-- ���� ����/���� ȭ��
select * from GUESTBOOK where idx=1; -- ����
update GUESTBOOK
set name='��̼�', email='kim@naver.com', passwd='2222', content = '...'
where idx=1; 

--����
delete from guestbook where idx=17; 

--��� ���ڵ� ����
delete from guestbook;


--sql�� �׽�Ʈ
SELECT idx,name,email,content,post_date 
			FROM guestbook 
			ORDER BY idx DESC;
