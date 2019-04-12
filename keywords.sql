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
insert into keywords values('자바1');
insert into keywords values('자바2');
insert into keywords values('자바3');

select * from keywords;

commit;

select * from keywords where keyword like '%j%';

