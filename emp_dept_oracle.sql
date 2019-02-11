-- ������̺�(emp), �μ����̺�(dept) join 
-- ��� ���̺�
select * from emp;
--�μ� ���̺�
select * from dept;

--���̺� (join)
--Oracle ����
select empno, ename, dname from emp e, dept  d where e.deptno=d.deptno;

--ANSI ����
select empno, ename, dname from emp e join dept d on e.deptno = d.deptno;

--0918������ ���� ������ �÷��� ���� ���. �ذ���� �Ʒ� ����
select empno, ename, e.deptno, dname from emp e, dept d where e.deptno = d.deptno;

select empno, ename, e.deptno, dname from emp e, dept d where e.deptno = d.deptno and e.deptno=30;