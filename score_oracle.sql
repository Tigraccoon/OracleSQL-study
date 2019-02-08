--현재 SQL 실행 F9,  전체실행 F5

--점수 테이블
create table score (
student_no varchar2(20) primary key,
name varchar2(20) not null,
kor number(3) default 0,
eng number(3) default 0,
mat number(3) default 0
);

drop table score;

-- varchar, varchar2 : 최대 4000 byte
-- clob : 대용량 텍스트 (4G)

-- number(총자릿수) : 정수형 ex) number(3) 정수 3자리
-- number(총자릿수, 소숫점자리) : 실수형 ex) number(6, 2) 6자릿수의 소수점 둘째자리까지 표현

insert into score values ('1', 'kim', 90, 80, 70);
insert into score values ('2', 'lee', 90, 80, 70);
insert into score values ('3', 'park', 88, 80, 78);
insert into score values ('4', 'hong', 85, 79, 92);

commit;

select * from score;
-- select 절에는 수식도 사용할 수 있음
-- alias : 필드(수식) as 별칭(한글가능), as 생략가능
-- round(값, 소수이하자릿수) : 반올림처리

select student_no,name,kor,eng,mat,(kor+eng+mat) as tot, round((kor+eng+mat)/3.0,2) as avg from score;

--레코드 수정
update score set name='김철수', kor=99, eng=88, mat=75 where student_no=1;
update score set name='이철수', kor=100, eng=100, mat=100;

rollback;

--레코드 삭제 
delete from score where student_no=3;

--등록금 컬럼 추가
alter table score add expense number default 0;

--90점 미만
insert into score (student_no,name,kor,eng,mat,expense) values('70','kim',90,80,70,5000000);

--90점 
insert into score (student_no,name,kor,eng,mat,expense) values('80','kim2',90,97,90,5000000);

--95점
insert into score (student_no,name,kor,eng,mat,expense) values('90','kim3',95,95,95,5000000);

select * from score;

select student_no, name, kor,eng,mat,(kor+eng+mat) tot, round((kor+eng+mat)/3.0,2) avg, expense,
case when ((kor+eng+mat)/3.0) >= 95 then expense*1.0
when ((kor+eng+mat)/3.0) >= 90 then expense*0.5
else 0
end as scholarship
from score;






