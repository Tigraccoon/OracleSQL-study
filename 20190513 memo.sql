select * from memo;

drop table memo;

--한줄 메모장 테이블
create table memo (
idx number not null primary key,
writer varchar2(50) not null,
memo varchar2(300) not null,
post_date date default sysdate
);

-- 메모 추가
insert into memo(idx, writer, memo)
values (1, 'kim', '첫번째 메모');
insert into memo(idx, writer, memo)
values (2, 'park', '두번째 메모');

commit;

delete from memo;
-- 글번호 자동계산(서브쿼리)
select max(idx)+1 from memo; -- 게시물이 하나도 없을 때는 null 
-- nvl( A, B ) A의 값이 null일 때 ==> B
select nvl( max(idx)+1, 1) from memo;

-- 글번호 자동계산을 insert문 안의 select에서 처리(서브쿼리문)
insert into memo ( idx, writer, memo )
values ( (select nvl( max(idx)+1, 1) from memo), 'park', '메모'); 

--메모 삭제
delete from memo where idx=4;

--1번 게시물 보기
select * from memo where idx=1;
--게시물 수정
update memo set writer='kim', memo='memo1' where idx=1;

-- 게시물 삭제
delete from memo where idx=9; 

-- 게시물 갯수 계산
select count(*) from memo; 

-- 게시물 검색
select * from memo

where memo like '%안녕%';
--where writer like '%%'; --모든 레코드가 조회됨
--where writer like '%홍%'; -- 이름에 '홍'자가 들어가는 모든 레코드

-- 이름 + 메모로 검색
select * from memo
where writer like '%메모%' or memo like '%메모%';

commit;

--내용으로 찾기
 
 SELECT idx, writer, memo, tochar(post_date,'yyyy-<<-dd hh24:mi:ss') post_date 
 from memo 
 where memo like '%메모%'
 order by idx desc;
 
 
 --insert
 --    insert into memo ( idx, writer, memo ) values 
 --   ( (select nvl( max(idx)+1, 1) from memo)
 --   , #{writer}, #{memo}) 

 --SELECT
 --   SELECT idx,writer,memo,to_char(post_date,'yyyy-mm-dd hh24:mi:ss') post_date 
 -- 	FROM memo 
 --		WHERE ${searchkey} like '%'||#{search}||'%'  
 --		ORDER BY idx DESC
