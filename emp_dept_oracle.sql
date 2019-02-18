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
 