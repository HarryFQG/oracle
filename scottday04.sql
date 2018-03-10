

declare 
  v_empno number:=&no;
  v_deptno number;
  v_job emp.job%type;
  begin
     select deptno,job into v_deptno,v_job from emp where empno=v_empno;
     if v_deptno=10 and v_job='MANAGER' then
       dbms_output.put_line('���Ա����10���ţ������Ǿ���');
      end if;
      
      if v_deptno=20 then
        dbms_output.put_line('���Ա����20�Ų��ţ������ǣ�'||v_job);
      end if;
  end;
---------����Ա���������ж�Ա�����ʵ�λ��
  --ʹ��if...elseд
  declare 
  v_sal emp.sal%type;---�����б���
  v_empno number;    ---�Զ�����ͨ����
  v_name varchar2(20);--�Զ�����ͨ����
  begin
    v_name:='%'||'&no'||'%';--�ַ�����ƴ��
    select sal into v_sal from emp where ename like v_name;
    if v_sal<1000 then
      dbms_output.put_line('���Ա���������ڵ�5��λ');
    elsif v_sal>=1000 and v_sal<2000 then
      dbms_output.put_line('���Ա���������ڵ�4��λ');

    elsif v_sal>=2000 and v_sal<3000 then
      dbms_output.put_line('���Ա���������ڵ�������λ');
    elsif v_sal>=3000 and v_sal<4000 then 
      dbms_output.put_line('���Ա���Ĺ����ǵڶ���λ');
    elsif v_sal>=4000 and v_sal<5000 then
      dbms_output.put_line('���Ա���Ĺ����ǵ�һ��λ');
    end if;
   end;
   
   --ʹ��caseд
   select sal  , case when sal<1000 then '���Ա���������ڵ�5��λ'
                   	when sal<2000 and sal>=1000 then '���Ա���������ڵ�4��λ'
                    when sal<3000 and sal>=2000 then '���Ա���������ڵ�3��λ'
                    when sal<4000 and sal>=3000 then '���Ա���������ڵ�2��λ'
                    when sal<5000 and sal>=4000 then '���Ա���������ڵ�1��λ'
                    else '���Ա�����ʲ����㣬�������ϰ�'
               end case from emp where empno=7499
               
               
--3. ��ѯԱ������  �����ĸ�����

select deptno ,case deptno when 10 then '10�Ų���'    
                           when 20 then '20�Ų���'
                           when 30 then '30�Ų���'
                end case
   from emp
   
        -----����������д

select deptno ,case  when deptno=10 then '10�Ų���'    
                           when deptno=20 then '20�Ų���'
                           when deptno=30 then '30�Ų���'
                end case
   from emp
   
   
--------------------ѭ���ṹ--------------------------------   
--1. ���10�� hello world
declare
     v_num number :=10;--�Զ�����������Ҹ���ʼֵ
begin
  loop
    dbms_output.put_line('���ǵڣ�'||v_num||'��');
    exit when v_num=0;
    v_num:=v_num-1;
   end loop;
end;
--2. ���� 100 ���ڵ�ż���� 
declare 
     v_num number:=100 ;
     v_sum number:=0;
     v_num1 number:=2;
begin
  loop
    if mod(v_num,v_num1)=0 then
      v_sum:=v_sum+v_num;
    end if;
    if v_num=0 then
      dbms_output.put_line('����ǣ�'||v_sum);
      exit;
    end if;
    v_num:=v_num-1;
   end loop;
end;
--3.  �ж�һ�����Ƿ��� ˮ�ɻ��� ����   �ж�һ���� �ǲ������� 
declare 
      v_num number:=2;
      v_num1 number:=&n;
      v_flag number:=0;
      
begin
 
  loop    
    if v_num<7 and mod(v_num1,v_num)=0 then 
       v_flag:=1;
       exit;
    elsif v_num=v_num1 then
       exit;
    end if;
    v_num:=v_num+1;
  end loop;
  if v_flag=1 then
    dbms_output.put_line('�����������������');
  else Dbms_Output.put_line('������');
  end if;
end;

--��ӡ�žų˷���
declare
  v_hang number:=1;
  v_lie number:=1;
  
begin
  loop
    if v_hang<=9 then
      
      loop 
        if v_lie<=v_hang then
            dbms_output.put(v_hang||'*'||v_lie||'='||v_hang*v_lie||' ');
           
        end if;
        if v_lie=v_hang then exit;        
        end if;
        v_lie:=v_lie+1;
      end loop;  
        
      dbms_output.put_line('');
      v_hang:=v_hang+1;
      v_lie:=1;
      if v_hang=10 then exit;
      end if;
    end if;
  end loop;
end;
-----------------------------�쳣--------------------------------------

---����
declare
     v_name varchar2(20);
     v_no number:=&no;
begin
  select ename into v_name from emp where empno=v_no;
  dbms_output.put_line(v_name);
end;

---1.Ԥ�����쳣
�﷨��
begin
  sql����
  exception
    when �쳣����1 then
      ��Ϣ�����
    when �쳣����2 then
      ��Ϣ�����2
    ...
    when others then
      ��Ϣ�����
