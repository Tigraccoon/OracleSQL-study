create table himart(
 location varchar2(100),  --����
 name varchar2(100),      --ǰ��
 code varchar2(1000),      --��ǰ�ڵ�
 price number,       --�ܰ�
 amount number,      --����
 val number,         --�ΰ��� ��ǰ����
 tax number,         --����
 tot number,         --�Ѿ�
 chk varchar2(1000)      --��������
);

select * from himart;
desc himart;
drop table himart;

commit;