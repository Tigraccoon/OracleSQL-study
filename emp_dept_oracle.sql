--hr계정 활성화방법 (system계정으로 로그인 후)
alter user hr identified by hr account unlock;


-- 사원테이블(emp), 부서테이블(dept) join 
-- 사원 테이블
select * from EMP;
--부서 테이블
select * from dept;

--오라클용 SQL
--테이블 조인(join)
select empno, ename, dname
from emp e, dept d 
where e.deptno=d.deptno;

--ANSI SQL(표준 SQL)
select empno, ename, dname
from emp e join dept d
 on e.deptno=d.deptno;

--오류(deptno의 테이블 미지정시)
select empno, ename, deptno, dname
from emp e, dept d
where e.deptno=d.deptno;

--deptno의 emp테이블 지정처리
select empno, ename, e.deptno, dname
from emp e, dept d
where e.deptno=d.deptno;

--부서코드가 30번인 직원들 출력
select empno, ename, e.deptno, dname
from emp e, dept d
where e.deptno=d.deptno and e.deptno=30 order by ename;

--[문제] 직위(job)가 사원인 직원들 출력
select empno, ename, job, e.deptno, dname
from emp e, dept d
where e.deptno=d.deptno and e.job='사원' order by empno desc;

-- order by 정렬기준컬럼
-- order by 컬럼 desc(내림차순), asc(오름차순-기본)

--사번,이름,직급,입사일자,급여,부서이름
select empno,ename,job,hiredate,sal,dname
from emp e, dept d
where e.deptno=d.deptno and ename like '%철%';

select * from dept order by dname;

--테이블 복사
desc emp;

--emp테이블 구조만 복사(제약조건 not null, pk등 은 제외된 상태에서 복사됨)
create table emp_copy as select * from emp where 1=0;

desc emp_copy;

select * from emp_copy;

--테이블 삭제 drop tabale 테이블이름
drop table emp_copy;

select count(*) from emp;

--학생테이블
select * from student;

--학과 테이블
select * from department;

--교수 테이블
select * from professor;

--이름,학과코드,학과명
select name, deptno1, dname
from student, department
where student.deptno1 = department.deptno;

--[문제] 테이블의 별칭을 활용해서 이름,학과코드,학과명을 출력
select name, deptno1, dname
from student s, department d
where s.deptno1 = d.deptno;

--[문제] ANSI SQL(표준SQL) 방식으로 위 sql문을 수정
select name, deptno1, dname
from student s join department d
on s.deptno1 = d.deptno;

-- 학생이름,학과코드,학과명,지도교수이름
select s.name, deptno1, dname, p.name
from student s, department d, professor p
where s.deptno1=d.deptno and s.profno=p.profno;

--[문제] ANSI SQL(표준SQL) 방식으로 위 sql문을 수정
select s.name, deptno1, dname, p.name
from student s join department d on s.deptno1=d.deptno
join professor p on s.profno=p.profno;

-- 지금까지는 inner join임(양테이블에 모두 데이터가 있는 경우)
-- outer join은 한쪽에는 자료가 있는데 한쪽에는 자료가 없을 때 하는 방식

-- subject(과목) 테이블 생성
-- 다른테이블의 pk를 가져와서 key를 쓰는 것을 fk 외래키라고 함
create table subject(
subject_code number not null primary key,
subject_name varchar2(50) not null,
profno number not null,
point number default 3
);

insert into subject values(1,'java',1001,3);
insert into subject values(2,'db',1002,4);
insert into subject values(3,'jsp',1003,2);
insert into subject (subject_code, subject_name, profno) 
values(4,'안드로이드',1001);

commit;

select * from subject;

-- 과목코드, 과목명, 담당교수명, 학점
select subject_code, subject_name, name, point
from subject s, professor p
where s.profno=p.profno;

[문제] 위코드를 ANSI SQL로 변환
select subject_code, subject_name, name, point
from subject s join professor p
 on s.profno=p.profno;

-- 수강 테이블
create table lecture (
studno number not null,
subject_code number not null,
grade varchar(2),
primary key(studno, subject_code) --복합키 
);

insert into lecture values (9411, 1, 'A0');
insert into lecture values (9411, 2, 'A+');
insert into lecture values (9411, 3, 'B0');
insert into lecture values (9412, 3, 'C0');
insert into lecture values (9412, 4, 'F');
insert into lecture values (9413, 2, 'B+');
insert into lecture values (9413, 3, 'A+');

commit;

select * from lecture;

