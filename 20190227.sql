--     --����) professor���̺��� ���ν����̸��� prof_search,
--	 �������profno��  p_profno��� ������ �Է¹޾Ƽ� if else����
--	 ����ؼ� deptno => v_deptno��� ������ �Է¹޾Ƽ� 
--	 deptno=101=>��ǻ�Ͱ��а�, 102=>��Ƽ�̵����а�,
--	 103=>����Ʈ������а�, 201=>���ڰ��а�, �� �ܴ� ��Ÿ�а���
--	 ó��, 1001�� �Ű����������� ����
--	 
--	 ==================================================
--	 execute prof_search(1001);
--	 
--	 ��°�� : �а���ȣ�� ____ �� �Դϴ�. + _____���а� �Դϴ�.

 create or replace procedure prof_search(p_profno in professor.profno%type)
 is 
    v_deptno professor.deptno%type;
 begin 
    select deptno into v_deptno 
    from professor 
    where profno = p_profno;
 dbms_output.put_line('�а���ȣ�� ' || v_deptno || '�Դϴ�.');
    if v_deptno = 101 then 
        dbms_output.put_line('��ǻ�Ͱ��а� �Դϴ�.');
    elsif v_deptno = 102 then
        dbms_output.put_line('��Ƽ�̵����а� �Դϴ�.');
    elsif v_deptno = 103 then 
        dbms_output.put_line('����Ʈ������а� �Դϴ�.');
    elsif v_deptno = 201 then
        dbms_output.put_line('���ڰ��а� �Դϴ�.');
    else 
        dbms_output.put_line('��Ÿ�а� �Դϴ�.');
    end if;
 end;
 /
 
 execute prof_search(1001);