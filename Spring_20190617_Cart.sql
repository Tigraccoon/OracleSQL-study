drop table cart cascade constraints;
--��ٱ��� ���̺�
create table cart (
cart_id number not null primary key,
userid varchar2(50) not null,
product_id number not null,
amount number default 0
);

--foreign key ����
--create ����, alter ����, drop ����
--add constraint �������� �̸�
--foreign key(�ʵ��) references ���̺�(�ʵ��)
alter table cart add constraint cart_userid_fk
foreign key(userid) references member(userid);
alter table cart add constraint cart_productid_fk
foreign key(product_id) references product(product_id);

commit;

desc cart;

delete from cart;

select * from cart;

--�������� ����
alter table cart drop constraint cart_productid_fk;


--��ٱ��� �ڵ� �߱��� ���� ������ ����
create sequence cart_seq
start with 1
increment by 1;

insert into cart (cart_id,userid,product_id,amount) values
(cart_seq.nextval,'kim',1,10);

commit;

--��ٱ��� �ݾ� �հ�
--nvl(A,B) A�� null�̸� B, null�� �ƴϸ� A
--����Ŭ SQL
select nvl(sum(price * amount) ,0) money
from product p, cart c --������ ���̺��
where c.product_id=p.product_id --���� ����
and userid='park'; --�Ϲ��� ����

--ANSI SQL(ǥ��SQL) :  ��ǥ=> join, where => on
select nvl(sum(price * amount) ,0) money
from product p join cart c --������ ���̺��
  on c.product_id=p.product_id --���� ����
where userid='park'; --�Ϲ��� ����

