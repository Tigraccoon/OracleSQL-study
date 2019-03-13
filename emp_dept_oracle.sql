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

--[문제] 위코드를 ANSI SQL로 변환
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
 --and s.studno = 9711;

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


--결합 연산자 : ||
--결합할 내용이 날짜나 문자인 경우에는 단일 따옴표( ', " )를 붙임
--각 사람의 급여를 검색 '누구의 급여는 얼마입니다' 컬럼명을 만들어서 출력

select ename || ' 의 월급은 ' || sal || '입니다.' 월급 from emp;

select ename || '의 연봉은 ' || (sal*12+nvl(comm,0)) || '입니다.' 연봉 from emp;


--연산자 우선순위 괄호() : 연산자 우선순위에서 제일 높음
--  1순위 : 비교 연산자, SQL연산자, 산술 연산자
--  2순위 : not
--  3순위 : and
--  4순위 : or
--  5순위 : 결합 연산자

--emp 테이블에서 입사일(hiredate)이 2005년 1월 1일 이전인 사원은?

select ename 이름, hiredate 입사일, deptno 부서번호 
 from emp 
 where hiredate <= '2005.01-01'     --년월일 구분은 . 이나 - 를 사용
 order by 입사일;
 
 
 --emp 테이블에서 부서번호가 20번 또는 30번인 부서에 속한 사원을 출력(이름 오름차순)
 
select ename 이름, job 직책, deptno 부서번호 
 from emp
 where deptno in(20,30)     -- 또는 deptno = 20 or deptno = 30
 order by 이름;

select ename 이름, job 직책, deptno 부서번호 
 from emp
 where deptno = any(20,30)     -- 또는 deptno = 20 or deptno = 30
 order by 이름;


--conunt()함수 : 레코드 갯수

select count(*) from emp;


--sum() 함수 : 레코드 합계

select sum(sal) from emp;


--avg() 함수 : 레코드 평균
--rount(A, B)함수 : A - 대상, B - 소숫점 자릿수 

select round(avg(sal), 2) from emp;


--min() 함수 : 최소값

select min(sal) from emp;


--max()함수 : 최대값

select max(sal) from emp;


--부서별 사원번호, 직원수, 급여합계, 급여평균, 최저급여

select deptno 사원번호, count(*) 직원수, sum(sal) 급여합계, round(avg(sal), 2) 급여평균, min(sal) 최저급여, max(sal) 최대급여 
 from emp  
 group by deptno
 order by deptno;


--단일 행 함수
--문자 함수
--  chr(아스키코드) : 해당 아스키 코드값에 대한 문자 반환

select chr(65) from dual;
--dual : 가상 테이블(오라클에서는 select에서 반드시 from을 붙여야 하기 때문에 dual이라는 형식적 가상 테이블을 사용

--sysdate : 현재 시간
--MySQL에서는 now() 함수를 사용. ex) select now(); 로 from절 없이 바로 사용 가능

select sysdate from dual;


--ascii(문자) : 문자의 아스키 코드값을 반환

select ascii('A') from dual;


--concat(컬럼명, '문자열') : 컬럼에 해당하는 문자열을 붙임, 결합 연산자와 같은 역할 A || B

select concat(ename, '의 직책은 ') 누구의, job 직책 from emp;

select ename || '의 직책은 ' || job 직책 from emp;

select concat('로미오와', '줄리엣') from dual;


--initcap('문자열') : 시작 문자만 대문자로, 다른 문자를 소문자로 반환

select initcap('asdAsd') from dual;

select initcap('hello JAVA from oracle') 대문자 from dual;


--lower('문자열'), upper('문자열') : 문자열을 소문자, 대문자로 변경

select lower('Java Oracle Sql') 소문자, upper('Java Oracle Sql') 대문자 from dual;


--lpad('문자열1', 자리수, '문자열2') : 문자열1을 자리수만큼 늘리는데 왼쪽으로 늘어난 자리수 공간에 문자열2를 채워서 반환함. 문자열 2가 생략되면 공백으로 채워짐

select 'abcd', lpad('abcd', 9, '*') LPAD from dual;

select 'abcd', lpad('abcd', 9) LPAD from dual;


--rpad('문자열1', 자리수, '문자열2') : 오른쪽으로 늘림

select 'abcd', rpad('abcd', 9, '*') RPAD from dual;

select 'abcd', rpad('abcd', 9) RPAD from dual;


--ltrim('문자열1', '문자열2') : 문자열1에서 문자열2를 왼쪽으로 제거한 결과값을 반환

select ltrim('ABCD', 'AB') LTRIM from dual;

select ltrim('            oracle java javac aa', ' ') 왼쪽공백제거 from dual;


--rtrim('문자열1', '문자열2') : 문자열1에서 문자열2를 오른쪽으로 제거한 결과값을 반환

select rtrim('ABCD', 'CD') RTRIM from dual;

select rtrim('oracle java javac aa            ', ' ') 오른쪽공백제거 from dual;


--replace('문자열1', '문자열2', '문자열3') : 문자열1 중에 있는 문자열2를 문자열3으로 바꿔서 결과를 출력

select replace('Oracle Java Jsp Html', 'J', 'O') REPLACE from dual;

select replace('asiancup is international festival', 'asiancup', 'worldcup') replace from dual;


--substr('문자열', 자릿수, 갯수) : 문자열의 자리수부터 시작해서 지정된 갯수만큼 문자를 잘라내서 결과값을 반환함 *시작 인덱스 1

select substr('자바개발자 과정', 4, 4) SUBSTR from dual;

select ename from emp where substr(ename, 2, 1) = '철';

select ename 이름 from emp where ename like '_철%';


--instr('문자열1', '문자열2', 자리수1, 자리수2) : 자리수1 부터 자리수 2번째의 문자열 2를 찾아서 시작 위치를 반환

select instr('wow-wow-wow-wow-wow', '-') wow from dual;
-- '-'이 처음 나오는 위치

select instr('wow-wow-wow-wow-wow', '-', 5, 1) wow from dual;
-- '-'이 5번째 문자부터 시작해서 처음 나오는 하이픈의 위치


--length('문자열') : 문자열의 길이를 반환함

select length('jjjaaavvvaaa') 문자열길이 from dual;

select length(rtrim('abcd     ', ' ')) from dual;


--greatest('값1', '값2', '값3' ...) : 가장 큰 값을 반환

select greatest(10, 20, 30, 40) 큰값 from dual;

select greatest('a','b','asd', 'zzz') from dual;

select greatest('asb','asdb','asdfgh') from dual;

--least('값1', '값2', '값3' ...) : 가장 작은 값을 반환

select least(10, 20, 30) 작은값 from dual;

select least('10','20','30') from dual;




--날짜 함수

--sysdate : 시스템의 현재 날짜

select sysdate from dual;


--add_months(날짜 컬럼 or 날짜 데이터, 숫자) : 날짜값에 개월 수를 더해서 결과값을 반환

select add_months(sysdate, 3) from dual;

select add_months('2013/01/25', 5) from dual;

select add_months('2013/01/25', -5) from dual;

select empno 사원번호, ename 이름, hiredate 입사일, add_months(hiredate, 3) 정규직_전환일 from emp;

--100일 후의 날짜
select sysdate+100 from dual;

select empno 사원번호, ename 이름, hiredate 입사일, hiredate+90 입사후90일 from emp;


-- last_day(날짜컬럼 or 날짜데이터) : 파라미터 데이터와 같은 달의 마지막 날짜를 반환

select last_day(sysdate) from dual;

--입사일 이후 근무 일수

select empno,ename,hiredate,round(sysdate-hiredate) from emp;

--입사일 이후 근무일수가 3000일 이하인 직원

select empno 사원번호, ename 이름, hiredate 입사일, round(sysdate-hiredate) 근무일수 
 from emp 
 where sysdate-hiredate < 3000
 order by 근무일수;
 
 
 --SQL 실행순서 : from -> where -> select -> order by    즉 where절에서 별칭을 사용하면 에러
 
 
 --살아온 일수
 
select studno, name, birthday, round(sysdate-birthday) from student;
 
 --살아온 달
 
select studno, name, birthday, round(round(sysdate-birthday) /30) from student;
 
 
 --months_between(날짜컬럼1 or 날짜데이터1, 날짜컬럼2 or 날짜데이터2) : 두 날짜 사이의 개월 수를 반환
 
select months_between('2013/05/25', '2013/01/24') from dual;
 
 --살아온  일수
 
select months_between(sysdate, '1994/08/01') from dual;
 
--정확환 살아온 달 계산
select studno, name, birthday, round(round(sysdate-birthday) /30), round(months_between(sysdate,birthday)) from student;


--next_day(날짜컬럼 or 날짜데이터, 숫자 or 요일) : 날짜데이터 이후의 날짜 중에서 숫자 or 요일로 명시된 첫 번째 날짜를 반환함

--지금 날짜를 기준으로 돌아오는 토요일은 몇 일?
 select next_day(sysdate, '토') from dual;
 
 
 --문자 변환 함수 : to_char(날짜컬럼 or 날짜데이터, '??')
 -- '??'에 들어갈 수 있는 값
 -- 1) d : 주중의 일(1~7)
 -- 2) day : 일을 서술형 이름으로 표시
 -- 3) dd : 1~31 형태로 일을 표시
 -- 4) mm : 01~12 형태로 월을 표시
 -- 5) month, mon : 월을 서술형 이름으로 표시
 -- 6) yy : 뒤의 두자리 연도
 -- 7) yyyy : 네자리 연도
 -- 8) dd-mm-yy : 일-월-연도 or yyyy-mm-dd : 연도-월-일
 -- 9) hh, hh12, hh24 : 시간
 -- 10) mi : 0~59 형태로 분
 -- 11) ss : 0~59 형태로 초
 -- 12) am, pm : 오전, 오후
 
 select to_char(sysdate, 'yyyy-mm-dd am hh:mi:ss day') from dual;
 
 
 --숫자 변환 함수 : to_number('숫자형태의 문자열')
 
 select to_number('100') from dual;
 
 
 --날짜 변환 함수 : to_date('날짜 형태의 문자열', '날짜 변환 포맷')
 
 select to_date('2019-02-19', 'yyyy-mm-dd') 결과값 from dual;
 
 
 --시스템 함수 : user - 현재 오라클에 접속중인 사용자를 반환
 
 select user from dual;
 
 
 --숫자 함수
 
 -- trunc(숫자1, 자릿수) : 숫자1을 소숫점 자리수에서 절사
 
 -- round(숫자, 자릿수) : 숫자를 소숫점 자리수에서 반올림
 
 -- ceil(숫자) : 버림
 
 --각 직원의 이름과 근속연수를 볼 때 근속연수는 연단위 버림
 
 select ename, trunc((sysdate-hiredate)/365) 근속연수 from emp;
 
 select ename, ceil((sysdate-hiredate)/365) 근속연수 from emp;
 
 select ename, round((sysdate-hiredate)/365) 근속연수 from emp;
 
 
 --일반 함수
 --nvl(컬럼, 치환할 값) : 컬럼의 값이 null이면 다른 값으로 치환(대체) 함수
 
 select deptno 학과, name 이름, pay 급여, bonus 보너스, (pay*12+nvl(bonus, 0)) 연봉 
 from professor 
 where deptno = 101;
 
 
 -- decode(A, B, A==B일 때의 값, A<>B 일 때의 값) : A<>B 일때의 값을 생략하면 null로 처리됨, decode 함수의 매개번수의 갯수는 다중 조건에 의해 늘어날 수 있음
 -- 간단한 join 느낌
 
 select name 이름, deptno 학과, decode(deptno, 101, '컴퓨터 공학과') 학과명 
 from professor;
 
 select name 이름, deptno 학과, decode(deptno, 101, '컴퓨터 공학과', '기타 학과') 학과명 
 from professor;
 
 select name 이름, deptno 학과, decode(deptno, 101, '컴퓨터 공학과', 102, '멀티미디어 공학과', 103, '소프트웨어 공학과', 201, '전자공학과', '기타 학과') 학과명 
 from professor;
 
 select empno 사번, ename 이름, decode(deptno, 10, '경리팀', 
                                                                    20, '연구팀',
                                                                    30, '총무팀',
                                                                    40, '전산팀', '기타팀') 소속부서
 from emp;
 
 
 select s.name, s.deptno1, d.dname 
  from student s, department d
  where s.deptno1=d.deptno;
 
 select * from department;
 
 select * from student;
 
 select * from professor;
 
 
 -- join
 
 select s.name 학생이름, d.dname 학과, p.name 지도교수 
 from student s, department d, professor p 
 where s.deptno1 = d.deptno and s.profno = p.profno;
 
 
 -- view : 가상의 테이블
 
 create or replace view student_v as 
 select s.name 학생이름, d.dname 학과, p.name 지도교수 
 from student s, department d, professor p 
 where s.deptno1 = d.deptno and s.profno = p.profno;
 
 --view를 테이블 처럼 사용 가능
 
 select * from student_v;
 
 --아래와 마찬가지
 
select * from ( select s.name 학생이름, d.dname 학과, p.name 지도교수 
 from student s, department d, professor p 
 where s.deptno1 = d.deptno and s.profno = p.profno); --서브쿼리
 
 --view를 쓰는 이유는 복잡한 select문을 간단히 하고자 함
 --java code에 쓸 때 select * from student_v; 를 사용하면 되기 때문에 코딩이 간략해지며 통신량이 줄어듦
 --코드가 노출되어도 조금 더 보안에 유리함
 --단, 속도가 약간 느려짐..(테이블인지 뷰인지 먼저 검사한 후 원본에서 query문을 가져와 실행하기 때문)
 --저장 프로시져를 쓰면 더 줄일 수 있음!
 
 
 --종류
 --cross 조인(Cartesian Product, 카다지언 곱)
 -- 2개 이상의 테이블이 조인될 때 조인 조건을 주지 않는 것. 즉 where 절에서 공통 컬럼에 의한 결합이 발생하지 않아서 두 테이블 간의 조합 가능한 모든 경우의 수를 계산하여 결과를 산출하는 조인 대상
 -- 엄밀한 의미에서 조인은 아님.
 
 select e.ename, d.dname 
 from emp e, dept d;
 
 
 --내부 조인(inner join, 동등 조인, Equi join)
 -- 가장 일반적인 형태, where절에 사용된 공통 컬럼들이 동등 연산자( = ) 에 의해 비교되는 조인 대상
 
 
 --self join : 참조해야 할 컬럼이 자신의 테이블에 있는 다른 컬럼인 경우에 사용하는 조인. 반드시 테이블에 대한 별칭을 써야 함.
 
 select a.empno 사번, a.ename 이름, b.empno 매니저사번, b.ename 매니저 
 from emp a, emp b 
 where a.mgr = b.empno;
 
 
 --외부 (outer)조인 대상 : 한 쪽 테이블에는 해당 데이터가 존재하고 다른 쪽 테이블에는 데이터가 존재하지 않을 경우 몯ㄴ 데이터를 조회하는 조인
 -- 조회 조건에서 (+)기호를 사용하는 조인
 -- 데이터가 존재하지 않는 테이블의 조인 조건에 (+) 붙임
 -- *주의 : 테이블에 (+)를 붙이는게 아님, (+)가 붙은 컬럼과는 in 연산자를 함께 사용할 수 없음!, (+)가 붙은 컬럼과는 서브쿼리를 같이 사용할 수 없음!
 
 select s.name, p.name 
 from student s, professor p 
 where s.profno = p.profno(+);
 
 
 --ANSI 조인 : 새로운 국제 표준에 따른 조인, Oracle 9i부터 지원
  -- 내부 조인 : inner join 사용
  --    - where 대신 on 사용(inner 생략 가능!)
 select e.empno, d.dname 
 from emp e inner join dept d
 on e.deptno=d.deptno;
 
 --     - where 절 대신 using 사용 가능(참조하는 컬럼이 동일한 경우에만 사용)
  select e.empno, d.dname 
 from emp e inner join dept d
 using (deptno);
 
 
 select s.name, s.deptno1, d.dname 
 from student s, department d 
 where s.deptno1 = d.deptno;
 
 
 --외부 조인 : [left | right | full] outer join 사용
 -- 데이터가 있는 테이블편을 기준으로 left 또는 right를 붙임
 
 select s.name sname, p.name pname 
 from student s left outer join professor p --student가 오른쪽에 있으면 right를 씀
 on s.profno = p.profno 
 order by sname;
 
 
 --지도 교수가 없는 학생
 
  select s.name sname, p.name pname 
 from student s, professor p
 where s.profno = p.profno(+) 
 order by sname;
 
 --지도 학생이 없는 교수
 
 select s.name sname,  p.name pname 
 from student s, professor p
 where s.profno(+) = p.profno 
 order by sname;
 
 --위 모두를 출력하고 싶을 땐, 양 쪽 모두에 (+)를 붙일 순 없다.
 --ANSI에서는 full outer join을 사용하면 됌
 
  select s.name sname, p.name pname 
 from student s full outer join professor p 
 on s.profno = p.profno 
 order by sname;
 
 
 --테이블 조인
 --상품 테이블
 
 drop table product;
 
 
 create table product (
 product_code varchar2(20) not null primary key,
 product_name varchar2(50) not null,
 price number default 0,
 company varchar2(50),
 make_date date default sysdate
 );
 
 desc product;
 
 select * from product;
 
 insert into product values('A1','아이퐁',900000,'애풀','2016-09-01');
 insert into product values('A2','갤럭시 노투',9000000,'샘숭','2018-08-01');
 insert into product values('A3','갤럭시S19',1200000,'샘숭','2019-01-01');
 
 
 --판매 테이블
 
 --references 테이블명(컬럼) : foreign key(외래키)
 
 create table product_sales (
 product_code varchar2(20) not null references product(product_code),
 amount number default 0
 );
 
 desc product_sales;
 
 insert into product_sales values('A1',100);
 insert into product_sales values('A2',200);
 insert into product_sales values('A3',300);
 
 select * from product_sales;
 
 commit;
 
 insert into product_sales values('A4',300);
 
 --drop table product_sales;
 
 
 select p.product_code, p.product_name, p.company, p.price, s.amount, p.price*s.amount money
 from product p, product_sales s
 where p.product_code = s.product_code;
 
 --위 select문을 view를 활용하여 구현
 
 create or replace view product_sales_v 
 as select p.product_code, p.product_name, p.company, p.price, s.amount, p.price*s.amount money
 from product p, product_sales s
 where p.product_code = s.product_code;
 
 --뷰를 테이블 처럼 사용할 수 있음!
 select * from product_sales_v;
 
 select * from product_sales_v where company = '샘숭';
 
 
 
 create table dep (
 id varchar2(10) primary key,
 name varchar2(15) not null,
 location varchar2(50)
 );
 
insert into dep values('10', '영업부', '서울 강남구');
 
 savepoint a;
 
 insert into dep values('20', '회계부', '부산 동래구');
 
 savepoint b;
 
 insert into dep values('30', '개발부', '인천 게양구');
 
 select * from dep;
 
 rollback to a;
 
 commit;
 
 rollback to b;
 
 --undo 의 시간값을 보는 명령어
 show parameter undo;
 
 --undo_retention : delete, update 후에 commit을 했을 때부터 속성값의 시간(초)까지느 오라클에서 임시로 저장한 데이터로 복구할 수 있음!
 --Default 속성값은 '900'초로 약 15분 내에는 복구가 가능함. commit 이후에 15분 이내에는 데이터를 복구 가능
 --시간 변경도 가능한데 변경하려면 
 alter system set undo_retention = 1500;
 
 show parameter undo;
 
 undo_retention;
 
 select * from tab;
 
 select * from member;
 
 delete from member where userid='park';
 
 commit;
 
 --삭제된 레코드 확인
 select * from member as of timestamp(systimestamp-interval '15' minute) 
 where userid='park';
 
 --삭제된 레코드 복구
 insert into member select * from member as of timestamp(systimestamp-interval '15'minute)
 where userid='park';
 
 select * from tab;

 select count(*), sum(sal), round(avg(sal),2) 
 from emp 
 where deptno=10;

