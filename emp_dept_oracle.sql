--hr���� Ȱ��ȭ��� (system�������� �α��� ��)
alter user hr identified by hr account unlock;


-- ������̺�(emp), �μ����̺�(dept) join 
-- ��� ���̺�
select * from EMP;
--�μ� ���̺�
select * from dept;

--����Ŭ�� SQL
--���̺� ����(join)
select empno, ename, dname
from emp e, dept d 
where e.deptno=d.deptno;

--ANSI SQL(ǥ�� SQL)
select empno, ename, dname
from emp e join dept d
 on e.deptno=d.deptno;

--����(deptno�� ���̺� ��������)
select empno, ename, deptno, dname
from emp e, dept d
where e.deptno=d.deptno;

--deptno�� emp���̺� ����ó��
select empno, ename, e.deptno, dname
from emp e, dept d
where e.deptno=d.deptno;

--�μ��ڵ尡 30���� ������ ���
select empno, ename, e.deptno, dname
from emp e, dept d
where e.deptno=d.deptno and e.deptno=30 order by ename;

--[����] ����(job)�� ����� ������ ���
select empno, ename, job, e.deptno, dname
from emp e, dept d
where e.deptno=d.deptno and e.job='���' order by empno desc;

-- order by ���ı����÷�
-- order by �÷� desc(��������), asc(��������-�⺻)

--���,�̸�,����,�Ի�����,�޿�,�μ��̸�
select empno,ename,job,hiredate,sal,dname
from emp e, dept d
where e.deptno=d.deptno and ename like '%ö%';

select * from dept order by dname;

--���̺� ����
desc emp;

--emp���̺� ������ ����(�������� not null, pk�� �� ���ܵ� ���¿��� �����)
create table emp_copy as select * from emp where 1=0;

desc emp_copy;

select * from emp_copy;

--���̺� ���� drop tabale ���̺��̸�
drop table emp_copy;

select count(*) from emp;

--�л����̺�
select * from student;

--�а� ���̺�
select * from department;

--���� ���̺�
select * from professor;

--�̸�,�а��ڵ�,�а���
select name, deptno1, dname
from student, department
where student.deptno1 = department.deptno;

--[����] ���̺��� ��Ī�� Ȱ���ؼ� �̸�,�а��ڵ�,�а����� ���
select name, deptno1, dname
from student s, department d
where s.deptno1 = d.deptno;

--[����] ANSI SQL(ǥ��SQL) ������� �� sql���� ����
select name, deptno1, dname
from student s join department d
on s.deptno1 = d.deptno;

-- �л��̸�,�а��ڵ�,�а���,���������̸�
select s.name, deptno1, dname, p.name
from student s, department d, professor p
where s.deptno1=d.deptno and s.profno=p.profno;

--[����] ANSI SQL(ǥ��SQL) ������� �� sql���� ����
select s.name, deptno1, dname, p.name
from student s join department d on s.deptno1=d.deptno
join professor p on s.profno=p.profno;

-- ���ݱ����� inner join��(�����̺� ��� �����Ͱ� �ִ� ���)
-- outer join�� ���ʿ��� �ڷᰡ �ִµ� ���ʿ��� �ڷᰡ ���� �� �ϴ� ���

-- subject(����) ���̺� ����
-- �ٸ����̺��� pk�� �����ͼ� key�� ���� ���� fk �ܷ�Ű��� ��
create table subject(
subject_code number not null primary key,
subject_name varchar2(50) not null,
profno number not null,
point number default 3
);

insert into subject values(1,'java',1001,3);
insert into subject values(2,'db',1002,4);
insert into subject values(3,'jsp',1003,2);
insert into subject (subject_code, subject_name, profno) 
values(4,'�ȵ���̵�',1001);

commit;

select * from subject;

-- �����ڵ�, �����, ��米����, ����
select subject_code, subject_name, name, point
from subject s, professor p
where s.profno=p.profno;

[����] ���ڵ带 ANSI SQL�� ��ȯ
select subject_code, subject_name, name, point
from subject s join professor p
 on s.profno=p.profno;

-- ���� ���̺�
create table lecture (
studno number not null,
subject_code number not null,
grade varchar(2),
primary key(studno, subject_code) --����Ű 
);

insert into lecture values (9411, 1, 'A0');
insert into lecture values (9411, 2, 'A+');
insert into lecture values (9411, 3, 'B0');
insert into lecture values (9412, 3, 'C0');
insert into lecture values (9412, 4, 'F');
insert into lecture values (9413, 2, 'B+');
insert into lecture values (9413, 3, 'A+');

commit;

select * from lecture;

