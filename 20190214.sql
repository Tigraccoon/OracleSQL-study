--���� 1 dept ���̺��� deptno �μ��ڵ�, dname �μ��̸�, loc ������ ��Ī�� �Ἥ ����� �ϵ� deptno�� ������������ ���

select deptno �μ��ڵ�, dname �μ��̸�, loc ������ from dept order by �μ��ڵ� asc;


--����2 student ���̺��� name �̸�, jumin �ֹι�ȣ, tel ����ó ��Ī�� ���� name�� ������������ ���

select name �̸�, jumin �ֹι�ȣ, tel ����ó from student order by name desc;


--����3 �޿��� 100 �̻��̰� �޿��� 400 ������ ���� �˻�(�޿� ��������)

select * from emp where sal between 100 and 400 order by sal desc;


--����4 any �����ڸ� ����Ͽ� sal�� 300�̻��� ������ ���(�޿��� ��������)

select deptno, sal, ename from emp where sal >= any(300) order by sal desc;


--����5 ��Ȯ�� ���� ° ���ڿ� 'ȣ'�� �� ����� �˻�

select ename from emp where ename like '__ȣ' order by ename;


--����6 nvl�Լ� Ȱ�� empno �����ȣ, ename �̸�, sal �޿�, comm ���ʽ�, ������ ����ϵ� ������ ���ؼ� �������� ���

select empno �����ȣ, ename �̸�, sal �޿�, comm ���ʽ�, sal*12+nvl(comm, 0) ���� from emp order by ���� asc;





