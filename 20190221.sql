

--문제 1 : 사원들의 평균 월급보다 많은 급여를 받는 사원의 이름, 부서명, 급여를 조회

select * from emp;
select * from dept;

 select e.ename 이름, d.dname 부서명, e.sal 급여 
 from emp e, dept d 
 where e.deptno=d.deptno 
 and e.sal > (select avg(sal) from emp e2); 
 
 
 --문제 2 : 직책이 사원인 사람들이 어떤 부서에서 근무하는지 사원의 이름, 직책, 부서이름을 출력
 
 select e.ename 이름, e.job 직책, d.dname 부서이름 
 from (select ename, job, deptno from emp where job='사원' ) e, dept d 
 where e.deptno=d.deptno;
 
 
 --실습 문제 1 : professor, department 테이블을 사용해서 송도권교수보다 나중에 입사한 사람의 이름, 입사일, 학과명을 출력
 
 select * from professor;
 
 --1)
 select name, hiredate, dname 
 from professor p, department d 
 where p.deptno = d.deptno;
 
 --2)
 select name, hiredate, dname 
 from professor p, department d 
 where p.deptno = d.deptno and hiredate > 
 (select hiredate from professor where name = '송도권');
 
 
 --실습 문제 2 : 심슨 교수와 같은 입사일에 입사한 교수 중에서 조인형 교수보다 급여를 적게 받는 교수의 이름, 급여, 입사일을 출력
 
 select name, pay, hiredate 
 from professor
 where pay < 
 (select pay from professor where name = '조인형')
 and hiredate = (select hiredate from professor where name = '심슨');
 
 
 -- 실습 문제 3 : 각 학년별로 가장 키가 큰 학생들의 학년과 이름 키를 출력
 
 select * from student;
 
 select grade, name, height 
 from student s
 where height = (select max(height) from student where grade = s.grade);
