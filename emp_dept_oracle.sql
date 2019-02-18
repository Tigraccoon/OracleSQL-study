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


--���� ������ : ||
--������ ������ ��¥�� ������ ��쿡�� ���� ����ǥ( ', " )�� ����
--�� ����� �޿��� �˻� '������ �޿��� ���Դϴ�' �÷����� ���� ���

select ename || ' �� ������ ' || sal || '�Դϴ�.' ���� from emp;

select ename || '�� ������ ' || (sal*12+nvl(comm,0)) || '�Դϴ�.' ���� from emp;


--������ �켱���� ��ȣ() : ������ �켱�������� ���� ����
--  1���� : �� ������, SQL������, ��� ������
--  2���� : not
--  3���� : and
--  4���� : or
--  5���� : ���� ������

--emp ���̺��� �Ի���(hiredate)�� 2005�� 1�� 1�� ������ �����?

select ename �̸�, hiredate �Ի���, deptno �μ���ȣ 
 from emp 
 where hiredate <= '2005.01-01'     --����� ������ . �̳� - �� ���
 order by �Ի���;
 
 
 --emp ���̺��� �μ���ȣ�� 20�� �Ǵ� 30���� �μ��� ���� ����� ���(�̸� ��������)
 
select ename �̸�, job ��å, deptno �μ���ȣ 
 from emp
 where deptno in(20,30)     -- �Ǵ� deptno = 20 or deptno = 30
 order by �̸�;

select ename �̸�, job ��å, deptno �μ���ȣ 
 from emp
 where deptno = any(20,30)     -- �Ǵ� deptno = 20 or deptno = 30
 order by �̸�;


--conunt()�Լ� : ���ڵ� ����

select count(*) from emp;


--sum() �Լ� : ���ڵ� �հ�

select sum(sal) from emp;


--avg() �Լ� : ���ڵ� ���
--rount(A, B)�Լ� : A - ���, B - �Ҽ��� �ڸ��� 

select round(avg(sal), 2) from emp;


--min() �Լ� : �ּҰ�

select min(sal) from emp;


--max()�Լ� : �ִ밪

select max(sal) from emp;


--�μ��� �����ȣ, ������, �޿��հ�, �޿����, �����޿�

select deptno �����ȣ, count(*) ������, sum(sal) �޿��հ�, round(avg(sal), 2) �޿����, min(sal) �����޿�, max(sal) �ִ�޿� 
 from emp  
 group by deptno
 order by deptno;


--���� �� �Լ�
--���� �Լ�
--  chr(�ƽ�Ű�ڵ�) : �ش� �ƽ�Ű �ڵ尪�� ���� ���� ��ȯ

select chr(65) from dual;
--dual : ���� ���̺�(����Ŭ������ select���� �ݵ�� from�� �ٿ��� �ϱ� ������ dual�̶�� ������ ���� ���̺��� ���

--sysdate : ���� �ð�
--MySQL������ now() �Լ��� ���. ex) select now(); �� from�� ���� �ٷ� ��� ����

select sysdate from dual;


--ascii(����) : ������ �ƽ�Ű �ڵ尪�� ��ȯ

select ascii('A') from dual;


--concat(�÷���, '���ڿ�') : �÷��� �ش��ϴ� ���ڿ��� ����, ���� �����ڿ� ���� ���� A || B

select concat(ename, '�� ��å�� ') ������, job ��å from emp;

select ename || '�� ��å�� ' || job ��å from emp;

select concat('�ι̿���', '�ٸ���') from dual;


--initcap('���ڿ�') : ���� ���ڸ� �빮�ڷ�, �ٸ� ���ڸ� �ҹ��ڷ� ��ȯ

select initcap('asdAsd') from dual;

select initcap('hello JAVA from oracle') �빮�� from dual;


--lower('���ڿ�'), upper('���ڿ�') : ���ڿ��� �ҹ���, �빮�ڷ� ����

select lower('Java Oracle Sql') �ҹ���, upper('Java Oracle Sql') �빮�� from dual;


--lpad('���ڿ�1', �ڸ���, '���ڿ�2') : ���ڿ�1�� �ڸ�����ŭ �ø��µ� �������� �þ �ڸ��� ������ ���ڿ�2�� ä���� ��ȯ��. ���ڿ� 2�� �����Ǹ� �������� ä����

select 'abcd', lpad('abcd', 9, '*') LPAD from dual;

select 'abcd', lpad('abcd', 9) LPAD from dual;


--rpad('���ڿ�1', �ڸ���, '���ڿ�2') : ���������� �ø�

select 'abcd', rpad('abcd', 9, '*') RPAD from dual;

select 'abcd', rpad('abcd', 9) RPAD from dual;


--ltrim('���ڿ�1', '���ڿ�2') : ���ڿ�1���� ���ڿ�2�� �������� ������ ������� ��ȯ

select ltrim('ABCD', 'AB') LTRIM from dual;

select ltrim('            oracle java javac aa', ' ') ���ʰ������� from dual;


--rtrim('���ڿ�1', '���ڿ�2') : ���ڿ�1���� ���ڿ�2�� ���������� ������ ������� ��ȯ

select rtrim('ABCD', 'CD') RTRIM from dual;

select rtrim('oracle java javac aa            ', ' ') �����ʰ������� from dual;


--replace('���ڿ�1', '���ڿ�2', '���ڿ�3') : ���ڿ�1 �߿� �ִ� ���ڿ�2�� ���ڿ�3���� �ٲ㼭 ����� ���

select replace('Oracle Java Jsp Html', 'J', 'O') REPLACE from dual;

select replace('asiancup is international festival', 'asiancup', 'worldcup') replace from dual;


--substr('���ڿ�', �ڸ���, ����) : ���ڿ��� �ڸ������� �����ؼ� ������ ������ŭ ���ڸ� �߶󳻼� ������� ��ȯ�� *���� �ε��� 1

select substr('�ڹٰ����� ����', 4, 4) SUBSTR from dual;

select ename from emp where substr(ename, 2, 1) = 'ö';

select ename �̸� from emp where ename like '_ö%';


--instr('���ڿ�1', '���ڿ�2', �ڸ���1, �ڸ���2) : �ڸ���1 ���� �ڸ��� 2��°�� ���ڿ� 2�� ã�Ƽ� ���� ��ġ�� ��ȯ

select instr('wow-wow-wow-wow-wow', '-') wow from dual;
-- '-'�� ó�� ������ ��ġ

select instr('wow-wow-wow-wow-wow', '-', 5, 1) wow from dual;
-- '-'�� 5��° ���ں��� �����ؼ� ó�� ������ �������� ��ġ


--length('���ڿ�') : ���ڿ��� ���̸� ��ȯ��

select length('jjjaaavvvaaa') ���ڿ����� from dual;

select length(rtrim('abcd     ', ' ')) from dual;


--greatest('��1', '��2', '��3' ...) : ���� ū ���� ��ȯ

select greatest(10, 20, 30, 40) ū�� from dual;

select greatest('a','b','asd', 'zzz') from dual;

select greatest('asb','asdb','asdfgh') from dual;

--least('��1', '��2', '��3' ...) : ���� ���� ���� ��ȯ

select least(10, 20, 30) ������ from dual;

select least('10','20','30') from dual;




--��¥ �Լ�

--sysdate : �ý����� ���� ��¥

select sysdate from dual;


--add_months(��¥ �÷� or ��¥ ������, ����) : ��¥���� ���� ���� ���ؼ� ������� ��ȯ

select add_months(sysdate, 3) from dual;

select add_months('2013/01/25', 5) from dual;

select add_months('2013/01/25', -5) from dual;

select empno �����ȣ, ename �̸�, hiredate �Ի���, add_months(hiredate, 3) ������_��ȯ�� from emp;

--100�� ���� ��¥
select sysdate+100 from dual;

select empno �����ȣ, ename �̸�, hiredate �Ի���, hiredate+90 �Ի���90�� from emp;


-- last_day(��¥�÷� or ��¥������) : �Ķ���� �����Ϳ� ���� ���� ������ ��¥�� ��ȯ

select last_day(sysdate) from dual;

--�Ի��� ���� �ٹ� �ϼ�

select empno,ename,hiredate,round(sysdate-hiredate) from emp;

--�Ի��� ���� �ٹ��ϼ��� 3000�� ������ ����

select empno �����ȣ, ename �̸�, hiredate �Ի���, round(sysdate-hiredate) �ٹ��ϼ� 
 from emp 
 where sysdate-hiredate < 3000
 order by �ٹ��ϼ�;
 
 
 --SQL ������� : from -> where -> select -> order by    �� where������ ��Ī�� ����ϸ� ����
 
 
 --��ƿ� �ϼ�
 
select studno, name, birthday, round(sysdate-birthday) from student;
 
 --��ƿ� ��
 
select studno, name, birthday, round(round(sysdate-birthday) /30) from student;
 
 
 --months_between(��¥�÷�1 or ��¥������1, ��¥�÷�2 or ��¥������2) : �� ��¥ ������ ���� ���� ��ȯ
 
select months_between('2013/05/25', '2013/01/24') from dual;
 
 --��ƿ�  �ϼ�
 
select months_between(sysdate, '1994/08/01') from dual;
 
--��Ȯȯ ��ƿ� �� ���
select studno, name, birthday, round(round(sysdate-birthday) /30), round(months_between(sysdate,birthday)) from student;


--next_day(��¥�÷� or ��¥������, ���� or ����) : ��¥������ ������ ��¥ �߿��� ���� or ���Ϸ� ��õ� ù ��° ��¥�� ��ȯ��

--���� ��¥�� �������� ���ƿ��� ������� �� ��?
 select next_day(sysdate, '��') from dual;
 
 
 --���� ��ȯ �Լ� : to_char(��¥�÷� or ��¥������, '??')
 -- '??'�� �� �� �ִ� ��
 -- 1) d : ������ ��(1~7)
 -- 2) day : ���� ������ �̸����� ǥ��
 -- 3) dd : 1~31 ���·� ���� ǥ��
 -- 4) mm : 01~12 ���·� ���� ǥ��
 -- 5) month, mon : ���� ������ �̸����� ǥ��
 -- 6) yy : ���� ���ڸ� ����
 -- 7) yyyy : ���ڸ� ����
 -- 8) dd-mm-yy : ��-��-���� or yyyy-mm-dd : ����-��-��
 -- 9) hh, hh12, hh24 : �ð�
 -- 10) mi : 0~59 ���·� ��
 -- 11) ss : 0~59 ���·� ��
 -- 12) am, pm : ����, ����
 
 select to_char(sysdate, 'yyyy-mm-dd am hh:mi:ss day') from dual;
 
 
 --���� ��ȯ �Լ� : to_number('���������� ���ڿ�')
 
 select to_number('100') from dual;
 
 
 --��¥ ��ȯ �Լ� : to_date('��¥ ������ ���ڿ�', '��¥ ��ȯ ����')
 
 select to_date('2019-02-19', 'yyyy-mm-dd') ����� from dual;
 
 
 --�ý��� �Լ� : user - ���� ����Ŭ�� �������� ����ڸ� ��ȯ
 
 select user from dual;
 
 
 --���� �Լ�
 
 -- trunc(����1, �ڸ���) : ����1�� �Ҽ��� �ڸ������� ����
 
 -- round(����, �ڸ���) : ���ڸ� �Ҽ��� �ڸ������� �ݿø�
 
 -- ceil(����) : ����
 
 --�� ������ �̸��� �ټӿ����� �� �� �ټӿ����� ������ ����
 
 select ename, trunc((sysdate-hiredate)/365) �ټӿ��� from emp;
 
 select ename, ceil((sysdate-hiredate)/365) �ټӿ��� from emp;
 
 select ename, round((sysdate-hiredate)/365) �ټӿ��� from emp;
 
 
 --�Ϲ� �Լ�
 --nvl(�÷�, ġȯ�� ��) : �÷��� ���� null�̸� �ٸ� ������ ġȯ(��ü) �Լ�
 
 select deptno �а�, name �̸�, pay �޿�, bonus ���ʽ�, (pay*12+nvl(bonus, 0)) ���� 
 from professor 
 where deptno = 101;
 
 
 -- decode(A, B, A==B�� ���� ��, A<>B �� ���� ��) : A<>B �϶��� ���� �����ϸ� null�� ó����, decode �Լ��� �Ű������� ������ ���� ���ǿ� ���� �þ �� ����
 -- ������ join ����
 
 select name �̸�, deptno �а�, decode(deptno, 101, '��ǻ�� ���а�') �а��� 
 from professor;
 
 select name �̸�, deptno �а�, decode(deptno, 101, '��ǻ�� ���а�', '��Ÿ �а�') �а��� 
 from professor;
 
 select name �̸�, deptno �а�, decode(deptno, 101, '��ǻ�� ���а�', 102, '��Ƽ�̵�� ���а�', 103, '����Ʈ���� ���а�', 201, '���ڰ��а�', '��Ÿ �а�') �а��� 
 from professor;
 
 select empno ���, ename �̸�, decode(deptno, 10, '�渮��', 
                                                                    20, '������',
                                                                    30, '�ѹ���',
                                                                    40, '������', '��Ÿ��') �ҼӺμ�
 from emp;
 