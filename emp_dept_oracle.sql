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
 
 
 select s.name, s.deptno1, d.dname 
  from student s, department d
  where s.deptno1=d.deptno;
 
 select * from department;
 
 select * from student;
 
 select * from professor;
 
 
 -- join
 
 select s.name �л��̸�, d.dname �а�, p.name �������� 
 from student s, department d, professor p 
 where s.deptno1 = d.deptno and s.profno = p.profno;
 
 
 -- view : ������ ���̺�
 
 create or replace view student_v as 
 select s.name �л��̸�, d.dname �а�, p.name �������� 
 from student s, department d, professor p 
 where s.deptno1 = d.deptno and s.profno = p.profno;
 
 --view�� ���̺� ó�� ��� ����
 
 select * from student_v;
 
 --�Ʒ��� ��������
 
select * from ( select s.name �л��̸�, d.dname �а�, p.name �������� 
 from student s, department d, professor p 
 where s.deptno1 = d.deptno and s.profno = p.profno); --��������
 
 --view�� ���� ������ ������ select���� ������ �ϰ��� ��
 --java code�� �� �� select * from student_v; �� ����ϸ� �Ǳ� ������ �ڵ��� ���������� ��ŷ��� �پ��
 --�ڵ尡 ����Ǿ ���� �� ���ȿ� ������
 --��, �ӵ��� �ణ ������..(���̺����� ������ ���� �˻��� �� �������� query���� ������ �����ϱ� ����)
 --���� ���ν����� ���� �� ���� �� ����!
 
 
 --����
 --cross ����(Cartesian Product, ī������ ��)
 -- 2�� �̻��� ���̺��� ���ε� �� ���� ������ ���� �ʴ� ��. �� where ������ ���� �÷��� ���� ������ �߻����� �ʾƼ� �� ���̺� ���� ���� ������ ��� ����� ���� ����Ͽ� ����� �����ϴ� ���� ���
 -- ������ �ǹ̿��� ������ �ƴ�.
 
 select e.ename, d.dname 
 from emp e, dept d;
 
 
 --���� ����(inner join, ���� ����, Equi join)
 -- ���� �Ϲ����� ����, where���� ���� ���� �÷����� ���� ������( = ) �� ���� �񱳵Ǵ� ���� ���
 
 
 --self join : �����ؾ� �� �÷��� �ڽ��� ���̺� �ִ� �ٸ� �÷��� ��쿡 ����ϴ� ����. �ݵ�� ���̺� ���� ��Ī�� ��� ��.
 
 select a.empno ���, a.ename �̸�, b.empno �Ŵ������, b.ename �Ŵ��� 
 from emp a, emp b 
 where a.mgr = b.empno;
 
 
 --�ܺ� (outer)���� ��� : �� �� ���̺��� �ش� �����Ͱ� �����ϰ� �ٸ� �� ���̺��� �����Ͱ� �������� ���� ��� ���� �����͸� ��ȸ�ϴ� ����
 -- ��ȸ ���ǿ��� (+)��ȣ�� ����ϴ� ����
 -- �����Ͱ� �������� �ʴ� ���̺��� ���� ���ǿ� (+) ����
 -- *���� : ���̺� (+)�� ���̴°� �ƴ�, (+)�� ���� �÷����� in �����ڸ� �Բ� ����� �� ����!, (+)�� ���� �÷����� ���������� ���� ����� �� ����!
 
 select s.name, p.name 
 from student s, professor p 
 where s.profno = p.profno(+);
 
 
 --ANSI ���� : ���ο� ���� ǥ�ؿ� ���� ����, Oracle 9i���� ����
  -- ���� ���� : inner join ���
  --    - where ��� on ���(inner ���� ����!)
 select e.empno, d.dname 
 from emp e inner join dept d
 on e.deptno=d.deptno;
 
 --     - where �� ��� using ��� ����(�����ϴ� �÷��� ������ ��쿡�� ���)
  select e.empno, d.dname 
 from emp e inner join dept d
 using (deptno);
 
 
 select s.name, s.deptno1, d.dname 
 from student s, department d 
 where s.deptno1 = d.deptno;
 
 
 --�ܺ� ���� : [left | right | full] outer join ���
 -- �����Ͱ� �ִ� ���̺����� �������� left �Ǵ� right�� ����
 
 select s.name sname, p.name pname 
 from student s left outer join professor p --student�� �����ʿ� ������ right�� ��
 on s.profno = p.profno 
 order by sname;
 
 
 --���� ������ ���� �л�
 
  select s.name sname, p.name pname 
 from student s, professor p
 where s.profno = p.profno(+) 
 order by sname;
 
 --���� �л��� ���� ����
 
 select s.name sname,  p.name pname 
 from student s, professor p
 where s.profno(+) = p.profno 
 order by sname;
 
 --�� ��θ� ����ϰ� ���� ��, �� �� ��ο� (+)�� ���� �� ����.
 --ANSI������ full outer join�� ����ϸ� ��
 
  select s.name sname, p.name pname 
 from student s full outer join professor p 
 on s.profno = p.profno 
 order by sname;
 
 
 --���̺� ����
 --��ǰ ���̺�
 
 drop table product;
 
 
 create table product (
 product_code varchar2(20) not null primary key,
 product_name varchar2(50) not null,
 price number default 0,
 company varchar2(50),
 make_date date default sysdate
 );
 
 desc product;
 
 select * from product;
 
 insert into product values('A1','������',900000,'��Ǯ','2016-09-01');
 insert into product values('A2','������ ����',9000000,'����','2018-08-01');
 insert into product values('A3','������S19',1200000,'����','2019-01-01');
 
 
 --�Ǹ� ���̺�
 
 --references ���̺��(�÷�) : foreign key(�ܷ�Ű)
 
 create table product_sales (
 product_code varchar2(20) not null references product(product_code),
 amount number default 0
 );
 
 desc product_sales;
 
 insert into product_sales values('A1',100);
 insert into product_sales values('A2',200);
 insert into product_sales values('A3',300);
 
 select * from product_sales;
 
 commit;
 
 insert into product_sales values('A4',300);
 
 --drop table product_sales;
 
 
 select p.product_code, p.product_name, p.company, p.price, s.amount, p.price*s.amount money
 from product p, product_sales s
 where p.product_code = s.product_code;
 
 --�� select���� view�� Ȱ���Ͽ� ����
 
 create or replace view product_sales_v 
 as select p.product_code, p.product_name, p.company, p.price, s.amount, p.price*s.amount money
 from product p, product_sales s
 where p.product_code = s.product_code;
 
 --�並 ���̺� ó�� ����� �� ����!
 select * from product_sales_v;
 
 select * from product_sales_v where company = '����';
 
 
 
 create table dep (
 id varchar2(10) primary key,
 name varchar2(15) not null,
 location varchar2(50)
 );
 
