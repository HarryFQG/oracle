---------------------------------day05---------------------------------
---1.�����޲δ洢����
create or replace procedure proc_notarg is
begin 
  dbms_output.put_line('�޲εĴ洢����');
end;
--���ô洢���̣�
call proc_notarg();
----eg.��ѯĳ��Ա���ĵȼ���
create or replace procedure proc_selectSal is
       v_empno number :=7499;
       v_name emp.ename%type;
       v_grade salgrade.grade%type;
begin 
  select emp.ename,salgrade.grade into v_name,v_grade from emp,salgrade 
  where emp.empno=7499 and emp.sal>salgrade.losal and emp.sal<salgrade.hisal;
  dbms_output.put_line('����'||v_name||',�ȼ�'||v_grade);
end;
 call proc_selectSal(); 
        
select * from emp;
select * from salgrade;
--2.�������
create or replace procedure proc_selectSalByempno(eno in number) is
   v_ename varchar2(20);
   v_sal number;
begin
   select ename,sal into v_ename , v_sal from emp where empno=eno;
   dbms_output.put_line('ID:'||eno||'������'||v_ename||',����'||v_sal);
end;

call proc_selectSalByempno(&eno);

--3.�������
create or replace procedure proc_selectNameById(eno in number,ename1 out varchar2) is 
begin 
  select ename into ename1 from emp where empno=eno;
end; 

declare 
  v_ename varchar2(20);
begin
  proc_selectNameById(7499,v_ename);
  dbms_output.put_line(v_ename);

end;

----eg.ʹ�ô洢���̴�ӡ��״ͼ��
select t1.ename Ա��,t1.mgr �ϲ��쵼Id ,t2.ename �쵼 from emp t1,emp t2 where t1.mgr=t2.empno(+); 
select t1.ename ����,t1.mgr Ա���ϼ��Ĳ����쵼��ID,t2.ename �����쵼,t3.ename �����쵼���쵼 from emp t1,emp t2,emp t3 where t1.mgr=t2.empno(+) and t2.mgr=t3.empno(+)
select * from emp;

create or replace procedure proc_treepicture(my_cursor out sys_refcursor) is
       v_mgr number;
       v_ename varchar2(20);
       v_ename1 varchar2(20);
begin
  open my_cursor for  select t1.ename,t1.mgr ,t2.ename  into v_ename,v_mgr,v_ename1 from emp t1,emp t2 where t1.mgr=t2.empno(+); 
  

end;

declare
  type mycursor_type is ref cursor;
  mycursor mycursor_type;
  v_ename varchar2(30);
  v_mgr number;
  v_ename1 varchar2(30);
begin
  proc_treepicture(mycursor);
  loop    
    fetch mycursor into v_ename,v_mgr,v_ename1;
    exit when mycursor%notfound;
    dbms_output.put_line('Ա����'||v_ename||',Ա�����쵼��'||v_ename1||',ID:'||v_mgr);
  end loop;
  close mycursor;
end;    


--eg.��ҳ�Ĵ洢���̣���������
select t2.* from (select rownum rn ,empno from emp ) t1,emp t2 where t1.empno=t2.empno and rn>5 and rn<=10;
create or replace procedure proc_fenye(pagesize in number ,pagecurrent in number,totalpage out number,countnum out number,fenYeCursor out sys_refcursor)is
    v_sql varchar2(1000);
begin
  v_sql:='select t2.* from (select rownum rn ,empno from emp ) t1,emp t2 where t1.empno=t2.empno and rn>'||(pagecurrent-1)*pagesize||' and rn<='||pagecurrent*pagesize;
  open  fenYeCursor for v_sql;
  select count(*) into countnum from emp;
  totalpage:=ceil(countnum/pagesize);
end;

declare
  --type myCursor_type is ref cursor;
  --my_cursor myCursor_type;
  my_cursor sys_refcursor;
  v_count number;
  v_totalpage number;
  v_emp emp%rowtype;
begin
  proc_fenye(5,1,v_totalpage,v_count,my_cursor);
  dbms_output.put_line('�ܼ�¼����'||v_count||',��ҳ����'||v_totalpage);
  loop
    fetch my_cursor into v_emp;
    exit when my_cursor%notfound;
    dbms_output.put_line('Id'||v_emp.empno||',������'||v_emp.ename);
 end loop;
 close my_cursor;
end;




---������ʦ������
create or replace procedure proc_selectEmpByPage(currentPage in number,pageSize in number,
 counts out number,totalPage out number,resultCur out sys_refcursor)
is
   vsql varchar2(1000);
begin
    -- ��ҳ��sql���
   --vsql := 'select t1.empno,t1.ename,t1.job,t1.mgr,t1.hiredate,t1.sal,t1.comm,t1.deptno from (select rownum rn ,emp.* from emp ) t1  where  rn> '||(currentPage-1)*pageSize||' and rn<='||currentPage*pageSize;
  vsql:='select t2.* from (select rownum rn,emp.* from emp ) t1,emp t2 where t1.empno=t2.empno and rn>'||(currentPage-1)*pageSize||' and rn<='||currentPage*pageSize;  
  open resultCur for vsql;
     
    -- ��ѯ�ܼ�¼�� 
    select count(*) into counts  from emp;
   
    --������ҳ��   = ������/Pagesize
    if mod(counts,pageSize)=0 then 
       totalPage:=counts/pageSize;
     else 
       totalPage:=floor(counts/pageSize)+1;
     end if;
     
     --����
     -- totalPage := ceil(counts/pageSize);
 

end;  

