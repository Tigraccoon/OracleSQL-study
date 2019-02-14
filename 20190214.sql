--문제 1 dept 테이블에서 deptno 부서코드, dname 부서이름, loc 지역명 별칭을 써서 출력을 하되 deptno를 오름차순으로 출력

select deptno 부서코드, dname 부서이름, loc 지역명 from dept order by 부서코드 asc;


--문제2 student 테이블에서 name 이름, jumin 주민번호, tel 연락처 별칭을 쓰되 name을 내림차순으로 출력

select name 이름, jumin 주민번호, tel 연락처 from student order by name desc;


--문제3 급여가 100 이상이고 급여가 400 이하인 직원 검색(급여 내림차순)

select * from emp where sal between 100 and 400 order by sal desc;


--문제4 any 연산자를 사용하여 sal이 300이상인 직원들 출력(급여를 내림차순)

select deptno, sal, ename from emp where sal >= any(300) order by sal desc;


--문제5 정확히 세번 째 문자에 '호'가 들어간 사람을 검색

select ename from emp where ename like '__호' order by ename;


--문제6 nvl함수 활용 empno 사원번호, ename 이름, sal 급여, comm 보너스, 연봉을 계산하되 연봉에 대해서 오름차순 출력

select empno 사원번호, ename 이름, sal 급여, comm 보너스, sal*12+nvl(comm, 0) 연봉 from emp order by 연봉 asc;





