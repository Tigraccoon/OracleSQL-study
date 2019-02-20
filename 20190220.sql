
 --문제 1 : 교수 테이블에서 학과별로 교수들의 평균 급여를 출력

 select * from professor;

 select deptno 학과, count(*) 인수, sum(pay) 급여합, round(avg(pay),1) 급여평균 
 from professor 
 group by deptno;
 
 
 --문제 2 : 교수 테이블에서 학과별, 직급별(position)로 교수들의 평균 급여를 출력
 
 select deptno 학과,position 직급, count(*) 인수, sum(pay) 급여합, round(avg(pay),1) 급여평균 
 from professor 
 group by deptno, position
 order by deptno;
 
 
 --실습 문제 1 : 교수 중에서 급여총액(급여+보너스)이 급여총액의 평균금액을 출력
 
 select * from professor;
 
 select name 이름, pay 급여, nvl(bonus,0) 보너스, sum(pay+nvl(bonus,0)) 급여총금액
 from professor 
 group by name, pay, nvl(bonus,0)  
 order by 이름;
 
 --보너스 문제
 select deptno 학과, sum(pay+nvl(bonus,0)) 급여합, max(pay+nvl(bonus,0)) 최고급여, min(pay+nvl(bonus,0)) 최저급여
 from professor 
 group by deptno 
 order by 학과;
 
 --실습 문제 2 : student테이블의 birthday 컬럼을 사용하여 월별로 태어난 인원수를 출력 (to_char(birthday, 'MM') 함수 사용
 
 select to_char(birthday, 'MM') 월, count(*) 인원
 from student
 group by to_char(birthday, 'MM')
 order by 월;


 --문제 3 : emp테이블에서 전체 직원에 대하여 직원의 이름, 직업코드, 총 근무주 수를 구하시오. (근무 주가 많은 직원부터 내림차순, 근무주 수가 같으면 이름에 대하여 오름차순
 
 select * from emp;
 
 select ename 이름, job 직책, trunc((sysdate-hiredate)/7) 근무주 
 from emp
 order by 근무주 desc, 이름 asc;
 
 
 --문제 4 : student 테이블에서 제1전공(deptno1)이 101인 학과 학생들의 이름과 주민번호, 성별을 출력(jumin 컬럼을 사용해서 7번째 숫자가 1, 3일 경우 남자 2, 4일경우 여자로 출력
 
 select * from student;
 
 select name 이름, jumin 주민번호, decode(substr(jumin,7,1),'1', '남자'
                                                                                   ,'2', '여자'
                                                                                   ,'3', '남자'
                                                                                   ,'4', '여자') 성별 
 from student
 where deptno1=101;