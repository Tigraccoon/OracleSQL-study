
--문제 1

select deptno 사원번호, count(*) 직원수, sum(sal) 급여합계, round(avg(sal), 2) 급여평균, min(sal) 최저급여, max(sal) 최대급여 
 from emp  
 group by deptno
 order by deptno;
 
 
 --문제 2
 
 select ename 이름 from emp where ename like '_철%';
 
 
 --문제 3
 select empno 사원번호, ename 이름, hiredate 입사일, hiredate+90 입사후90일 from emp;
 
 
 --문제 4
  select deptno 학과, name 이름, pay 급여, bonus 보너스, (pay*12+nvl(bonus, 0)) 연봉 
 from professor 
 where deptno = 101;
 
 
 --문제 5
 
 select ename 이름, job 직위, lpad(sal, 5, '*') sal 
 from emp 
 where sal >= 300
 order by sal;
 
 
 --문제 6
 
 select ename 이름, trunc(months_between(sysdate, hiredate)) 근무개월수
 from emp
 where months_between(sysdate, hiredate) >= 100;