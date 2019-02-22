--���� 1 : s_emp ���̺���
--1) e-mail�� �����ϱ� ���� mailid �÷��� 10byte�� �߰�

alter table s_emp add (mailid varchar(10));

--2) mailid �÷��� 20byte�� ����

alter table s_emp modify (mailid varchar(20));

--3) mailid �÷��� e_mail�� ����

alter table s_emp rename column mailid to e_mail;

--4) s_emp ���̺���� t_emp�� ����

rename s_emp to t_emp;

select * from t_emp;


--���� 2 : ���̺� ���� �� id�÷��� �������� �̸��� c_emp_id_pk

 create table c_emp (
 id number(5) constraint c_emp_id_pk primary key, 
 name varchar2(25),
 salary number(7,2), 
 phone varchar2(15),
 dept_id number(7)
 );
 
 select * from user_constraints where table_name = 'C_EMP';
 
 
 
 --���� 3 : dept_id�� fk �������� �ο�
 
 create table c_emp (
 id number(5) constraint c_emp_id_pk primary key, 
 name varchar2(25),
 salary number(7,2), 
 phone varchar2(15),
 dept_id number(7) constraint c_emp_dept_id_fk references dept(deptno)
 ); 
 
 select * from user_constraints where table_name='C_EMP';
 
 insert into c_emp(id,name,dept_id) values(1,'kim',10);
 insert into c_emp(id,name,dept_id) values(2,'park',20); 
 insert into c_emp(id,name,dept_id) values(3,'hong',50); --���� dept_id�� fk�� ���� �� �Է�
 
 
 
 --���� ����
 
 create table ex_emp (
 id number(5) constraint ex_emp_id_pk primary key,
 name varchar2(20), 
 email varchar2(20), 
 hp varchar2(20) constraint ex_emp_hp_un unique, 
 sal number(5) constraint ex_emp_sal_ck check(sal between 100 and 2000), 
 addr1 varchar2(50),
 addr2 varchar2(50),
 dept_id number(7) constraint ex_emp_dept_id_fk references dept(deptno)
 );
 
 select * from user_constraints where table_name = 'EX_EMP';
 
 insert into ex_emp (id, dept_id) values (10, 40);
 