--�й�, �̸�, �����, ����, ���
--�л�(studno) - ����(studno)
--����(subject_code) - ����(subject_code)
--����(profno) - ����(profno)
select st.studno, st.name sname, sb.subject_name, p.name pname, sb.point, l.grade
 from student st, lecture l, subject sb, professor p
 where st.studno=l.studno 
 and l.subject_code=sb.subject_code 
 and p.profno=sb.profno;

--alter table ���̺��̸� add �÷� �ڷ���(������);
--student ���̺� img_path��� �÷��� �߰�
alter table student add img_path varchar2(500);

commit;


--A���ڿ� || B���ڿ�  => ����
select (studno || '  ' || name) name from student;

--�й�, �̸�, �а��ڵ�, �а���, �����������, ���������̸�, ��ȭ, �������
--student, department, professor ���̺� ����
--�л�(deptno1) - �а�(deptno)
--�л�(profno) - ����(profno)
select s.studno, s.name sname, d.deptno, d.dname, p.profno, p.name pname, s.tel, s.img_path 
 from student s, department d, professor p 
 where s.deptno1 = d.deptno 
 and s.profno = p.profno;
 and s.studno = 9711;

--9711�л� ���� ���� ���������� ���� �������� �ʾ� ������ ����� �ȵȴ�. ���� outer join�� �ؾ��Ѵ�.

--�л� ��
select count(*) from student;

--������ �л� ��
select count(*) from student where profno is null;

--outer join ���(�ش� �����Ͱ� ������ ������ �����ʹ� ��°����ϰ� ����)
select studno,s.name sname,p.name pname from student s, professor p 
 where s.profno = p.profno(+); --(+) �߰�

--�������� ex)
select st.studno, st.name sname, sb.subject_name, p.name pname, sb.point, l.grade
 from student st, lecture l, subject sb, professor p
 where st.studno=l.studno 
 and l.subject_code=sb.subject_code 
 and p.profno=sb.profno
 and st.studno = 9411;

select * from emp;

select empno,ename,sal from emp where sal >= 300;

--distinct : �ߺ� �����ʹ� ��� �� ��
select distinct job from emp;

--all : �ߺ� ������ ���
select all job from emp;

--order by : ���� - asc(��������, default), desc(��������)

select * from emp order by sal desc;

--���� ���� ����. ���� ������ �켱�̸� �ߺ��� ��� ���� ������ ����
select * from emp order by job asc, sal desc;


select * from emp order by hiredate asc, sal desc;


-- alias : ��Ī

select ename �̸�, job �����ڵ�, sal �޿� from emp order by �����ڵ�, �޿� desc;


--where : �˻��� ������ �ο�

select * from emp where sal > 100 and sal < 400 order by sal desc;

select * from emp
 where sal > 100 and sal < 400
 order by sal desc;


-- ������
--��� ������ : +, -, *, /
--�� ������ : =, !=, <, <=, >, >=
--�� ������ : and, or, not

 select * from emp where not (sal between 200 and 300) order by sal desc; 
 select * from emp where not (sal >= 200 and sal <= 300) order by sal desc;


--SQL������ : in, any, all, between, like, is null, is not null

select deptno, sal, ename from emp where deptno=10 or deptno=20 or deptno=30 order by deptno desc;


--in (����) ������ ��� �� �� �� �̻��� �ش�Ǹ� ����

select deptno, sal, ename from emp where deptno in(10,20,30) order by deptno;


--any�� in�� ������ �پ��� �����ڸ� ����� �� ����

select deptno, sal, ename from emp where deptno = any(10,20,30) order by deptno;

select deptno, sal, ename from emp where sal > any(200,300,400) order by sal;

select deptno, sal, ename from emp where sal = any(200,300,400,500,600) order by sal;

select deptno, sal, ename from emp;

select deptno, sal, ename from emp where ename like '��%' order by ename;

select deptno, sal, ename from emp where ename like '%ö%' order by ename;

-- '_'�� ���� ���� ���� ��Ÿ��

select deptno, sal, ename from emp where ename like '_ö%' order by ename;


--Ŀ�̼� null�� ���ڵ� ���(���� : = �� ���� �� �ȴ�)

select * from emp where comm is null order by deptno;


--Ŀ�̼��� null�� �ƴ� ���ڵ�(���� : is not ��� >, < ���� ���� �� �ȴ�)

select * from emp where comm is not null order by deptno;


--���� ��� �� comm�� null�� ����� ����� �� �ǰ� ���

select empno, ename, sal, comm, sal*12+comm ���� from emp; 


--nvl(A, B) A�� ���� null�̸� B, null�� �ƴϸ� A

select empno, ename, sal, comm, sal*12+nvl(comm,0) ���� from emp; 