--group by : 그룹핑(그룹으로 짓는다.)
 select count(*), sum(sal), round(avg(sal),2) 
 from emp 
 group by deptno;
 
 
 --group by(집계)와 having(집계 결과에서의 조건)
 
 select dname, avg(pay) 
 from professor p, department d
 where p.deptno = d.deptno 
 group by dname 
 having avg(pay) >= 450;
 
 --이쯤에서 확인하는 SQL 실행 순서 : from(전체 레코드) -> where(행 선택) -> group by(선택된 행을 요약) -> having(요약 결과행 선택) ->select(컬럼 선택) -> order by(정렬) 
 
 
 
 
 --서브쿼리
 
 select max(sal) from emp;
 
 select * from emp where sal=800;
 
 --위의 단계를 한 번에 처리 ( ) 로 묶어야 하고 ( ) 먼저 연산
 
 select * from emp 
 where sal = (select max(sal) from emp);
 
 --테이블의 별칭을 지정하여 구분 가능
 
 select * from emp e1 
 where e1.sal = (select max(sal) from emp e2);
 
 
 --복수행 서브쿼리
 --all(집합) : 집합의 모든 요소를 만족해야 함. and
 --any(집합) : 집합의 요소 중 한 개만 만족하면 됌. or
 
 select sal from emp where deptno=30;
 
 select * from emp 
 where sal > all(select sal from emp where deptno=30);
 
 select * from emp 
 where sal > any(select sal from emp where deptno=30);
 
 select * from emp 
 where sal > (select min(sal) from emp where deptno=30);
 
 
 --연관성이 있는 서브쿼리(상호관련 서브쿼리) : 서브쿼리와 메인쿼리 사이에 조인을 사용, 반드시 별칭을 사용
 
 --ORACLE
 select e.ename, e.deptno, d.dname 
 from emp e, dept d
 where e.deptno = d.deptno;
 
 --ANSI
 
 select e.ename, e.deptno, d.dname 
 from emp e join dept d 
 on e.deptno = d.deptno;
 
 --서브쿼리, 조인을 사용한 검색의 경우
 
 select e.ename, e.deptno, (select d.dname from dept d where e.deptno = d.deptno) departmentName 
 from emp e;
 
 --부서 평균 급여보다 월급이 적은 사원들을 출력
 
 select e.ename, e.sal, e.deptno, 
 (select round(avg(sal)) from emp where deptno=e.deptno) 부서평균급여
 from emp e 
 where sal < (select avg(sal) from emp where deptno=e.deptno);
 
 --인라인 뷰 : from 절에 위치 
 --* from절에는 테이블이나 뷰가 위치하는데 이것과 비교해서 서브쿼리에 의해 만들어진 결과값들에 대해서 부르는 명칭. 인라인 뷰와 비교해서 정식으로 만들어진 뷰를 아웃라인 뷰라고 함
 
 select e.empno, e.ename, e.sal 
 from emp e, (select avg(sal) avgs, max(sal) maxs from emp) e2 --인라인 뷰 (inline view)
 where e.sal > e2.avgs and e.sal < e2.maxs
 order by e.sal desc;
 
 
 --scalar 서브쿼리(레코드도 하나, 컬럼도 하나)
 --서브쿼리에 의해 하나의 행, 하나의 컬럼값을 반환하는 서브쿼리. 9i부터 지원
 --직책이 부장인 사원의 사원명, 부서명을 조회
 
 select ename 사원명, (select dname from dept d where d.deptno=e.deptno) 부서명 
 from emp e 
 where job='부장';
 
 
 
 --number타입은 java에서 float이나 double으로 호출, 최대 38자리 number(전체 자릿수, 소수 이하 자릿수)
 
 create table t_emp (
 id number(5) not null, 
 name varchar2(25), 
 salary number(7,2),
 phone varchar2(15),
 dept_name varchar2(25)
 );
 
 desc t_emp;
 
 select * from tab;
 
 --테이블명 수정하기 : rename A to B
 
 rename t_emp to s_emp;
 
 insert into s_emp values(100,'이상현',2000,'010-2222-2222','개발부');
 insert into s_emp values(101,'삼상현',3000,'010-3333-3333','총무부');
 insert into s_emp values(102,'사상현',4000,'010-4444-4444','영업부');
 
 delete from s_emp where id=102;
 
 select * from s_emp;
 
 insert into s_emp (id,name) values(103,'오상현');
 
 --테이블에 컬럼 추가
 
 alter table s_emp add (hire_date date);
 
 --컬럼 수정
 
 alter table s_emp modify (phone varchar2(20));
 
 desc s_emp;
 
 commit;
 
 --컬럼의 이름을 수정
 
 alter table s_emp rename column id to t_id;
 
 select * from s_emp;
 
 --컬럼 삭제
 
 alter table s_emp drop column dept_name;
 
 select * from s_emp;
 
 --**alter는 트렌젝션의 대상이 아니라서 복구할 수도 없다!
 
 --테이블 데이터 조작
 
 update s_emp set hire_date = sysdate 
 where t_id=100;
 
 update s_emp set hire_date = sysdate 
 where hire_date is null;
 
 select * from s_emp;
 
 --새로운 데이터 입력
 
 insert into s_emp (t_id, hire_date) values(400,sysdate);
 
 select * from s_emp;
 
 --데이터 삭제
 
 delete from s_emp where t_id=400;
 
 select * from s_emp;
 
 
 --제약조건(constraint)
 --테이블의 해당 컬럼에 조건을 거는 것
 
 --ex) primary key, foreign key, unique(중복되지 않는 pk와 비슷하나 null을 허용), check(값의 범위를 지정), not null
 
 --제약조건을 반영한 테이블 생성
 -- 사용방법 : constraint 제약조건이름 제약조건
 create table c_emp (
 id number(5) constraint c_emp_id_pk primary key,                                           --primary key
 name varchar2(25) constraint c_emp_name_nn not null,                                   --not null
 salary number(7,2), 
 phone varchar2(15) constraint c_emp_phone_ck check(phone like '0000-%'),      -- check
 dept_id number(7) constraint c_emp_dept_id_fk references dept(deptno)           --foreign key 
 );
 
 desc c_emp;
 
 --테이블의 제약조건을 확인
 
 select * from user_constraints where table_name= 'C_EMP';
 
 --참고 : constraint_type
 -- P : primary key
 -- F : foreign key
 -- U : unique
 -- C : check
 
 --해당 DB내의 제약조건 이름들을 볼 때 : 데이터 사전에서 검색됨
 
 select constraint_name from user_constraints;
 
 --제약조건은 수정할 수 없고 삭제만 가능
 
 alter table c_emp drop constraint c_emp_name_nn;
 
 select * from user_constraints where table_name='C_EMP';
 
 --제약조건 추가
 
 alter table c_emp add constraint c_emp_name_un unique(name);
 
 select * from user_constraints where table_name='C_EMP';
 
 --not null 제약조건은 add로 할 수 없고 modify로 가능함
 
 alter table c_emp modify(name varchar2(25) constraint c_emp_name_nn not null);
 
 select * from user_constraints where table_name='C_EMP';
 
 --제약조건 활성화(enable), 비활성화(disable)
 --disable
 alter table c_emp disable constraint c_emp_name_nn;
 
 select * from user_constraints where table_name='C_EMP';
 --enable
 alter table c_emp enable constraint c_emp_name_nn;
 
 --제약조건 삭제
 
 alter table c_emp drop constraint c_emp_name_nn;
 
 
 --실습 (제약조건을 나중에 추가)
 
 drop table c_emp;
 
 create table c_emp (
 id number(5), 
 name varchar2(25),
 salary number(7,2), 
 phone varchar2(15),
 dept_id number(7)
 );
 
 desc c_emp;
 
 insert into c_emp (id,name) values(1,'일철수');
 insert into c_emp (id,name) values(1,'이철수');
 insert into c_emp (id,name) values(1,'삼철수');
 
 select * from c_emp;
 
 delete from c_emp;
 
 --id에 제약조건 Pk부여
 
 alter table c_emp add constraint c_emp_id_pk primary key(id);
 --ORA-0001 : unique constraint (HR.C_EMP_ID_PK) violated : 무결성 제약조건 위반 오류
 
 drop table c_emp;
 
 --check (입력값 체크 조건) 
 
 create table c_emp (
 id number(5) constraint c_emp_id_pk primary key, 
 name varchar2(25),
 salary number(7,2) constraint c_emp_salary_ck check(salary between 100 and 1000), 
 phone varchar2(15),
 dept_id number(7)
 ); 
 
 select * from user_constraints where table_name='C_EMP';
 
 insert into c_emp (id,name,salary) values (1,'kim',500);
 insert into c_emp (id,name,salary) values (2,'park',1500);
 
 select * from user_constraints where table_name='EMP';
 select * from emp;
 select * from user_constraints where table_name='DEPT'; 
 select * from dept;
 
 insert into emp(empno,ename,deptno) values (9999,'홍길동',50);
 
 drop table c_emp;
 
 --unique 제약조건 (null 허용)
 
 drop table c_emp;
 
 create table c_emp (
 id number(5) constraint c_emp_id_pk primary key, 
 name varchar2(25) constraint c_emp_name_un unique, 
 salary number(7,2), 
 phone varchar2(15),
 dept_id number(7) constraint c_emp_dept_id_fk references dept(deptno)
 ); 
 
 select * from user_constraints where table_name = 'C_EMP';
 
 insert into c_emp (id, name) values (1,'kim');
 insert into c_emp (id, name) values (2,'kim'); --오류 : name이 unique로 설정돼서
 
 
 --view
 
 create view test_v 
 as 
 select * from emp;
 
 select * from test_v;
 
 --create로 뷰 생성을 두 번 이상 수행하면 중복 에러가 뜨는데 create or replace로 만들면 에러가 안 뜸..
 create or replace view test_v 
 as 
 select * from emp;
 
 drop view test_v;
 
 create or replace view test_view 
 as 
 select e.empno, e.ename, e.deptno, d.dname 
 from emp e, dept d 
 where e.deptno = d.deptno;
 
 select * from test_view;
 
 select * from tab;
 
 --뷰의 세부 정보 확인(데이터 사전)
 select * from user_views;
 
 create or replace view emp_v 
 as 
 select empno, ename, hiredate, sal 
 from emp;
 
 select *from emp_v;
 
 insert into emp_v values (8000,'km',sysdate,70);
 
 delete from emp_v where empno = 8000;
 
 --테이블이 한 개일 때는 괜찮으나 두 개 이상 조인이 들어가면 뷰에서는 문제가 생김
 --뷰에 레코드를 입력, 삭제, 변경 등은 가능은 하나 권장하지는 않음..
 --뷰의 주 용도는 select를 처리하기 위한 기능이라서?
 
 --뷰 삭제
 drop view emp_v;
 
 create or replace view emp_v 
 as 
 select empno, ename, hiredate, sal 
 from emp 
 with read only;      --읽기 전용 뷰(대부분의 뷰)
 
 insert into emp_v values(8000,'kim',sysdate,700); --읽기 전용 뷰라서 에러
 
 
 --index
 
 select rowid,empno,ename from emp;
 
 --index 생성
 --primary key나 unique 제약조건을 만들면 해당 인덱스가 자동으로 생성
 
 create index  c_emp_name_idx on c_emp(name);
 
 --삭제
 
 drop index c_emp_name_idx;
 
 --full scan : 모든 레코드를 검사
 --index unique scan : 유일한 값(pk, un 등에 index를 붙일 때)
 --index range scan : 유일하지 않은 값(동명이인이 있을 수 있는 이름 데이터가 들어가는 컬럼에 index를 붙일 때)
 
 select empno, ename 
 from emp 
 where empno=7900;
 
 
 select empno, ename from emp where ename = '송기성';
 
 --인덱스 추가
 create index emp_ename_idx on emp(ename);
 
 --인덱스 삭제
 drop index emp_ename_idx;
 
 --인덱스 테스트를 위한 테이블 생성
 
 create table emp3 (
 no number,
 name varchar2(10),
 sal number
 );
 
 --PL/SQL (Procedural Language)
 
 declare 
