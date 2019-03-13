 --문제 1 : emp 테이블에서 사원이름, 부서번호, 직책, 급여, 커미션, 연봉
 
 select ename 사원이름, deptno 부서번호, job 직책, sal 급여, trunc(nvl(comm, sal*0.03)) 커미션, trunc(sal*12+nvl(comm,sal*0.03)) 연봉
 from emp;
 
 
 --문제 2
 
 select student_no 학번, name 이름, kor 국어점수, eng 영어점수, mat 수학점수, (kor+eng+mat) 총점, round((kor+eng+mat)/3,2) 평균, 
 decode(trunc((kor+eng+mat)/3/10), 10, 'A', 
                                                    9, 'A', 
                                                    8, 'B', 
                                                    7, 'C', 
                                                    6, 'D', 
                                                    'F') 등급 
 from score;
 
 
 
 --문제 3
 
 select student_no 학번, name 이름, kor 국어점수, eng 영어점수, mat 수학점수, (kor+eng+mat) 총점, round((kor+eng+mat)/3,2) 평균,
 case when round((kor+eng+mat)/3,2) >=90 then 'A' 
        when round((kor+eng+mat)/3,2) >=80 then 'B' 
        when round((kor+eng+mat)/3,2) >=70 then 'C'
        when round((kor+eng+mat)/3,2) >=60 then 'D'
        else 'F'
 end 등급
 from score;
 
 
 --문제 4
 
 select empno 사원번호, ename 사원이름, deptno 부서번호, 
 case when deptno = 10 then '경리부'
        when deptno = 20 then '인사과'
        when deptno = 30 then '영업부'
        else '미배정'
 end 부서
 from emp;
 
 
 
 --종합 문제
 
 create table mart (
  id varchar2(20) primary key,
  pname varchar2(20) not null, --제품이름
  price number(10) default 0, --단가
  count number(4) default 0, --수량
  company varchar2(10) --제조회사
  );
  
  insert into mart values('1', '라면', 1000, 10, '삼양');
  insert into mart values('2', '과자', 1500, 3, '농심');
  insert into mart values('3', '아이스크림', 2000, 8, '빙그레');
  insert into mart values('4', '건빵', 1800, 5, '크라운');
  insert into mart values('5', '맥주', 10000, 4, '진로');
  insert into mart values('6', '소쥬', 10000, 5, '진로');
  select * from mart;
 
-- mart테이블에서 제품이름, 단가, 수량, 제조회사, 판매금액, 등급
--  (등급은 판매금액이 1만원 미만, D등급 
--  10000원 이상, C등급
--  20000원 이상, B등급 
--  30000원 이상, A등급)
--  
--  1)decode 를 써서.. 처리, 2)case ~ end를 써서 처리
--  3)rank()함수를 써서 순위도 처리(회사이름 순)

--1)

 select pname 제품이름, price 단가, count 수량, company 제조회사, price*count 판매금액, 
 decode(trunc((price*count)/10000), 0, 'D',
                                         1, 'C',
                                         2, 'B', 
                                         'A') 등급
 from mart;
 
 --2)
 
 select pname 제품이름, price 단가, count 수량, company 제조회사, price*count 판매금액,
 case when price*count >= 30000 then 'A'
        when price*count >= 20000 then 'B'
        when price*count >= 10000 then 'C'
        else 'D'
 end 등급
 from mart;
 
 --3)
 select pname 제품이름, price 단가, count 수량, company 제조회사, price*count 판매금액,
 case when price*count >= 30000 then 'A'
        when price*count >= 20000 then 'B'
        when price*count >= 10000 then 'C'
        else 'D'
 end 등급, 
 rank() over(partition by company order by (price*count) desc) 순위
 from mart;