--학번, 이름, 과목명, 학점, 등급
--학생(studno) - 수강(studno)
--수강(subject_code) - 과목(subject_code)
--교수(profno) - 과목(profno)
select st.studno, st.name sname, sb.subject_name, p.name pname, sb.point, l.grade
 from student st, lecture l, subject sb, professor p
 where st.studno=l.studno 
 and l.subject_code=sb.subject_code 
 and p.profno=sb.profno;

--alter table 테이블이름 add 컬럼 자료형(사이즈);
--student 테이블에 img_path라는 컬럼을 추가
alter table student add img_path varchar2(500);

commit;


--A문자열 || B문자열  => 연결
select (studno || '  ' || name) name from student;

--학번, 이름, 학과코드, 학과명, 지도교수사번, 지도교수이름, 전화, 사진경로
--student, department, professor 테이블 조인
--학생(deptno1) - 학과(deptno)
--학생(profno) - 교수(profno)
select s.studno, s.name sname, d.deptno, d.dname, p.profno, p.name pname, s.tel, s.img_path 
 from student s, department d, professor p 
 where s.deptno1 = d.deptno 
 and s.profno = p.profno;
 and s.studno = 9711;

--9711학생 같은 경우는 지도교수가 아직 배정되지 않아 데이터 출력이 안된다. 따라서 outer join을 해야한다.

--학생 수
select count(*) from student;

--누락된 학생 수
select count(*) from student where profno is null;

--outer join 방식(해당 데이터가 없더라도 나머지 데이터는 출력가능하게 해줌)
select studno,s.name sname,p.name pname from student s, professor p 
 where s.profno = p.profno(+); --(+) 추가

--수강정보 ex)
select st.studno, st.name sname, sb.subject_name, p.name pname, sb.point, l.grade
 from student st, lecture l, subject sb, professor p
 where st.studno=l.studno 
 and l.subject_code=sb.subject_code 
 and p.profno=sb.profno
 and st.studno = 9411;

select * from emp;

select empno,ename,sal from emp where sal >= 300;

--distinct : 중복 데이터는 출력 안 함
select distinct job from emp;

--all : 중복 데이터 허용
select all job from emp;

--order by : 정렬 - asc(오름차순, default), desc(내림차순)

select * from emp order by sal desc;

--이중 정렬 가능. 앞의 조건이 우선이며 중복된 경우 후의 조건을 수행
select * from emp order by job asc, sal desc;


select * from emp order by hiredate asc, sal desc;


-- alias : 별칭

select ename 이름, job 직업코드, sal 급여 from emp order by 직업코드, 급여 desc;


--where : 검색에 조건을 부여

select * from emp where sal > 100 and sal < 400 order by sal desc;

select * from emp
 where sal > 100 and sal < 400
 order by sal desc;


-- 연산자
--산술 연산자 : +, -, *, /
--비교 연산자 : =, !=, <, <=, >, >=
--논리 연산자 : and, or, not

 select * from emp where not (sal between 200 and 300) order by sal desc; 
 select * from emp where not (sal >= 200 and sal <= 300) order by sal desc;


--SQL연산자 : in, any, all, between, like, is null, is not null

select deptno, sal, ename from emp where deptno=10 or deptno=20 or deptno=30 order by deptno desc;


--in (집합) 집합의 요소 중 한 개 이상이 해당되면 선택

select deptno, sal, ename from emp where deptno in(10,20,30) order by deptno;


--any는 in과 같으나 다양한 연산자를 사용할 수 있음

select deptno, sal, ename from emp where deptno = any(10,20,30) order by deptno;

select deptno, sal, ename from emp where sal > any(200,300,400) order by sal;

select deptno, sal, ename from emp where sal = any(200,300,400,500,600) order by sal;

select deptno, sal, ename from emp;

select deptno, sal, ename from emp where ename like '김%' order by ename;

select deptno, sal, ename from emp where ename like '%철%' order by ename;

-- '_'를 쓰면 글자 수를 나타냄

select deptno, sal, ename from emp where ename like '_철%' order by ename;


--커미션 null인 레코드 출력(주의 : = 을 쓰면 안 된다)

select * from emp where comm is null order by deptno;


--커미션이 null이 아닌 레코드(주의 : is not 대신 >, < 등을 쓰면 안 된다)

select * from emp where comm is not null order by deptno;


--연봉 계산 시 comm이 null인 사람은 계산이 안 되게 출력

select empno, ename, sal, comm, sal*12+comm 연봉 from emp; 


--nvl(A, B) A의 값이 null이면 B, null이 아니면 A

select empno, ename, sal, comm, sal*12+nvl(comm,0) 연봉 from emp; 






