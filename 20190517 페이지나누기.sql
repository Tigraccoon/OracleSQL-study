drop table test;

--사원테이블 복사(레코드 제외)
--만약 where절을 빼고 실행하면 레코드까지 복사됨
create table test
as select * from emp where 1=0; 

select * from test;

--PLSQL
--test 테이블에 991건의 레코드 입력
declare --선언부
  i number := 1; --i 변수에 1을 대입
begin --실행부
  while i<=991 loop
    insert into test (empno,ename) values
      (i, '사원'||i);
    i := i + 1;
  end loop;
end;
/

commit; 

select * from test order by empno;
select count(*) from test;

--rowid : 레코드의 주소값
--rownum : 레코드의 번호(sql이  실행된 다음에 순번을 주는것)
select rownum, empno, ename
from test
order by empno;

select rowid, empno, ename
from test
order by empno;
--  페이지나누기를 하기위해서 rownum이 필요하다.
-- select 쿼리가 다 실행된 뒤에야 rownum이 붙는거다.
-- 예를들어 아래와 같은 경우는 rownum 1번이 출력되지 않은
-- 상태에서 2번이 출력되지 않는다.
-- SQL문 실행순서 : from => where => select => order by
select rownum, empno, ename
from test
where rownum = 2;

--따라서 이를 해결하기위해서는 아래처럼 처리해야한다.
-- 필드 between A and B : 필드값이 A~B
select empno,ename
from test
where rownum between 1 and 10;

--그런데 1page에 10개씩 보여주겠다는건데 만약 아래처럼 하면
--값이 안나온다. 즉 rownum은 연속적인 값이 필요하다. 중간에 건너뛸 수 없다.
select empno,ename
from test
where rownum between 11 and 20;

--그래서 이를 또 해결하기 위해 서브쿼리를 사용해야한다.
select *
from (
  -- 전체 레코드에 일련번호 부여(2)
  select A.*, rownum as rn 
  from (
      --전체 레코드를 뽑음(1)
      select empno, ename 
      from test
      order by empno
  ) A
)
where rn between 1 and 10; --제일 바깥쪽 select문에서 원하는 값을 쓴다.(3)

-- 만약 2page를 뽑으려면  between 11 and 20;

select *
from (
  select A.*, rownum as rn 
  from (
      select empno, ename 
      from test
      order by empno
  ) A
)
where rn between 29 and 80; --제일 바깥쪽 select문에서 원하는 값을 쓴다.(3)

