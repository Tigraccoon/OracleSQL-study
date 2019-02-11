-- 사원테이블(emp), 부서테이블(dept) join 
-- 사원 테이블
select * from emp;
--부서 테이블
select * from dept;

--테이블 (join)
--Oracle 문법
select empno, ename, dname from emp e, dept  d where e.deptno=d.deptno;

--ANSI 문법
select empno, ename, dname from emp e join dept d on e.deptno = d.deptno;

--0918에러가 나는 이유는 컬럼이 같을 경우. 해결법은 아래 참조
select empno, ename, e.deptno, dname from emp e, dept d where e.deptno = d.deptno;

select empno, ename, e.deptno, dname from emp e, dept d where e.deptno = d.deptno and e.deptno=30;