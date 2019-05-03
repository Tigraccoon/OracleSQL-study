create table member_bcrypt (
userid varchar2(50) not null primary key,
passwd varchar(64) not null, --varchar2가 아닌 varchar로 설정
name varchar2(50) not null,
email varchar2(50),
hp varchar2(50),
zipcode varchar2(7),
address1 varchar2(200),
address2 varchar2(200),
join_date date default sysdate
);


--5. 테이블에 자료 입력
insert into member_bcrypt (userid,passwd,name) values
('kim','1234','김과장');
insert into member_bcrypt (userid,passwd,name) values
('park','1234','최부장');
insert into member_bcrypt (userid,passwd,name) values
('hong','1234','홍실장');

--6. 회원정보 확인
select * from member_bcrypt;

--7. 로그인 테스트


SELECT * FROM member_bcrypt WHERE userid='kim' AND passwd='1234';


delete from member_bcrypt;

commit;