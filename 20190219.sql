

--���� 1

select e.empno, d.dname 
 from emp e, dept d 
 where e.deptno = d.deptno;
 
 select * from emp;
 
 select * from dept;
 
 
 --���� 2
 
 select s.name, s.deptno1, d.dname 
 from student s join department d 
 on s.deptno1 = d.deptno;
 
 
 --���� 3 ���� ������ ���� �л�
 
 select s.name sname, p.name pname 
 from student s, professor p
 where s.profno = p.profno(+) 
 order by sname;
 
 --���� �л��� ���� ����
 
 select s.name sname,  p.name pname 
 from student s, professor p
 where s.profno(+) = p.profno 
 order by sname;
 
 
 --�ǽ� ���� 1 :  emp, dept���̺��� �����ؼ� �μ���ȣ(deptno), �μ���(dname), �̸�(ename), �޿�(sal)�� ��� (Oracle, ANSI)
 
 --Oracle
 
 select e.deptno �μ���ȣ, d.dname �λ��, e.ename �̸�, e.sal 
 from emp e, dept d
 where e.deptno = d.deptno;
 
 --ANSI
 
 select e.deptno �μ���ȣ, d.dname �μ���, e.ename �̸�, e.sal 
 from emp e join dept d 
 on e.deptno = d.deptno;
 
 
 --�ǽ� ���� 2 : ��å(job)�� '���'�� �̸�, �μ���ȣ, �μ��̸��� ��� (Oracle, ANSI)
 
 --Oracle
 
 select e.ename �̸�, e.deptno �μ���ȣ, d.dname �μ���, e.job ��å
 from emp e, dept d 
 where e.deptno = d.deptno and e.job = '���';
 
 --ANSI
 
 select e.ename �̸�, e.deptno �μ���ȣ, d.dname �μ���, e.job ��å 
 from emp e join dept d 
 on e.deptno = d.deptno and e.job = '���';
 
 
 --�ǽ� ���� 3 : �̸��� Ȳ������ ����� �μ����� ��� (Oracle, ANSI)
 
 --Oracle
 select e.ename �̸�, d.dname �μ��� 
 from emp e, dept d 
 where e.deptno = d.deptno and e.ename = 'Ȳ����';
 
 --ANSI
 select e.ename �̸�, d.dname �μ��� 
 from emp e join dept d 
 on e.deptno = d.deptno and e.ename = 'Ȳ����';
 
 --�ǽ� ���� 4 : emp, dept ���̺� ����, ��� ����� �̸�, �μ���ȣ, �μ���, �޿��� ��� (Oracle, ANSI)
 select * from emp;
 select * from dept;
 --Oracle
 select e.ename �̸�, e.deptno �μ���ȣ, d.dname �μ���, e.sal*12+nvl(e.comm,0) �޿� 
 from emp e, dept d
 where e.deptno = d.deptno;
 
 --ANSI
 select e.ename �̸�, e.deptno �μ���ȣ, d.dname �μ���, e.sal*12+nvl(e.comm,0) �޿� 
 from emp e join dept d 
 on e.deptno = d.deptno;
 
 
 --�ǽ� ���� 5 : emp���̺� �ִ� empno, mgr�� �̿��Ͽ� ������ ���踦 ������ ���� ��� (Oracle, ANSI)
 --    "�������� �Ŵ����� ��äȣ�̴�."
 
 --Oracle
 select a.ename || '�� �Ŵ����� ' || b.ename || '�̴�.' �Ŵ����� 
 from emp a, emp b 
 where a.mgr = b.empno;
 
 --ANSI
 select a.ename || '�� �Ŵ����� ' || b.ename || '�̴�.' �Ŵ����� 
 from emp a join emp b 
 on a.mgr = b.empno;