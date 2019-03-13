declare 
 type ename_table is table of emp.ename%type 
		 index by binary_integer;
		 type sal_table is table of emp.sal%type index by binary_integer;
		 ename_tab ename_table;
		 sal_tab sal_table; 
		 i binary_integer := 0;
 begin
    for emp_row in (select ename,sal from emp) loop
    i := i+1;
    ename_tab(i) := emp_row.ename;
    sal_tab(i) := emp_row.sal;
 end loop;
 for cnt in 1 .. i loop
    dbms_output.put('이름 : ' || ename_tab(cnt) || ', ' );
    dbms_output.put_line('급여 : ' || sal_tab(cnt));
 end loop;
 end;
 /
 
