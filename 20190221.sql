

--���� 1 : ������� ��� ���޺��� ���� �޿��� �޴� ����� �̸�, �μ���, �޿��� ��ȸ

select * from emp;
select * from dept;

 select e.ename �̸�, d.dname �μ���, e.sal �޿� 
 from emp e, dept d 
 where e.deptno=d.deptno 
 and e.sal > (select avg(sal) from emp e2); 
 
 
 --���� 2 : ��å�� ����� ������� � �μ����� �ٹ��ϴ��� ����� �̸�, ��å, �μ��̸��� ���
 
 select e.ename �̸�, e.job ��å, d.dname �μ��̸� 
 from (select ename, job, deptno from emp where job='���' ) e, dept d 
 where e.deptno=d.deptno;
 
 
 --�ǽ� ���� 1 : professor, department ���̺��� ����ؼ� �۵��Ǳ������� ���߿� �Ի��� ����� �̸�, �Ի���, �а����� ���
 
 select * from professor;
 
 --1)
 select name, hiredate, dname 
 from professor p, department d 
 where p.deptno = d.deptno;
 
 --2)
 select name, hiredate, dname 
 from professor p, department d 
 where p.deptno = d.deptno and hiredate > 
 (select hiredate from professor where name = '�۵���');
 
 
 --�ǽ� ���� 2 : �ɽ� ������ ���� �Ի��Ͽ� �Ի��� ���� �߿��� ������ �������� �޿��� ���� �޴� ������ �̸�, �޿�, �Ի����� ���
 
 select name, pay, hiredate 
 from professor
 where pay < 
 (select pay from professor where name = '������')
 and hiredate = (select hiredate from professor where name = '�ɽ�');
 
 
 -- �ǽ� ���� 3 : �� �г⺰�� ���� Ű�� ū �л����� �г�� �̸� Ű�� ���
 
 select * from student;
 
 select grade, name, height 
 from student s
 where height = (select max(height) from student where grade = s.grade);
