 --���� 1 : emp ���̺��� ����̸�, �μ���ȣ, ��å, �޿�, Ŀ�̼�, ����
 
 select ename ����̸�, deptno �μ���ȣ, job ��å, sal �޿�, trunc(nvl(comm, sal*0.03)) Ŀ�̼�, trunc(sal*12+nvl(comm,sal*0.03)) ����
 from emp;
 
 
 --���� 2
 
 select student_no �й�, name �̸�, kor ��������, eng ��������, mat ��������, (kor+eng+mat) ����, round((kor+eng+mat)/3,2) ���, 
 decode(trunc((kor+eng+mat)/3/10), 10, 'A', 
                                                    9, 'A', 
                                                    8, 'B', 
                                                    7, 'C', 
                                                    6, 'D', 
                                                    'F') ��� 
 from score;
 
 
 
 --���� 3
 
 select student_no �й�, name �̸�, kor ��������, eng ��������, mat ��������, (kor+eng+mat) ����, round((kor+eng+mat)/3,2) ���,
 case when round((kor+eng+mat)/3,2) >=90 then 'A' 
        when round((kor+eng+mat)/3,2) >=80 then 'B' 
        when round((kor+eng+mat)/3,2) >=70 then 'C'
        when round((kor+eng+mat)/3,2) >=60 then 'D'
        else 'F'
 end ���
 from score;
 
 
 --���� 4
 
 select empno �����ȣ, ename ����̸�, deptno �μ���ȣ, 
 case when deptno = 10 then '�渮��'
        when deptno = 20 then '�λ��'
        when deptno = 30 then '������'
        else '�̹���'
 end �μ�
 from emp;
 
 
 
 --���� ����
 
 create table mart (
  id varchar2(20) primary key,
  pname varchar2(20) not null, --��ǰ�̸�
  price number(10) default 0, --�ܰ�
  count number(4) default 0, --����
  company varchar2(10) --����ȸ��
  );
  
  insert into mart values('1', '���', 1000, 10, '���');
  insert into mart values('2', '����', 1500, 3, '���');
  insert into mart values('3', '���̽�ũ��', 2000, 8, '���׷�');
  insert into mart values('4', '�ǻ�', 1800, 5, 'ũ���');
  insert into mart values('5', '����', 10000, 4, '����');
  insert into mart values('6', '����', 10000, 5, '����');
  select * from mart;
 
-- mart���̺��� ��ǰ�̸�, �ܰ�, ����, ����ȸ��, �Ǹűݾ�, ���
--  (����� �Ǹűݾ��� 1���� �̸�, D��� 
--  10000�� �̻�, C���
--  20000�� �̻�, B��� 
--  30000�� �̻�, A���)
--  
--  1)decode �� �Ἥ.. ó��, 2)case ~ end�� �Ἥ ó��
--  3)rank()�Լ��� �Ἥ ������ ó��(ȸ���̸� ��)

--1)

 select pname ��ǰ�̸�, price �ܰ�, count ����, company ����ȸ��, price*count �Ǹűݾ�, 
 decode(trunc((price*count)/10000), 0, 'D',
                                         1, 'C',
                                         2, 'B', 
                                         'A') ���
 from mart;
 
 --2)
 
 select pname ��ǰ�̸�, price �ܰ�, count ����, company ����ȸ��, price*count �Ǹűݾ�,
 case when price*count >= 30000 then 'A'
        when price*count >= 20000 then 'B'
        when price*count >= 10000 then 'C'
        else 'D'
 end ���
 from mart;
 
 --3)
 select pname ��ǰ�̸�, price �ܰ�, count ����, company ����ȸ��, price*count �Ǹűݾ�,
 case when price*count >= 30000 then 'A'
        when price*count >= 20000 then 'B'
        when price*count >= 10000 then 'C'
        else 'D'
 end ���, 
 rank() over(partition by company order by (price*count) desc) ����
 from mart;