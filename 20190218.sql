
--���� 1

select deptno �����ȣ, count(*) ������, sum(sal) �޿��հ�, round(avg(sal), 2) �޿����, min(sal) �����޿�, max(sal) �ִ�޿� 
 from emp  
 group by deptno
 order by deptno;
 
 
 --���� 2
 
 select ename �̸� from emp where ename like '_ö%';
 
 
 --���� 3
 select empno �����ȣ, ename �̸�, hiredate �Ի���, hiredate+90 �Ի���90�� from emp;
 
 
 --���� 4
  select deptno �а�, name �̸�, pay �޿�, bonus ���ʽ�, (pay*12+nvl(bonus, 0)) ���� 
 from professor 
 where deptno = 101;
 
 
 --���� 5
 
 select ename �̸�, job ����, lpad(sal, 5, '*') sal 
 from emp 
 where sal >= 300
 order by sal;
 
 
 --���� 6
 
 select ename �̸�, trunc(months_between(sysdate, hiredate)) �ٹ�������
 from emp
 where months_between(sysdate, hiredate) >= 100;