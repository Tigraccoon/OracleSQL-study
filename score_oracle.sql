--���� SQL ���� F9,  ��ü���� F5

--���� ���̺�
create table score (
student_no varchar2(20) primary key,
name varchar2(20) not null,
kor number(3) default 0,
eng number(3) default 0,
mat number(3) default 0
);

drop table score;

-- varchar, varchar2 : �ִ� 4000 byte
-- clob : ��뷮 �ؽ�Ʈ (4G)

-- number(���ڸ���) : ������ ex) number(3) ���� 3�ڸ�
-- number(���ڸ���, �Ҽ����ڸ�) : �Ǽ��� ex) number(6, 2) 6�ڸ����� �Ҽ��� ��°�ڸ����� ǥ��

insert into score values ('1', 'kim', 90, 80, 70);
insert into score values ('2', 'lee', 90, 80, 70);
insert into score values ('3', 'park', 88, 80, 78);
insert into score values ('4', 'hong', 85, 79, 92);

commit;

select * from score;
-- select ������ ���ĵ� ����� �� ����
-- alias : �ʵ�(����) as ��Ī(�ѱ۰���), as ��������
-- round(��, �Ҽ������ڸ���) : �ݿø�ó��

select student_no,name,kor,eng,mat,(kor+eng+mat) as tot, round((kor+eng+mat)/3.0,2) as avg from score;

--���ڵ� ����
update score set name='��ö��', kor=99, eng=88, mat=75 where student_no=1;
update score set name='��ö��', kor=100, eng=100, mat=100;

rollback;

--���ڵ� ���� 
delete from score where student_no=3;

--��ϱ� �÷� �߰�
alter table score add expense number default 0;

--90�� �̸�
insert into score (student_no,name,kor,eng,mat,expense) values('70','kim',90,80,70,5000000);

--90�� 
insert into score (student_no,name,kor,eng,mat,expense) values('80','kim2',90,97,90,5000000);

--95��
insert into score (student_no,name,kor,eng,mat,expense) values('90','kim3',95,95,95,5000000);

select * from score;

select student_no, name, kor,eng,mat,(kor+eng+mat) tot, round((kor+eng+mat)/3.0,2) avg, expense,
case when ((kor+eng+mat)/3.0) >= 95 then expense*1.0
when ((kor+eng+mat)/3.0) >= 90 then expense*0.5
else 0
end as scholarship
from score;






