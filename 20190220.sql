
 --���� 1 : ���� ���̺��� �а����� �������� ��� �޿��� ���

 select * from professor;

 select deptno �а�, count(*) �μ�, sum(pay) �޿���, round(avg(pay),1) �޿���� 
 from professor 
 group by deptno;
 
 
 --���� 2 : ���� ���̺��� �а���, ���޺�(position)�� �������� ��� �޿��� ���
 
 select deptno �а�,position ����, count(*) �μ�, sum(pay) �޿���, round(avg(pay),1) �޿���� 
 from professor 
 group by deptno, position
 order by deptno;
 
 
 --�ǽ� ���� 1 : ���� �߿��� �޿��Ѿ�(�޿�+���ʽ�)�� �޿��Ѿ��� ��ձݾ��� ���
 
 select * from professor;
 
 select name �̸�, pay �޿�, nvl(bonus,0) ���ʽ�, sum(pay+nvl(bonus,0)) �޿��ѱݾ�
 from professor 
 group by name, pay, nvl(bonus,0)  
 order by �̸�;
 
 --���ʽ� ����
 select deptno �а�, sum(pay+nvl(bonus,0)) �޿���, max(pay+nvl(bonus,0)) �ְ�޿�, min(pay+nvl(bonus,0)) �����޿�
 from professor 
 group by deptno 
 order by �а�;
 
 --�ǽ� ���� 2 : student���̺��� birthday �÷��� ����Ͽ� ������ �¾ �ο����� ��� (to_char(birthday, 'MM') �Լ� ���
 
 select to_char(birthday, 'MM') ��, count(*) �ο�
 from student
 group by to_char(birthday, 'MM')
 order by ��;


 --���� 3 : emp���̺��� ��ü ������ ���Ͽ� ������ �̸�, �����ڵ�, �� �ٹ��� ���� ���Ͻÿ�. (�ٹ� �ְ� ���� �������� ��������, �ٹ��� ���� ������ �̸��� ���Ͽ� ��������
 
 select * from emp;
 
 select ename �̸�, job ��å, trunc((sysdate-hiredate)/7) �ٹ��� 
 from emp
 order by �ٹ��� desc, �̸� asc;
 
 
 --���� 4 : student ���̺��� ��1����(deptno1)�� 101�� �а� �л����� �̸��� �ֹι�ȣ, ������ ���(jumin �÷��� ����ؼ� 7��° ���ڰ� 1, 3�� ��� ���� 2, 4�ϰ�� ���ڷ� ���
 
 select * from student;
 
 select name �̸�, jumin �ֹι�ȣ, decode(substr(jumin,7,1),'1', '����'
                                                                                   ,'2', '����'
                                                                                   ,'3', '����'
                                                                                   ,'4', '����') ���� 
 from student
 where deptno1=101;