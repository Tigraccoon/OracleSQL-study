create table member_bcrypt (
userid varchar2(50) not null primary key,
passwd varchar(64) not null, --varchar2�� �ƴ� varchar�� ����
name varchar2(50) not null,
email varchar2(50),
hp varchar2(50),
zipcode varchar2(7),
address1 varchar2(200),
address2 varchar2(200),
join_date date default sysdate
);


--5. ���̺� �ڷ� �Է�
insert into member_bcrypt (userid,passwd,name) values
('kim','1234','�����');
insert into member_bcrypt (userid,passwd,name) values
('park','1234','�ֺ���');
insert into member_bcrypt (userid,passwd,name) values
('hong','1234','ȫ����');

--6. ȸ������ Ȯ��
select * from member_bcrypt;

--7. �α��� �׽�Ʈ


SELECT * FROM member_bcrypt WHERE userid='kim' AND passwd='1234';


delete from member_bcrypt;

commit;