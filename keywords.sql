create table keywords(
 keyword varchar(250)
);

desc keywords;

insert into keywords values('java1');
insert into keywords values('java2');
insert into keywords values('java3');
insert into keywords values('jsp1');
insert into keywords values('jsp2');
insert into keywords values('jsp3');
insert into keywords values('�ڹ�1');
insert into keywords values('�ڹ�2');
insert into keywords values('�ڹ�3');

select * from keywords;

commit;

select * from keywords where keyword like '%j%';

