drop table memo;

create table memo (
idx number not null primary key,
writer varchar2(50) not null,
memo clob,
post_date date default sysdate
);

insert into memo (idx,writer,memo) values (1,'kim','첫번째 메모');
insert into memo (idx,writer,memo) values (2,'park','두번째 메모');

select * from memo;
commit;
-------------------------------------------------------------------------------
delete from memo;
-- nvl(A,B) A가 null이면 B
select nvl(max(idx)+1,1) from memo;

insert into memo (idx,writer,memo) values
((select nvl(max(idx)+1,1) from memo),'park','메모');

select * from memo order by idx desc;

select * from memo
where idx=47;
--이름으로 검색
select * from memo
where writer like '%철%';
--메모 내용으로 검색
select * from memo
where memo like '%연습%';
--이름+메모 내용으로 검색
select * from memo
where writer like '%철수%' or memo like '%철수%';
--이름+메모 내용으로 검색(합집합)
select * from memo

where writer like '%철수%'
union
select * from memo
where memo like '%철수%';


delete from memo;
commit;