i number := 1;
name varchar(20) := 'kim';
sal number := 0;
begin
while i < 1000000 loop
if i mod 2 = 0 then
name := 'kim' || to_char(i);
sal := 300;
elsif i mod 3 = 0 then
name := 'park' || to_char(i);

sal := 400;
elsif i mod 5 = 0 then
name := 'hong' || to_char(i);
sal := 500;
else
name := 'shin' || to_char(i);
sal := 250;
end if; 
insert into emp3 values (i,name,sal); 
i := i + 1; 
end loop; 
end;
/

commit;

select count(*) from emp3;

select * from emp3;

select * from emp3 where name='shin691' and sal > 200;

 --인덱스 추가
 create index emp_name_idx on emp3(name, sal);
 
 --처리 후 cost가 낮아짐
 select * from emp3 where name='shin691' and sal > 200;
 
 --데이터 사전에서 인덱스 정보 확인
 
 select * from user_indexes where table_name='EMP3';    --객체 이름은 대문자
 --nonunique index : 중복값이 있는 인덱스
 --unique index : primary key, unique 제약조건 컬럼에 적용
 
 --인덱스 삭제
 drop index emp_name_idx;
 
 --테이블 생성
 
 create table emp4(
 no number primary key, 
 name varchar2(10), 
 sal number
 );
 
 select * from user_indexes where table_name='EMP4';
 
 select * from emp3;
 
 select * from emp3 where no>900000;
 
 alter table emp3 add constraint emp3_no_pk primary key(no);
 
 --pk처리를 하면 자동으로 인덱스가 생성되어 cost가 감소
 
 --primary key 제약조건 제거(인덱스 제거)
 
 alter table emp3 drop constraint emp3_no_pk;
 
 desc emp3;
 
 --인덱스를 사용하면 order by를 사용 안 해도 자동 정렬
 
 --복합 인덱스 생성
 
 create index emp_nema_idx on emp3(name, sal);
 
 --복합 인덱스는 and연산에서는 사용 가능하지만 or연산에서는 사용하지 않음
 --and 연산은 앞이 f면 무조건 f라서 검색 속도가 줄어들 수 있지만 or연산은 앞 뒤 모두 검사해야 하므로 쓸 이유가 없음
 select * from emp3 where name like 'park1111%' and sal > 300;
 
 select * from emp3 where name like 'park1111%' or sal > 300;
 
 
 --시퀀스(sequence)
 --연속적인 숫자값을 자동으로 증가시키는 숫자를 발생시키는 객체 (예 : 은행 번호표) 처럼 후진은 안 됌 MySQL의 auto_increment와 같은 기능
 
 --시퀀스 생성
 
 --create sequence 시퀀스 이름
 --시퀀스 옵션 : increment by 숫자, 
 --start whit 숫자, 
 --maxvalue 숫자, 
 --minvalue 숫자, 
 --cycle | nocycle(일련번호 순환 여부 1~10), 
 --cache | nochach(캐쉬메모리 사용여부, 빠른 처리를 위해 메모리에 저장, 단 cache를 사용하면 서버를 껐다가 키는 등의 일을 하면 100번까지 발급되어싿가 다음 숫자인 101부터 발급)
 
 --시퀀스 호출 함수 (*주의 : 시퀀스 생성 후 nextval을 호출해야 시퀀스에 초기 값이 설정됌) nextval : 다음 값을 반환
 
 create sequence c_emp_seq 
 increment by 1 
 start with 103 
 maxvalue 1000 
 nocache 
 nocycle;
 
 select c_emp_seq.nextval from dual;
 
 --currval : 현재 값을 반환
 select c_emp_seq.currval from dual;
 
 --사용 예
 
 insert into c_emp values(c_emp_seq.nextval, 'aaa', 1000,'3429-001',10);
 
 select * from c_emp;
 
 select nvl(max(id)+1,1) from c_emp;
 
 insert into c_emp values((select nvl(max(id)+1,1) from c_emp), 'test', 3000,'3429-001',10);
 
 
 --시퀀스 실습
 
 drop sequence c_emp_seq;
 
 --1부터 시작, 1씩 증가, 최대값 10000, 캐쉬 사용 안 함, 순환 안 함
 
 create sequence c_emp_seq
 start with 1 
 increment by 1 
 maxvalue 100000
 nocache
 nocycle;
 
 --시퀀스.nextval : 다음 번호 발급
 --시퀀스.currval : 현재 번호 발급
 --dual : 가상 테이블
 
 select c_emp_seq.nextval from dual;
 select c_emp_seq.currval from dual;
 select * from c_emp;
 
 delete from c_emp;
 
 --시퀀스를 사용하여 사번 자동 부여, 시퀀스 번호 변경은 불가, drop후 다시 작업
 
 insert into c_emp values(c_emp_seq.nextval, 'kim', 3000, '010-2222-2222', 10);
 
 select * from c_emp;
 
 delete from c_emp where id = 2;
 
 --서브 쿼리를 활용한 번호 발급 (장점 : 시퀀스를 만들지 않아도 되고, 다른 DB에도 쓸 수 있다!)
 
 select max(id)+1 from c_emp;
 
 insert into c_emp values ((select max(id)+1 from c_emp), 'kim1', 3000, '000-1000-1000', 10);
 
 select * from c_emp;
 
 delete from c_emp;
 
 select max(id)+1 from c_emp;
 
 --레코드가 하나도 없을 땐 문제가 된다. 이를 해결하기 위해 nvl 함수를 사용
 
 select nvl(max(id)+1,1) from c_emp;
 
 insert into c_emp values (( select nvl(max(id)+1,1) from c_emp), 'kim4', 4000, '000-3330-1000', 30);
 
 select * from c_emp;
 
 --만약 중간에 서브쿼리를 쓰다가 시퀀스로 쓰면 안 됌. 그 반대도 마찬가지!
 
 
 
 --고오급 함수
 --null값 처리 함수
 --nvl
 
 --where를 사용했을 때
 select ename 이름, job 직책, sal 급여, comm, sal*0.03 보나쓰 
 from emp 
 where comm is null;
 
 --nvl을 사용했을 때
 select ename 이름, job 직책, sal 급여, comm, nvl(comm, sal*0.03) 보나쓰 
 from emp;
 
 
 --nvl2 :   nvl2(A, B, C) A가 null이 아니면 B, null이면 C
 
 select ename, deptno, sal*nvl2(comm,0.05,0.03) 특별뽀나쓰 
 from emp;
 
 --nullif : 두 값을 비교하여 같으면 null, 다르면 첫 번째 값을 반환
 --nullif(비교값1, 비교값2, ....)
 
 select ename, deptno 
 from emp 
 where ename like '김%';
 
 --위 수식을 굳~이 NULLIF를 쓰자면
 select ename, deptno, ltrim(ename,'김')
 from emp 
 where nullif(ename, ltrim(ename,'김')) is not null;
 
 
 --coalesce(코알레쓰, 더 큰 덩어리로 합치다) : 여러개의 list 중에서 null이 아닌 첫 번째 값을 돌려주는 함수
 --형식 : colaesce(값1, 값2, 값3, ...) null이 아닌 첫 번째 값
 
 update emp set sal = null where empno = 7788;
 
 select empno 사번, ename 이름, comm 커미션, sal 급여, coalesce(comm, sal, 20) 치환값
 from emp;
 
 
 --decode
 --소수점이 나오면 제대로 decode 함수가 적용 안 되기 때문에 정수형으로 나와야함
 --decode(조건, 결과값1, 출력값1, 결과값2, 출력값2, ..., 기본값)
 update emp set sal = 180 where ename ='황인태';
 
 select ename 이름, sal 급여, decode(trunc(nvl(sal,0)/100), 0, 'E', 1,'D',2,'C',3,'B','A') 급여등급
 from emp;


 create table score (
 student_no varchar2(20) primary key,
 name varchar2(20) not null,
 kor number(3) default 0,
 eng number(3) default 0,
 mat number(3) default 0
 );

 insert into score values(1, 'kim', 90,80,70);
 insert into score values(2, 'lee', 88,85,75);
 insert into score values(3, 'park', 99,89,79);
 insert into score values(4, 'gwak', 100,100,100); 
 insert into score values(5, 'song', 99,99,90); 
 insert into score values(6, 'jong', 50,10,30);
 
 select * from score;
 
 select student_no 학번, name 이름, kor 국어점수, eng 영어점수, mat 수학점수, (kor+eng+mat) 총점, round((kor+eng+mat)/3,2) 평균, 
 decode(trunc((kor+eng+mat)/3/10), 10, 'A', 
                                                    9, 'A', 
                                                    8, 'B', 
                                                    7, 'C', 
                                                    6, 'D', 
                                                    'F') 등급 
 from score;
 
 
 --case : decode 함수를 보완하여 대, 소, like 등이ㅡ 비교처리가 가능한 함수(case ~ end)
 --형식 : case 컬럼이나 값 when 비교값1 then 치환값1 
                                -- when 비교값2 then 치환값2 
                                -- when 비교값3 then 치환값3
                                -- else 기본치 
        -- end 별칭
 
 select name, position, 
        case when position ='정교수' then (pay+nvl(bonus,0))*1.1 
               when position ='조교수' then (pay+nvl(bonus,0))*1.07
               when position ='전임강사' then (pay+nvl(bonus,0))*1.05
               else pay+nvl(bonus,0)
        end 급여
 from professor
 order by 급여 desc;
 
 
 
 --순위를 구하는 함수
 --rank : order by를 포함한 query문에서 특정 컬럼에 대한 순위를 구하는 함수
 --rank() : 중복 순위 다음은 해당 개수만큼 건너뛰고 반환
 --형식
 --rank() over([partition by 컬럼] order by 컬럼)
 --dense_rank() : 중복 순위에 상관없이 순차적으로 반환 (동률순위 무시)
 --row_number() : 중복과 관계없이 무조건 순서대로 반환
 
 --partition by : 순위를 지정하기 위한 컬럼 그룹을 지정함
 
 select deptno 부서번호, ename 이름, sal 급여, rank() over(order by nvl(sal,0) desc) 급여순위 
 from emp;
 
 select deptno 부서번호, ename 이름, sal 급여, 
 rank() over(order by nvl(sal,0) desc) 급여순위1, 
 dense_rank() over(order by nvl(sal,0) desc) 급여순위2, 
 row_number() over(order by nvl(sal,0) desc) 급여순위3
 from emp;
 
 select deptno, ename, sal, 
 rank() over(partition by deptno order by nvl(sal,0) desc) 부서내급여순위
 from emp;
 
 
 
 
 --PL/SQL
 --급여 인상 저장 프로시저로 처리
 
 create or replace procedure update_sal(v_empno in number) --이때 in은 생략 가능함 하지만 in을 써줌으로 인해 입력을 표시 가능
 is --선언부
 begin --실행부, 모든 SQL + 제어문(if, loop, for)
    update emp 
    set sal=sal*1.1 --급여 10% 인상 처리
    where empno=v_empno; --update문, v_empno는 사원번호 입력용 변수
 end; --종료
 /
 
 --저장 프로시져의 실행 방법
 --execute 저장프로시져 이름(입력값)
 
 select * from emp;
 
 execute update_sal(7369);
 
 execute update_sal(7902);
 
 --java에서 저장 프로시져를 호출할 땐 CallableStatement : {call update_sal(7369)} 형식
 
 --한 줄 메모장 저장 프로시져
 --테이블
 create table memo(
 idx number primary key,
 writer varchar2(50) not null,
 memo varchar2(500) not null,
 post_date date default sysdate
 );
 
 --시퀀스
 create sequence memo_seq 
 start with 1 --시작번호 1
 increment by 1 --1씩 증가
 nomaxvalue; --무제한 증가
 
 insert into memo (idx, writer, memo) values (memo_seq.nextval, '홍길동', '메모테슽트1');
 insert into memo (idx, writer, memo) values (memo_seq.nextval, '김길동', '메모테슽트2');
 insert into memo (idx, writer, memo) values (memo_seq.nextval, '장길동', '메모테슽트3');
 
 commit;
 
 select * from memo;
 
 --ip주소를 저장할 수 있는 컬럼 추가
 
 alter table memo add (ip varchar2(50));
 
 --저장 프로시저 생성
 --insert 절이 있는 프로시져 생성
 
 create or replace procedure 
 memo_insert(v_writer in varchar, v_memo in varchar, v_ip in varchar) 
 is 
 begin 
    insert into memo (idx, writer, memo, ip) 
    values (memo_seq.nextval, v_writer, v_memo, v_ip);
 end;
 /
 
 --저장 프로시져 호출
 
 execute memo_insert ('장길동', '메모테슽트4','192.168.0.15');
 
 select * from memo;
 
 commit;
 
 --데이터 사전 조회(저장 프로시져, 사용자 정의 함수..)
 
 select * from user_source 
 where name = 'MEMO_INSERT'; --객체 검색은 무조건 대문자로 (table, procedure, sequence..)
 
 
 --select절 프로시져 생성
 
 create or replace procedure memo_list(v_row out sys_refcursor) 
 is 
 begin 
    open v_row for --open 커서변수, for~select 문장
    select idx, writer, memo, post_date, ip 
    from memo 
    order by idx desc;
 end;
 /
 
 --v_row : 레코드 한 개를 저장할 수 잇는 커서변수
 --out : 출력매개변수(호출한 곳으로 리턴되는 값으로 처리하는 기능)
 --in : 입력매개변수
 --sys_refcursor : 레코드를 한 개씩 조회할 수 있는 자료형(커서), java의 ResultSet과 비슷한 기능
 
 --select절 프로시져의 매개변수 선언
 --형식 : variable 변수이름 데이터타입 or refcursor
 variable a refcursor;
 
 --프로시져 호출 및 실행 형식 : execute 프로시져명( :매개변수)
 --java에서 ?, ?로 값을 받아 처리하는 PrepareStatement와 비슷
 execute memo_list(:a);
 
 --프로시져 출력
 print a;
 
 --데이터 사전 조회
 select * from user_source where name = 'MEMO_LIST';
 
 
 --함수 Function
 
 create or replace function fn_update_sal(v_empno in number) --입력매개변수만 허용
 return number --리턴 자료형
 is 
    v_sal number; --지역변수 선언
 begin 
    update emp 
    set sal = sal*1.1 
    where empno=v_empno;
    select sal into v_sal 
    from emp
    where empno=v_empno;
    return v_sal;  --인상된 금액을 리턴
 end;
 /
 
 commit;
 
 select * from emp;
 
 --함수 실행
 
 select fn_update_sal(7369) from dual; 
 --위 쿼리는 에러 발생 쿼리문 안에 DML(Update, Delete, Insert)이 들어있다는.. select문 안에 DML이 들어있으면 안 됌
 --변수와 대입문을 활용해 처리
 
 var salary number; --변수 생성
 execute :salary := fn_update_sal(7369); --변수에 함수 대입  -  A := B   는 B의 값을 A에 대입, ' := '대입문 만약 A=B로 하면 A와 B는 같다는 뜻
 print salary; --변수로 출력 이런 변수는 바인딩 변수라고도 함(리턴 값을 받는 변수)
 
 select * from emp;
 
 --예) 급여의 200%를 특별 보너스로 출력
 
 create or replace function cal_bonus(v_empno in emp.empno%type) --테이블명.튜플명%타입 = 타입을 지정할 때 테이블의 타입을 가져옴
 return number 
 is 
    v_sal number(7,2); 
 begin 
    select sal into v_sal 
    from emp 
    where empno=v_empno;
    return (v_sal * 2);
 end;
 /
 
 commit;
 
 --바인드변수 선언
 
 variable var_res number;
 
 --저장함수 실행
 execute :var_res := cal_bonus(7521);
 
 --출력
 print var_res;
 
 select * from emp where empno=7521;
 
 --출력문을 print 말고 SQL문으로도 출력 가능
 
 select sal, cal_bonus(7521) 특별보너스
 from emp 
 where empno=7521;
 
 
 
 --PL/SQL 제어문
 --%type
 
 create or replace procedure emp_info(p_empno in emp.empno%type) 
 is --변수 선언
    v_empno emp.empno%type;
    v_ename emp.ename%type;
    v_sal emp.sal%type;
 begin --실행문
    --select 필드 into 변수 : 필드의 값을 변수에 저장
    select empno, ename, sal into v_empno, v_ename, v_sal
    from emp 
    where empno = p_empno;
     --dbms_output.put_line(출력문) : java의 sysout과 같은 느낌
     --dbms_output 패키지의 put_line함수 호출
      dbms_output.put_line('사번 : ' || v_empno); 
      dbms_output.put_line('이름 : ' || v_ename);
      dbms_output.put_line('급여 : ' || v_sal);
 end;
 /
 
 set serveroutput on;   --서버의 dbms_output 패키지 enable
 
 execute emp_info(7369);
 
 
 
 --if문
 --형식
 -- if 조건 then
 -- statements
 -- elsif 조건 then
 -- statements
 -- esle 
 -- statements
 -- end if;
 
 create or replace procedure dept_search (p_empno in number) 
 is
    v_deptno number;
 begin 
    select deptno into v_deptno 
    from emp 
    where empno = p_empno;
        dbms_output.put_line('부서코드 : ' || v_deptno);
    if v_deptno = 10 then
        dbms_output.put_line('경리팀 사원입니다.');
    elsif v_deptno = 20 then
        dbms_output.put_line('연구팀 사원입니다.');
    elsif v_deptno = 30 then 
        dbms_output.put_line('총무팀 사원입니다.');
    else 
        dbms_output.put_line('기타부서 사원입니다.');
    end if;
 end;
 /
 
 execute dept_search(7369);
 
 select empno, ename, dname 
 from emp e, dept d 
 where e.deptno = d.deptno and empno = 7369;
 --위 SQL을 procedure로 만든 것.
 
 
 
 
 --반복문
 --FOR 루프
 --형식 : 
 -- for index in [reverse] 시작값... end값 loop
 --     statements
 -- end loop
 
 --무명블록
 declare --선언부
    --사용자 정의 자료형, type 자료형 이름 is ...
    type ename_table is table of emp.ename%type index by binary_integer;
    --급여만 저장할 테이블 생성
    type sal_table is table of emp.sal%type index by binary_integer;
    ename_tab ename_table;-- 변수명(ename_tab) 자료형 (ename_table) 마치 자바의 객채와 같이..
    sal_tab sal_table; 
    i binary_integer := 0; --i에 0을 대입
 begin --실행부
    --for 커서변수 in 집합 loop
    for emp_row in (select ename, sal from emp) loop 
    i := i+1;   --i값 증가
    ename_tab(i) := emp_row.ename; -- 테이블의 i인덱스에 값 저장
    sal_tab(i) := emp_row.sal;
 end loop;
 --for 인덱스변수 in 시작..종료 loop
 for cnt in 1 .. i loop
    dbms_output.put('이름 : ' || ename_tab(cnt) || ', ' );
    dbms_output.put_line('급여 : ' || sal_tab(cnt));
 end loop;
 end;
 /
 
 set serveroutput on;
    
    
 --Loop
 declare
    v_cnt number := 9010;
 begin
    loop
        v_cnt := v_cnt+1;
        insert into emp (empno, ename, hiredate) values (v_cnt, ' test ' || v_cnt, sysdate);
        exit when v_cnt >= 9100;
    end loop;
    --dbms_output.put('개의 레코드가 입력되었습니다.');
 end;
 /
 
 select * from emp;
 
 delete from emp where empno >= 9050;
 
 --조건이 true일때 반복되는 루프
 declare 
    cnt number := 9050;
 begin
    while cnt < 9060 loop
        insert into emp (empno, ename, hiredate) values (cnt, 'test' || cnt, sysdate);
        cnt := cnt+1;
    end loop;
    dbms_output.put_line(cnt-9050 || ' 개의 레코드가 입력되었습니다.');
 end;
 /
 
 select * from emp;
 
 
 --커서(Corsor)
 --암시적 커서
 --SQL%ROWCOUNT : 해당 SQL문에 영향을 받는 행의 수
 --SQL%FOUND : 해당 SQL 영향을 받는 행의 수가 1개 이상일 경우 TRUE
 --SQL%NOTFOUND : 해당 SQL 영향을 받는 수가 없을 경우 TRUE
 --SQL%ISOPEN : 항상 FALSE, 암시적 커서가 열려있는지 여부 검색
 --커서 열기(OPEN)
 --OPEN corsor_name;
 --커서 패치(FETCH) : 현재 레코드를 OUTPUT 변수에 저장(한 라인씩, 커서의 SELECT문의 컬럼수와 OUTPUT변수의 수와 데이터 타입이 같아야함)
 --FETCH cursor_name INTO variable1, variable2;
 --커서 닫기(CLOSE) : 사용을 마친 커서는 반드시 닫아야.., 커서를 닫은 후 FETCH 할 수 없음
 --CLOSE corsor_name;
 
 create or replace procedure cursor_test(p_empno in number)
 is
    v_sal number;
    v_update_row number;
    v_update_sal number;
    v_name varchar2(50);
 begin
    select sal into v_sal from emp where empno = p_empno;
    if sql%found then
        dbms_output.put_line('급여 : ' || v_sal);
    end if;
    update emp set sal = sal*1.1 where empno = p_empno;
    select sal into v_update_sal from emp where empno = p_empno;
    select ename into v_name from emp where empno = p_empno;
    v_update_row := sql%rowcount;
    dbms_output.put_line('급여가 인상된 사원 수 : ' || v_update_row);
    dbms_output.put_line('급여가 인상된 사원 이름 : ' || v_name);
    dbms_output.put_line('인상된 급여 : ' || v_update_sal);
    exception --예외처리
        when NO_DATA_FOUND then 
            dbms_output.put_line('잘못된 사번입니다.');
        when others then
            dbms_output.put_line('[SYSTEM] 에러'); 
 end;
 /
 
 select * from emp;
 
 execute cursor_test(7499);
 
 --대표적 oracle 예외상황 : 
 --too_many_rows : 너무 많은 행이 리턴될 경우
 --invalid_cursor : 잘못된 커서 사용
 --zero_divide : 0으로 나눌 경우
 --dup_val_on_index : unique 제약 조건을 위반할 경우
 
 
 --명시적 커서
 --cursor 커서변수이름 is select문장(레코드 집합을 한 개의 레코드 씩 읽을 때 사용)
 
 create or replace procedure cursor_test2(v_deptno number)
 is
    cursor dept_avg is 
    select dname, count(empno) cnt, round(avg(sal),1) salary 
    from emp e, dept d 
    where e.deptno = d.deptno
    group by dname;
        v_name varchar(50);
        emp_cnt number;
        sal_avg number;
 begin 
    open dept_avg;  --커서 오픈
    fetch dept_avg into v_name, emp_cnt, sal_avg;   --레코드에 저장
    dbms_output.put_line('부서명 : ' || v_name);
    dbms_output.put_line('사원수 : ' || emp_cnt);
    dbms_output.put_line('평균급여 : ' || sal_avg);
    close dept_avg; --커서 닫기
 end;
 /
 
 execute cursor_test2(10);
 
 --위 프로시져에 루프
 
 create or replace procedure cursor_test3 
 is 
    cursor dept_avg is
    select dname, count(empno) cnt, round(avg(sal),1) salary 
    from emp e, dept d 
    where e.deptno = d.deptno
    group by dname;
 begin 
    for emp_row in dept_avg loop
        dbms_output.put_line('부서명 : ' || emp_row.dname);
        dbms_output.put_line('사원수 : ' || emp_row.cnt);
        dbms_output.put_line('평균급여 : ' || emp_row.salary);
    end loop;
 end;
 /
 
 execute cursor_test3;
 
 
 --Trigger 트리거 : DB에서 연쇄적인 동작을 정의
 --프로시져는 사용자가 직접 execute해야하지만 트리거는 테이블의 데이터가 변경 될 때 자동으로 수행되며 사용자가 직접 수행 불가능
 --insert update delete 문이 실행 될 때 묵시적으로 수행되는 프로시져
 --테이블에만 정의 가능. 즉 view에는 사용 불가능
 --before trigger : dml 실행 전 실행
 --after trigger : dml 실행 후 실행
 --for each row : 행 트리거 : 컬럼의 각 행의 변화가 생길 때 마다 실행, 문장 트리거 : 1회만 실행
 
 create or replace trigger sum_trigger 
 after --전이면 before
    insert or update or delete on emp   --emp에서 dml 작업 후 실행
 declare
    avg_sal number;
 begin --자동으로 호출
    select avg(sal) into avg_sal from emp;
    dbms_output.put_line('급여 평균 : ' || avg_sal);
 end;
 /
 

 --현재 평균 급여 400
 select avg(sal) from emp;
 
 --dml 실행
 insert into emp (empno, ename, hiredate, sal) values (3002, '홍철수', sysdate, 500);
 
 update emp set sal=700 where empno = 3002;
 
 --delete from emp where empno = 3002;
 
 
 commit; 
 
 
 --백업(exp), 복원(imp)
 
 select * from lecture;
 
 drop table lecture;
 
 select * from lecture;
 
 commit;