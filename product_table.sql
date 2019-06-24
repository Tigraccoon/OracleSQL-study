create table product (
product_id number,
product_name varchar2(50),
price number default 0,
description clob,
picture_url varchar2(500),
primary key(product_id)
);

insert into product values (1,'����',1500,'���� ���Ե� �������� �Ƿ�ȸ���� ��
���ϴ�. ��Ÿ�� C�� ǳ���մϴ�.','lemon.jpg');
insert into product values (2,'������',2000,'��Ÿ�� C�� ǳ���մϴ�. ������ �ֽ�
�� ���ø� �����ϴ�.','orange.jpg');
insert into product values (3,'Ű��',3000,'��Ÿ�� C�� �ſ� ǳ���մϴ�. ���̾�Ʈ
�� �̿뿡 �����ϴ�.','kiwi.jpg'); 
insert into product values (4,'����',5000,'��������� �ٷ� �����ϰ� �־� �׻�ȭ
�ۿ��� �մϴ�.','grape.jpg');
insert into product values (5,'����',8000,'��Ÿ�� C�� �ö󺸳��̵带 �ٷ� ����
�ϰ� �ֽ��ϴ�.','strawberry.jpg');
insert into product values (6,'��',7000,'�ó��Ǹ��� �����ϰ� �־� ���� ���濡
���ٰ� �մϴ�.','tangerine.jpg');

select * from product;
commit;

--������ ����
create sequence seq_product
start with 10
increment by 1;

insert into product values
(seq_product.nextval,'���',1500,'���ִ� �������','apple.jpg');

commit;


--��ǰ�� ��ٱ��� �ݾ� ���
select product_name, sum(price*amount) money
from cart c, product p --������ ���̺�
where c.product_id=p.product_id -- ���� ����
group by product_name --���� ���� �ʵ�
order by product_name;
