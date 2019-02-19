

--문제 1

select e.empno, d.dname 
 from emp e, dept d 
 where e.deptno = d.deptno;
 
 select * from emp;
 
 select * from dept;
 
 
 --문제 2
 
 select s.name, s.deptno1, d.dname 
 from student s join department d 
 on s.deptno1 = d.deptno;
 
 
 --문제 3 지도 교수가 없는 학생
 
 select s.name sname, p.name pname 
 from student s, professor p
 where s.profno = p.profno(+) 
 order by sname;
 
 --지도 학생이 없는 교수
 
 select s.name sname,  p.name pname 
 from student s, professor p
 where s.profno(+) = p.profno 
 order by sname;
 
 
 --실습 문제 1 :  emp, dept테이블을 조인해서 부서번호(deptno), 부서명(dname), 이름(ename), 급여(sal)을 출력 (Oracle, ANSI)
 
 --Oracle
 
 select e.deptno 부서번호, d.dname 부사명, e.ename 이름, e.sal 
 from emp e, dept d
 where e.deptno = d.deptno;
 
 --ANSI
 
 select e.deptno 부서번호, d.dname 부서명, e.ename 이름, e.sal 
 from emp e join dept d 
 on e.deptno = d.deptno;
 
 
 --실습 문제 2 : 직책(job)이 '사원'인 이름, 부서번호, 부서이름을 출력 (Oracle, ANSI)
 
 --Oracle
 
 select e.ename 이름, e.deptno 부서번호, d.dname 부서명, e.job 직책
 from emp e, dept d 
 where e.deptno = d.deptno and e.job = '사원';
 
 --ANSI
 
 select e.ename 이름, e.deptno 부서번호, d.dname 부서명, e.job 직책 
 from emp e join dept d 
 on e.deptno = d.deptno and e.job = '사원';
 
 
 --실습 문제 3 : 이름이 황인태인 사원의 부서명을 출력 (Oracle, ANSI)
 
 --Oracle
 select e.ename 이름, d.dname 부서명 
 from emp e, dept d 
 where e.deptno = d.deptno and e.ename = '황인태';
 
 --ANSI
 select e.ename 이름, d.dname 부서명 
 from emp e join dept d 
 on e.deptno = d.deptno and e.ename = '황인태';
 
 --실습 문제 4 : emp, dept 테이블 조인, 모든 사원의 이름, 부서번호, 부서명, 급여을 출력 (Oracle, ANSI)
 select * from emp;
 select * from dept;
 --Oracle
 select e.ename 이름, e.deptno 부서번호, d.dname 부서명, e.sal*12+nvl(e.comm,0) 급여 
 from emp e, dept d
 where e.deptno = d.deptno;
 
 --ANSI
 select e.ename 이름, e.deptno 부서번호, d.dname 부서명, e.sal*12+nvl(e.comm,0) 급여 
 from emp e join dept d 
 on e.deptno = d.deptno;
 
 
 --실습 문제 5 : emp테이블에 있는 empno, mgr을 이용하여 서로의 관계를 다음과 같이 출력 (Oracle, ANSI)
 --    "박진성의 매니저는 임채호이다."
 
 --Oracle
 select a.ename || '의 매니저는 ' || b.ename || '이다.' 매니저는 
 from emp a, emp b 
 where a.mgr = b.empno;
 
 --ANSI
 select a.ename || '의 매니저는 ' || b.ename || '이다.' 매니저는 
 from emp a join emp b 
 on a.mgr = b.empno;