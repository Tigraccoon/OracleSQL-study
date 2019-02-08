create or replace package SCORE_tapi
is

type SCORE_tapi_rec is record (
MAT  SCORE.MAT%type
,STUDENT_NO  SCORE.STUDENT_NO%type
,COLUMN2  SCORE.COLUMN2%type
,NAME  SCORE.NAME%type
,KOR  SCORE.KOR%type
);
type SCORE_tapi_tab is table of SCORE_tapi_rec;

-- insert
procedure ins (
p_MAT in SCORE.MAT%type default null 
,p_STUDENT_NO in SCORE.STUDENT_NO%type
,p_COLUMN2 in SCORE.COLUMN2%type default null 
,p_NAME in SCORE.NAME%type
,p_KOR in SCORE.KOR%type default null 
);
-- update
procedure upd (
p_MAT in SCORE.MAT%type default null 
,p_STUDENT_NO in SCORE.STUDENT_NO%type
,p_COLUMN2 in SCORE.COLUMN2%type default null 
,p_NAME in SCORE.NAME%type
,p_KOR in SCORE.KOR%type default null 
);
-- delete
procedure del (
p_STUDENT_NO in SCORE.STUDENT_NO%type
);
end SCORE_tapi;

/
create or replace package body SCORE_tapi
is
-- insert
procedure ins (
p_MAT in SCORE.MAT%type default null 
,p_STUDENT_NO in SCORE.STUDENT_NO%type
,p_COLUMN2 in SCORE.COLUMN2%type default null 
,p_NAME in SCORE.NAME%type
,p_KOR in SCORE.KOR%type default null 
) is
begin
insert into SCORE(
MAT
,STUDENT_NO
,COLUMN2
,NAME
,KOR
) values (
p_MAT
,p_STUDENT_NO
,p_COLUMN2
,p_NAME
,p_KOR
);end;
-- update
procedure upd (
p_MAT in SCORE.MAT%type default null 
,p_STUDENT_NO in SCORE.STUDENT_NO%type
,p_COLUMN2 in SCORE.COLUMN2%type default null 
,p_NAME in SCORE.NAME%type
,p_KOR in SCORE.KOR%type default null 
) is
begin
update SCORE set
MAT = p_MAT
,COLUMN2 = p_COLUMN2
,NAME = p_NAME
,KOR = p_KOR
where STUDENT_NO = p_STUDENT_NO;
end;
-- del
procedure del (
p_STUDENT_NO in SCORE.STUDENT_NO%type
) is
begin
delete from SCORE
where STUDENT_NO = p_STUDENT_NO;
end;
end SCORE_tapi;


--varchar, varchar2 = 최대 4000바이트
--clob = 대용량 텍스트 최대 4GB

--number(총자릿수) : 정수형 ex) number(3) : 정수3자리
--number(총자릿수, 소숫점자리) : 실수형 ex) number(6, 2) : 6자릿수의 소수점 2자리 실수


insert into score values ('1','kim',90,80,70);
insert into score values ('2','lee',95,80,70);
insert into score values ('3','park',88,77,66);
insert into score values ('4','hong',90,80,90);

select * from SCORE;

delete from score;

select student_no,name,kor,eng,mat,(kor+eng+mat) as tot,((kor+eng+mat)/3.0) as avg from score;