insert into dep values('10', '������', '���� ������');
 
 savepoint a;
 
 insert into dep values('20', 'ȸ���', '�λ� ������');
 
 savepoint b;
 
 insert into dep values('30', '���ߺ�', '��õ �Ծ籸');
 
 select * from dep;
 
 rollback to a;
 
 commit;
 
 rollback to b;
 
 --undo �� �ð����� ���� ��ɾ�
 show parameter undo;
 
 --undo_retention : delete, update �Ŀ� commit�� ���� ������ �Ӽ����� �ð�(��)������ ����Ŭ���� �ӽ÷� ������ �����ͷ� ������ �� ����!
 --Default �Ӽ����� '900'�ʷ� �� 15�� ������ ������ ������. commit ���Ŀ� 15�� �̳����� �����͸� ���� ����
 --�ð� ���浵 �����ѵ� �����Ϸ��� 
 alter system set undo_retention = 1500;
 
 show parameter undo;
 
 undo_retention;
 
 select * from tab;
 
 select * from member;
 
 delete from member where userid='park';
 
 commit;
 
 --������ ���ڵ� Ȯ��
 select * from member as of timestamp(systimestamp-interval '15' minute) 
 where userid='park';
 
 --������ ���ڵ� ����
 insert into member select * from member as of timestamp(systimestamp-interval '15'minute)
 where userid='park';
 
 select * from tab;

 select count(*), sum(sal), round(avg(sal),2) 
 from emp 
 where deptno=10;