end;

-----a.�������Ϊ0���쳣
declare 
      v_a number;
      v_b number;
      v_c number;
      v_ename varchar2(10);
begin
  v_a:=&a;
  v_b:=&b;
  v_c:=&c;
  dbms_output.put_line(v_a/v_b);
  dbms_output.put_line('ִ�������������');
  select ename into v_ename from emp where empno=v_c;
  exception 
    when zero_divide then                 --���������Ϊ0���쳣
      dbms_output.put_line('������Ϊ0');
    when no_data_found then
      dbms_output.put_line('û��������');
    when others then dbms_output.put_line('Ϊ֪����');
  dbms_output.put_line('ִ�����2');
    
end;


--b.���ݲ��ű�Ų�ѯԱ����Ϣ
declare
  v_deptno emp.deptno%type;
  v_emp emp%rowtype;
begin 
  v_deptno:=&no;
  select * into v_emp from emp where deptno=v_deptno;
  dbms_output.put_line('Ա��������'||v_emp.ename||'��ţ�'||v_emp.ename);
  exception 
    when too_many_rows then
    dbms_output.put_line('��ѯ�Ľ���ж���');
    
end;


--2.�û��Զ����쳣
declare
    exp_my exception;---�����쳣����
begin
  raise exp_my;
  sql����
  exception 
    when exp_my then
      �쳣��Ϣ�����
end;

----a.�����Զ����쳣
declare 
      v_num number :=&no;
      exp_my exception;
      exp_my1 exception;
begin
      if v_num<0 then
        dbms_output.put_line(0/0);
        raise exp_my;
        dbms_output.put_line('û�����쳣��ִ������仰');
      else
      raise exp_my1;
      end if;

      exception
        when exp_my then
          dbms_output.put_line('�Զ����쳣ִ��exp_my:�������������С��0');
        when exp_my1 then
          dbms_output.put_line('�Զ����쳣ִ��exp_my1:������������ִ���0');
        when zero_divide then                 --���������Ϊ0���쳣
          dbms_output.put_line('������Ϊ0');
end;
---b.���󣺲�ѯ���벿�ű�ŵ�������ƽ�����ʣ� ���ݹ��ʵȼ��������ӦԱ���ĸ����������Զ��壩  ͨ���Զ����쳣
declare
	exp_sal1 exception;
  exp_sal2 exception;
  exp_sal3 exception;
  v_deptno number:=&no;
  v_count number :=0;
begin
  select avg(sal) into v_count from emp where deptno=v_deptno;
  if v_count<1500 then
    raise exp_sal1;
  elsif v_count>=1500  and v_count<2500 then 
    raise exp_sal2;
  else raise exp_sal3;
  end if;
  exception
    when exp_sal1 then
      dbms_output.put_line('�㻹��С����'||v_count);
    when exp_sal2 then
      dbms_output.put_line('��ϲ����뵽���ϲ�'||v_count);
    when others then 
      dbms_output.put_line('�������������Ѱɣ�'||v_count);
end;
select * from emp

------------------------------˳��ṹ GOTO��null--------------------------------
--goto ��������ת��ָ���ı�ǩ��ע�ĵط�
declare
       v_i number;
begin 
  v_i:=&i;
  if v_i>5 then
    goto f_lable;
    dbms_output.put_line('û����ת��');
  else
    goto s_label;
    dbms_output.put_line('s_label֮��');
  end if;
  
  <<f_lable>>
      dbms_output.put_line('��ת����f_label��ǩ���档');
  <<s_label>>  
      dbms_output.put_line('��ת����s_label��ǩ���档');
end;      
      
---------------------pl/sql��ִ�����ݶ������� DDL---------------------------     
begin
  execute immediate('sql����');      
end;


