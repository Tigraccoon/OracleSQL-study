create table event(
fileName varchar2(2000),     --���ϸ�
fileRealName varchar2(2000), --�������ϸ�
name varchar2(500),          --�̸�
email varchar2(1000),         --�̸����ּ�
phoneNum varchar2(500)      --�ڵ�����ȣ
);

select * from event;
desc event;
drop table event;

commit;