declare
  v_count number;
  v_totalPage number;
  
  r_cur sys_refcursor;-- sql�����
  e emp%rowtype;
begin
   proc_selectEmpByPage(2,10,v_count,v_totalPage,r_cur);
   
   dbms_output.put_line('һ����'||v_count||'��----��'||v_totalPage||'ҳ');
   LOOP

      FETCH r_cur INTO e;

      EXIT WHEN r_cur%NOTFOUND;

      dbms_output.put_line(e.empno||'----'||e.ename||'----'||e.sal);

   END LOOP;
end;

------------------------------Oracle����----------------------------------------
--�洢�����ݿ��У��ɹ��ͻ��˵��õ�pl/sql�����
--�ʹ洢���̵�����
----1.�洢���̵Ĳ������������룬������������������ֻ�����������
----2.�洢���̿��Է��ض����������ֻ�ܷ���һ������
----3.�洢����ֻ�ܵ������ã�������������sql��������ɵ��á�
--eg1:ϵͳ�ٴ�������
select ceil(23.45) from dual;
--��������������
create or replace function ������(����)
return ����ֵ��
as/is
begin 
       sql����
end;
----1.�޲κ���
create or replace function showEmpinfo
return number
as
  v_no number;
  v_name varchar2(20);
begin 
  select empno,ename into v_no,v_name from emp where empno=7499;
  dbms_output.put_line(v_no||'----'||v_name);
  return 0;
end;

select showEmpinfo from dual;

----2.�в� �з���ֵ
--------�����������ĺ�
create or replace function func_sum(num1 number,num2 number)
return number
as 
  num3 number;
begin
  num3:=num1+num2;
  return num3;
end;
select func_sum(12,12) from dual;


----��д�������û������ظ��û�����н��
create or replace function fun_userSalSum(ename1 varchar2)
return number
as
   yearsal number;
begin
  select sal*12+nvl(comm,0) into  yearsal from emp where ename like ename1;
  return yearsal;
  exception
     when too_many_rows then
       dbms_output.put_line('��Ľ���ж��У�������ִ��');
       return 0;
end;       
select   fun_userSalSum('%SMI%') from dual;
select * from emp


-------------------������------------------------------------
--��ִ��ĳ�ű��ʱ�� ��ϵͳ�Զ�ִ�д洢�����ݿ��е�pl/sql��
--������������ʾ����
--��������ΪDML��������6�֣���DDL��������ϵͳ������
--DML������ 
--��ɾ��emp��ļ�¼ʱ����ɾ���ļ�¼���ݵ�my_emp��
--�����������﷨��
create or replace trigger  tri_emp_delete
after delete on emp
for each row 
begin
  dbms_output.put_line('������ɾ����¼��ɾ����Ա����¼��'||:old.empno); 
  insert into tb_my(empno,ename,job,deptno,comm,mgr,sal) 
  values(:old.empno,:old.ename,:old.job,:old.deptno,:old.comm,:old.mgr,:old.sal);
  
  
end;
--���ݵ�һ����¼
create table tb_my as select * from emp where empno=1;

----2.DML Insert ������ ֻ�� :new
--emp��Ӽ�¼ʱ����ʾ��ӳɹ�һ����¼
create or replace trigger  tri_insert_emp
after insert on emp
for each row
  begin
    dbms_output.put_line('��ӳɹ�,IDΪ'||:new.empno);
  end;

insert into emp(empno,ename) values(1111,'����')
----3.DML update������ ��:new �� :old����α��
create or replace trigger tri_emp_updateEmp
after update of sal on emp --���������ű���Ǹ��ֶ��޸Ļᴥ��������
for each row
--when deptno=10
begin
    dbms_output.put_line('���޸ĵ�DeptnoΪ'||:old.deptno);
    dbms_output.put_line('�޸�֮ǰ�Ĺ���'||:old.sal);
    dbms_output.put_line('�޸�֮��Ĺ���'||:new.sal);
end;

create or replace trigger tri_deleteEmp
before delete on emp
for each row 
  ---myexp exception
begin
  if to_char(sysdate,'day')='���ڶ�' then
    dbms_output.put_line('���������ڶ�������ɾ������');
    raise_application_error(-20011,'���첻��ɾ������');
  end if;
end;


select * from emp;
delete from emp where empno=1111;
select to_char(sysdate,'day') from dual

---�ڶ��ࣺDDL����û��Ա�ĸı䣬������ͼ�ṹ�ĸı䣬��Ҫ��¼system����
---------
--�﷨��
create or replace trigger ��������
after ddl on �û���.schema
begin
  ....
end;

create table tb_ddl (
       ddl_id number
       
);

drop table tb_ddl;
alter table tb_ddl add username varchar2(15);
select * from tb_ddl;

------------------------�����-----------------------------
--����Ϊ����ͷ�Ͱ���
--������洢���̻��ߺ�����������õĹ�����Щ����
--�﷨��
create or replace package my_package 
is 
   function fucn_add(num1 number ,num2 number) return number;
   function func_cheng(num1 number ,num2 number) return number;
   
   --procedure proc_sum(deptno1 IN number,sumsal OUT number);

end;

create or replace package body my_package
is
       function fucn_add(num1 number ,num2 number) return number
       as
       begin
         return num1+num2;
       end;
       function func_cheng(num1 number ,num2 number) return number
       as
       begin 
         return num1*num2;
       end;
      procedure proc_sum(deptno1 IN number,sumsal OUT number) 
      as
      begin
      select sum(sal) into sumsal from emp where EMPno= deptno1;
      end; 
 end;

select * from emp;
       
       
       
       