begin
  execute immediate('
          create table myusers(
                 user_id number primary key,
                 user_name varchar2(10)
                 
          )
          
  ');

end;

select * from myusers;










--��ҳ��䣺
select t2.* from (select rownum rn,empno from emp) t1,emp t2 
where t1.empno=t2.empno and rn>15 and rn<=20;
select * from emp;




-------------------�α�------------------------------------------
--���ã��������ж�ȡ��ѯ�Ľ�����Ա�̵ķ�ʽ��������
---�α��Ϊ����ʽ�α����ʾ�α�
---1.��ʽ�α꣬��ִ��DML���ʱ�Զ����� ����ΪSQL
	    --ͨ��SQL�α�����ԣ����Ի�ȡDMLִ����Ϣ
      --1.1%found : DMLӰ��һ�л����ʱ������true��
      --1.2%notfound: �жϽ����û��Ӱ�������У�����true��
      --1.3%rowcount������SQLӰ�쵽������
      --1.4%isOpen�� �ж��α��Ƿ��.(Ĭ��ʼ���ǹرյ�)
      
declare 
   v_empno number;
begin
  v_empno:=&no;--DML�Զ�����һ��SQL�α�
  
  update emp set sal=sal+100 where empno=v_empno;
  
  
  
  if SQL%found then
    dbms_output.put_line('�Ѿ���ϸ�ɹ���');
    dbms_output.put_line('Ӱ���ˣ�'||SQL%rowcount||'��');
  elsif sql%found then
    dbms_output.put_line('����ʧ�ܣ�');
  end if;
end;
  
    
--2.��ʾ�α�(cursor)�����Զ����α꣬��Ҫ�ֶ��������������رգ�
----ʹ�ó�������ѯ����Ƕ��У���Ҫһ��һ�д�������
declare

begin

  select * from emp;

end;

---���Ͻ���������Ƚ���ѯ��������α��У���ѭ����ȡ�α��е�ÿһ�����ݡ�
declare
  --�����α�
  Cursor �α�����[(�����б�)] is ��ѯsql���
begin
  --���α�
  open �α�����[(�����б�)]  
  loop
       --���л�ȡ�α��е����� into ������(args)
       fetch �α����� into ����
       exit when �α�����%notfound ;       
       --ͨ�� args����������  
  end loop;
  --�ر��α�
  close �α����ƣ�
end; 
  
  
---2.1�����α�
declare
  cursor my_cursor is select * from emp;
  v_emp emp%rowtype;
begin
  open my_cursor;
  loop
    fetch my_cursor into v_emp;
    dbms_output.put_line(v_emp.ename||'----'||v_emp.job);
    exit when my_cursor%notfound;
  
  end loop;
  close my_cursor;
end;

----eg1����ѯĳ�����ŵ�Ա����Ϣ��
declare 
  cursor my_cursor(vno number) is select * from emp where deptno=vno;
  v_emp emp%rowtype;
begin
  open my_cursor(&no);
  loop
    fetch my_cursor into v_emp;
    dbms_output.put_line(v_emp.ename||'----'||v_emp.job);
    exit when my_cursor%notfound;
  end loop;
  close my_cursor;
end;


--3.ref�α꣺�������α�ʱ��֪����Ӧ��sql���ʱ����������
declare
  --����ref�α�����
  type �α��������� is ref cursor;
  --�����α�
  �α����� �α���������
  
begin
  open �α����� for sql���

end;


---eg1:��ѯ���в��ţ�ͨ������ref���
declare 
  type my_cursor_ref is ref cursor;
  my_ref  my_cursor_ref;
  v_emp emp%rowtype;
  v_sql varchar2(200);
  
begin
  open my_ref for &mySql;
  loop
    fetch my_ref into v_emp;
    dbms_output.put_line(v_emp.ename||'----'||v_emp.job);
    exit when my_ref%notfound;
   end loop;
   close my_ref;
end;

---���󣺸���sql��䶯̬��ѯ����sql�����Ϊ�������д���
----���磺 1.��ѯ10�Ų��ŵ�Ա����Ϣ��
----       2.����ҳ��ѯԱ����Ϣ��
----       3.��ѯ���¼��쵼�Ĺ�ϵ����״ͼ��
declare
    type my_cursor_type is ref cursor;
    myCursor my_cursor_type;
    --v_emp emp%rowtype;    
    mySQl varchar2(400);
begin
  open myCursor for &mysql;
  loop
    fetch myCursor into v_emp;
    dbms_output.put_line(v_emp.empno||'----'||v_emp.ename||'---'||v_emp.job||'---'||v_emp.sal);
    exit when myCursor%notfound;
   end loop;
   close myCursor;
end;
select * from emp where deptno=10;





---ͨ��forѭ�������α�
declare
   type my_cursor_type is ref cursor;
   my_cursor my_cursor_type;
begin
  open my_cursor for select * from emp;
  for v_emp in my_cursor loop
    dbms_output.put_line(v_emp.ename||'----'||v_emp.job);
  end loop;
end;
------------------------Oracleѧϰ�ʼ�-----------------------------------------
declare 
  type my_cursor_type is ref cursor;
  my_cuesor(vno number) my_cursor_type;
  v_emp emp%rowtype;
  
begin 
  open my_cursor(&no1) for select * from emp where deptno=vno;
  loop
       fetch my_cursor into v_emp; 
       dbms_output.put_line(v_emp.ename||'<---->'||v_emp.sal);
       exit when my_cursor%notfound;
  end loop;
  close my_cursor;
end;
---Oracle ѧϰ�ʼ�1ti
declare 
  cursor my_cursor(vno number) is select * from emp where deptno=vno;
  v_emp emp%rowtype;
begin
  open my_cursor(&no);
  loop
    fetch my_cursor into v_emp;
    dbms_output.put_line(v_emp.ename||'-----'||v_emp.sal);
    exit when my_cursor%notfound;
  end loop;
  
end;
---2ti
declare 
  cursor my_cursor(vno number) is select * from emp where deptno=vno;
  v_emp emp%rowtype;
begin
  open my_cursor(&no);
  loop
    fetch my_cursor into v_emp;
    dbms_output.put_line(v_emp.ename||'-----'||v_emp.sal);
    if v_emp.sal<1600 then
      update emp set sal=sal+100  where empno=v_emp.empno;
      dbms_output.put_line(v_emp.ename||'-----'||v_emp.sal);
    end if;
    exit when my_cursor%notfound;
  end loop;
  
end;
select * from emp;

