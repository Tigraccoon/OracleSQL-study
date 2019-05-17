drop table test;

--������̺� ����(���ڵ� ����)
--���� where���� ���� �����ϸ� ���ڵ���� �����
create table test
as select * from emp where 1=0; 

select * from test;

--PLSQL
--test ���̺� 991���� ���ڵ� �Է�
declare --�����
  i number := 1; --i ������ 1�� ����
begin --�����
  while i<=991 loop
    insert into test (empno,ename) values
      (i, '���'||i);
    i := i + 1;
  end loop;
end;
/

commit; 

select * from test order by empno;
select count(*) from test;

--rowid : ���ڵ��� �ּҰ�
--rownum : ���ڵ��� ��ȣ(sql��  ����� ������ ������ �ִ°�)
select rownum, empno, ename
from test
order by empno;

select rowid, empno, ename
from test
order by empno;
--  �����������⸦ �ϱ����ؼ� rownum�� �ʿ��ϴ�.
-- select ������ �� ����� �ڿ��� rownum�� �ٴ°Ŵ�.
-- ������� �Ʒ��� ���� ���� rownum 1���� ��µ��� ����
-- ���¿��� 2���� ��µ��� �ʴ´�.
-- SQL�� ������� : from => where => select => order by
select rownum, empno, ename
from test
where rownum = 2;

--���� �̸� �ذ��ϱ����ؼ��� �Ʒ�ó�� ó���ؾ��Ѵ�.
-- �ʵ� between A and B : �ʵ尪�� A~B
select empno,ename
from test
where rownum between 1 and 10;

--�׷��� 1page�� 10���� �����ְڴٴ°ǵ� ���� �Ʒ�ó�� �ϸ�
--���� �ȳ��´�. �� rownum�� �������� ���� �ʿ��ϴ�. �߰��� �ǳʶ� �� ����.
select empno,ename
from test
where rownum between 11 and 20;

--�׷��� �̸� �� �ذ��ϱ� ���� ���������� ����ؾ��Ѵ�.
select *
from (
  -- ��ü ���ڵ忡 �Ϸù�ȣ �ο�(2)
  select A.*, rownum as rn 
  from (
      --��ü ���ڵ带 ����(1)
      select empno, ename 
      from test
      order by empno
  ) A
)
where rn between 1 and 10; --���� �ٱ��� select������ ���ϴ� ���� ����.(3)

-- ���� 2page�� ��������  between 11 and 20;

select *
from (
  select A.*, rownum as rn 
  from (
      select empno, ename 
      from test
      order by empno
  ) A
)
where rn between 29 and 80; --���� �ٱ��� select������ ���ϴ� ���� ����.(3)

