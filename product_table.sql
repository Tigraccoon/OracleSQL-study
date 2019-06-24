create table product (
product_id number,
product_name varchar2(50),
price number default 0,
description clob,
picture_url varchar2(500),
primary key(product_id)
);

insert into product values (1,'레몬',1500,'레몬에 포함된 구연산은 피로회복에 좋
습니다. 비타민 C도 풍부합니다.','lemon.jpg');
insert into product values (2,'오렌지',2000,'비타민 C가 풍부합니다. 생과일 주스
로 마시면 좋습니다.','orange.jpg');
insert into product values (3,'키위',3000,'비타민 C가 매우 풍부합니다. 다이어트
나 미용에 좋습니다.','kiwi.jpg'); 
insert into product values (4,'포도',5000,'폴리페놀을 다량 함유하고 있어 항산화
작용을 합니다.','grape.jpg');
insert into product values (5,'딸기',8000,'비타민 C나 플라보노이드를 다량 함유
하고 있습니다.','strawberry.jpg');
insert into product values (6,'귤',7000,'시네피린을 함유하고 있어 감기 예방에
좋다고 합니다.','tangerine.jpg');

select * from product;
commit;

--시퀀스 생성
create sequence seq_product
start with 10
increment by 1;

insert into product values
(seq_product.nextval,'사과',1500,'맛있는 사과예요','apple.jpg');

commit;


--상품별 장바구니 금액 통계
select product_name, sum(price*amount) money
from cart c, product p --조인할 테이블
where c.product_id=p.product_id -- 조인 조건
group by product_name --집계 기준 필드
order by product_name;