--group by : �׷���(�׷����� ���´�.)
 select count(*), sum(sal), round(avg(sal),2) 
 from emp 
 group by deptno;
 
 
 --group by(����)�� having(���� ��������� ����)
 
 select dname, avg(pay) 
 from professor p, department d
 where p.deptno = d.deptno 
 group by dname 
 having avg(pay) >= 450;
 
 --���뿡�� Ȯ���ϴ� SQL ���� ���� : from(��ü ���ڵ�) -> where(�� ����) -> group by(���õ� ���� ���) -> having(��� ����� ����) ->select(�÷� ����) -> order by(����) 
 
 
 
 
 --��������
 
 select max(sal) from emp;
 
 select * from emp where sal=800;
 
 --���� �ܰ踦 �� ���� ó�� ( ) �� ����� �ϰ� ( ) ���� ����
 
 select * from emp 
 where sal = (select max(sal) from emp);
 
 --���̺��� ��Ī�� �����Ͽ� ���� ����
 
 select * from emp e1 
 where e1.sal = (select max(sal) from emp e2);
 
 
 --������ ��������
 --all(����) : ������ ��� ��Ҹ� �����ؾ� ��. and
 --any(����) : ������ ��� �� �� ���� �����ϸ� ��. or
 
 select sal from emp where deptno=30;
 
 select * from emp 
 where sal > all(select sal from emp where deptno=30);
 
 select * from emp 
 where sal > any(select sal from emp where deptno=30);
 
 select * from emp 
 where sal > (select min(sal) from emp where deptno=30);
 
 
 --�������� �ִ� ��������(��ȣ���� ��������) : ���������� �������� ���̿� ������ ���, �ݵ�� ��Ī�� ���
 
 --ORACLE
 select e.ename, e.deptno, d.dname 
 from emp e, dept d
 where e.deptno = d.deptno;
 
 --ANSI
 
 select e.ename, e.deptno, d.dname 
 from emp e join dept d 
 on e.deptno = d.deptno;
 
 --��������, ������ ����� �˻��� ���
 
 select e.ename, e.deptno, (select d.dname from dept d where e.deptno = d.deptno) departmentName 
 from emp e;
 
 --�μ� ��� �޿����� ������ ���� ������� ���
 
 select e.ename, e.sal, e.deptno, 
 (select round(avg(sal)) from emp where deptno=e.deptno) �μ���ձ޿�
 from emp e 
 where sal < (select avg(sal) from emp where deptno=e.deptno);
 
 --�ζ��� �� : from ���� ��ġ 
 --* from������ ���̺��̳� �䰡 ��ġ�ϴµ� �̰Ͱ� ���ؼ� ���������� ���� ������� ������鿡 ���ؼ� �θ��� ��Ī. �ζ��� ��� ���ؼ� �������� ������� �並 �ƿ����� ���� ��
 
 select e.empno, e.ename, e.sal 
 from emp e, (select avg(sal) avgs, max(sal) maxs from emp) e2 --�ζ��� �� (inline view)
 where e.sal > e2.avgs and e.sal < e2.maxs
 order by e.sal desc;
 
 
 --scalar ��������(���ڵ嵵 �ϳ�, �÷��� �ϳ�)
 --���������� ���� �ϳ��� ��, �ϳ��� �÷����� ��ȯ�ϴ� ��������. 9i���� ����
 --��å�� ������ ����� �����, �μ����� ��ȸ
 
 select ename �����, (select dname from dept d where d.deptno=e.deptno) �μ��� 
 from emp e 
 where job='����';
 
 
 
 --numberŸ���� java���� float�̳� double���� ȣ��, �ִ� 38�ڸ� number(��ü �ڸ���, �Ҽ� ���� �ڸ���)
 
 create table t_emp (
 id number(5) not null, 
 name varchar2(25), 
 salary number(7,2),
 phone varchar2(15),
 dept_name varchar2(25)
 );
 
 desc t_emp;
 
 select * from tab;
 
 --���̺�� �����ϱ� : rename A to B
 
 rename t_emp to s_emp;
 
 insert into s_emp values(100,'�̻���',2000,'010-2222-2222','���ߺ�');
 insert into s_emp values(101,'�����',3000,'010-3333-3333','�ѹ���');
 insert into s_emp values(102,'�����',4000,'010-4444-4444','������');
 
 delete from s_emp where id=102;
 
 select * from s_emp;
 
 insert into s_emp (id,name) values(103,'������');
 
 --���̺� �÷� �߰�
 
 alter table s_emp add (hire_date date);
 
 --�÷� ����
 
 alter table s_emp modify (phone varchar2(20));
 
 desc s_emp;
 
 commit;
 
 --�÷��� �̸��� ����
 
 alter table s_emp rename column id to t_id;
 
 select * from s_emp;
 
 --�÷� ����
 
 alter table s_emp drop column dept_name;
 
 select * from s_emp;
 
 --**alter�� Ʈ�������� ����� �ƴ϶� ������ ���� ����!
 
 --���̺� ������ ����
 
 update s_emp set hire_date = sysdate 
 where t_id=100;
 
 update s_emp set hire_date = sysdate 
 where hire_date is null;
 
 select * from s_emp;
 
 --���ο� ������ �Է�
 
 insert into s_emp (t_id, hire_date) values(400,sysdate);
 
 select * from s_emp;
 
 --������ ����
 
 delete from s_emp where t_id=400;
 
 select * from s_emp;
 
 
 --��������(constraint)
 --���̺��� �ش� �÷��� ������ �Ŵ� ��
 
 --ex) primary key, foreign key, unique(�ߺ����� �ʴ� pk�� ����ϳ� null�� ���), check(���� ������ ����), not null
 
 --���������� �ݿ��� ���̺� ����
 -- ����� : constraint ���������̸� ��������
 create table c_emp (
 id number(5) constraint c_emp_id_pk primary key,                                           --primary key
 name varchar2(25) constraint c_emp_name_nn not null,                                   --not null
 salary number(7,2), 
 phone varchar2(15) constraint c_emp_phone_ck check(phone like '0000-%'),      -- check
 dept_id number(7) constraint c_emp_dept_id_fk references dept(deptno)           --foreign key 
 );
 
 desc c_emp;
 
 --���̺��� ���������� Ȯ��
 
 select * from user_constraints where table_name= 'C_EMP';
 
 --���� : constraint_type
 -- P : primary key
 -- F : foreign key
 -- U : unique
 -- C : check
 
 --�ش� DB���� �������� �̸����� �� �� : ������ �������� �˻���
 
 select constraint_name from user_constraints;
 
 --���������� ������ �� ���� ������ ����
 
 alter table c_emp drop constraint c_emp_name_nn;
 
 select * from user_constraints where table_name='C_EMP';
 
 --�������� �߰�
 
 alter table c_emp add constraint c_emp_name_un unique(name);
 
 select * from user_constraints where table_name='C_EMP';
 
 --not null ���������� add�� �� �� ���� modify�� ������
 
 alter table c_emp modify(name varchar2(25) constraint c_emp_name_nn not null);
 
 select * from user_constraints where table_name='C_EMP';
 
 --�������� Ȱ��ȭ(enable), ��Ȱ��ȭ(disable)
 --disable
 alter table c_emp disable constraint c_emp_name_nn;
 
 select * from user_constraints where table_name='C_EMP';
 --enable
 alter table c_emp enable constraint c_emp_name_nn;
 
 --�������� ����
 
 alter table c_emp drop constraint c_emp_name_nn;
 
 
 --�ǽ� (���������� ���߿� �߰�)
 
 drop table c_emp;
 
 create table c_emp (
 id number(5), 
 name varchar2(25),
 salary number(7,2), 
 phone varchar2(15),
 dept_id number(7)
 );
 
 desc c_emp;
 
 insert into c_emp (id,name) values(1,'��ö��');
 insert into c_emp (id,name) values(1,'��ö��');
 insert into c_emp (id,name) values(1,'��ö��');
 
 select * from c_emp;
 
 delete from c_emp;
 
 --id�� �������� Pk�ο�
 
 alter table c_emp add constraint c_emp_id_pk primary key(id);
 --ORA-0001 : unique constraint (HR.C_EMP_ID_PK) violated : ���Ἲ �������� ���� ����
 
 drop table c_emp;
 
 --check (�Է°� üũ ����) 
 
 create table c_emp (
 id number(5) constraint c_emp_id_pk primary key, 
 name varchar2(25),
 salary number(7,2) constraint c_emp_salary_ck check(salary between 100 and 1000), 
 phone varchar2(15),
 dept_id number(7)
 ); 
 
 select * from user_constraints where table_name='C_EMP';
 
 insert into c_emp (id,name,salary) values (1,'kim',500);
 insert into c_emp (id,name,salary) values (2,'park',1500);
 
 select * from user_constraints where table_name='EMP';
 select * from emp;
 select * from user_constraints where table_name='DEPT'; 
 select * from dept;
 
 insert into emp(empno,ename,deptno) values (9999,'ȫ�浿',50);
 
 drop table c_emp;
 
 --unique �������� (null ���)
 
 drop table c_emp;
 
 create table c_emp (
 id number(5) constraint c_emp_id_pk primary key, 
 name varchar2(25) constraint c_emp_name_un unique, 
 salary number(7,2), 
 phone varchar2(15),
 dept_id number(7) constraint c_emp_dept_id_fk references dept(deptno)
 ); 
 
 select * from user_constraints where table_name = 'C_EMP';
 
 insert into c_emp (id, name) values (1,'kim');
 insert into c_emp (id, name) values (2,'kim'); --���� : name�� unique�� �����ż�
 
 