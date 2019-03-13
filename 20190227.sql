--     --문제) professor테이블에서 프로시저이름은 prof_search,
--	 교수사번profno을  p_profno라는 변수에 입력받아서 if else문을
--	 사용해서 deptno => v_deptno라는 변수에 입력받아서 
--	 deptno=101=>컴퓨터공학과, 102=>멀티미디어공학과,
--	 103=>소프트웨어공학과, 201=>전자공학과, 그 외는 기타학과로
--	 처리, 1001을 매개변수값으로 실행
--	 
--	 ==================================================
--	 execute prof_search(1001);
--	 
--	 출력결과 : 학과번호는 ____ 번 입니다. + _____공학과 입니다.

 create or replace procedure prof_search(p_profno in professor.profno%type)
 is 
    v_deptno professor.deptno%type;
 begin 
    select deptno into v_deptno 
    from professor 
    where profno = p_profno;
 dbms_output.put_line('학과번호는 ' || v_deptno || '입니다.');
    if v_deptno = 101 then 
        dbms_output.put_line('컴퓨터공학과 입니다.');
    elsif v_deptno = 102 then
        dbms_output.put_line('멀티미디어공학과 입니다.');
    elsif v_deptno = 103 then 
        dbms_output.put_line('소프트웨어공학과 입니다.');
    elsif v_deptno = 201 then
        dbms_output.put_line('전자공학과 입니다.');
    else 
        dbms_output.put_line('기타학과 입니다.');
    end if;
 end;
 /
 
 execute prof_search(1001);