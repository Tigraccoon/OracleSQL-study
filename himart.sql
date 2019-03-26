create table himart(
 location varchar2(100),  --지점
 name varchar2(100),      --품명
 code varchar2(1000),      --제품코드
 price number,       --단가
 amount number,      --수량
 val number,         --부가세 물품가액
 tax number,         --세금
 tot number,         --총액
 chk varchar2(1000)      --과세여부
);

select * from himart;
desc himart;
drop table himart;

commit;