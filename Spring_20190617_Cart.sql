drop table cart cascade constraints;
--장바구니 테이블
create table cart (
cart_id number not null primary key,
userid varchar2(50) not null,
product_id number not null,
amount number default 0
);

--foreign key 설정
--create 생성, alter 변경, drop 제거
--add constraint 제약조건 이름
--foreign key(필드명) references 테이블(필드명)
alter table cart add constraint cart_userid_fk
foreign key(userid) references member(userid);
alter table cart add constraint cart_productid_fk
foreign key(product_id) references product(product_id);

commit;

desc cart;

delete from cart;

select * from cart;

--제약조건 삭제
alter table cart drop constraint cart_productid_fk;


--장바구니 코드 발급을 위한 시퀀스 생성
create sequence cart_seq
start with 1
increment by 1;

insert into cart (cart_id,userid,product_id,amount) values
(cart_seq.nextval,'kim',1,10);

commit;

--장바구니 금액 합계
--nvl(A,B) A가 null이면 B, null이 아니면 A
--오라클 SQL
select nvl(sum(price * amount) ,0) money
from product p, cart c --조인할 테이블들
where c.product_id=p.product_id --조인 조건
and userid='park'; --일반적 조건

--ANSI SQL(표준SQL) :  쉼표=> join, where => on
select nvl(sum(price * amount) ,0) money
from product p join cart c --조인할 테이블들
  on c.product_id=p.product_id --조인 조건
where userid='park'; --일반적 조건

