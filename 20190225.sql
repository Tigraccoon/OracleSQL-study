--실습 문제

 create table test_member(
 id number primary key,
 name varchar2(50) not null,
 pay number, 
 email varchar2(50)
 );
 
 create sequence test_member_seq 
 start with 100 
 increment by 1 
 maxvalue 1000 
 nocache 
 nocycle;
 
 insert into test_member values(nvl(test_member_seq.nextval,0),'kim',4500,'kim@gmail.com');
 insert into test_member values(nvl(test_member_seq.nextval,0),'lee',5000,'lee@naver.com');
 insert into test_member values(nvl(test_member_seq.nextval,0),'park',6000,'park@daum.net');

 select * from test_member;