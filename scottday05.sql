---------------------------------day05---------------------------------
---1.创建无参存储过程
create or replace procedure proc_notarg is
begin 
  dbms_output.put_line('无参的存储过程');
end;
--调用存储过程：
call proc_notarg();
----eg.查询某个员工的等级？
create or replace procedure proc_selectSal is
       v_empno number :=7499;
       v_name emp.ename%type;
       v_grade salgrade.grade%type;
begin 
  select emp.ename,salgrade.grade into v_name,v_grade from emp,salgrade 
  where emp.empno=7499 and emp.sal>salgrade.losal and emp.sal<salgrade.hisal;
  dbms_output.put_line('姓名'||v_name||',等级'||v_grade);
end;
 call proc_selectSal(); 
        
select * from emp;
select * from salgrade;
--2.输入参数
create or replace procedure proc_selectSalByempno(eno in number) is
   v_ename varchar2(20);
   v_sal number;
begin
   select ename,sal into v_ename , v_sal from emp where empno=eno;
   dbms_output.put_line('ID:'||eno||'姓名：'||v_ename||',工资'||v_sal);
end;

call proc_selectSalByempno(&eno);

--3.输出参数
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

----eg.使用存储过程打印树状图？
select t1.ename 员工,t1.mgr 上层领导Id ,t2.ename 领导 from emp t1,emp t2 where t1.mgr=t2.empno(+); 
select t1.ename 姓名,t1.mgr 员工上级的部门领导的ID,t2.ename 部门领导,t3.ename 部门领导的领导 from emp t1,emp t2,emp t3 where t1.mgr=t2.empno(+) and t2.mgr=t3.empno(+)
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
    dbms_output.put_line('员工：'||v_ename||',员工的领导：'||v_ename1||',ID:'||v_mgr);
  end loop;
  close mycursor;
end;    


--eg.分页的存储过程：总条数，
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
  dbms_output.put_line('总记录数：'||v_count||',总页数：'||v_totalpage);
  loop
    fetch my_cursor into v_emp;
    exit when my_cursor%notfound;
    dbms_output.put_line('Id'||v_emp.empno||',姓名：'||v_emp.ename);
 end loop;
 close my_cursor;
end;




---或者老师这样的
create or replace procedure proc_selectEmpByPage(currentPage in number,pageSize in number,
 counts out number,totalPage out number,resultCur out sys_refcursor)
is
   vsql varchar2(1000);
begin
    -- 分页的sql语句
   --vsql := 'select t1.empno,t1.ename,t1.job,t1.mgr,t1.hiredate,t1.sal,t1.comm,t1.deptno from (select rownum rn ,emp.* from emp ) t1  where  rn> '||(currentPage-1)*pageSize||' and rn<='||currentPage*pageSize;
  vsql:='select t2.* from (select rownum rn,emp.* from emp ) t1,emp t2 where t1.empno=t2.empno and rn>'||(currentPage-1)*pageSize||' and rn<='||currentPage*pageSize;  
  open resultCur for vsql;
     
    -- 查询总记录数 
    select count(*) into counts  from emp;
   
    --计算总页数   = 总行数/Pagesize
    if mod(counts,pageSize)=0 then 
       totalPage:=counts/pageSize;
     else 
       totalPage:=floor(counts/pageSize)+1;
     end if;
     
     --或者
     -- totalPage := ceil(counts/pageSize);
 

end;  

declare
  v_count number;
  v_totalPage number;
  
  r_cur sys_refcursor;-- sql结果集
  e emp%rowtype;
begin
   proc_selectEmpByPage(2,10,v_count,v_totalPage,r_cur);
   
   dbms_output.put_line('一共有'||v_count||'条----共'||v_totalPage||'页');
   LOOP

      FETCH r_cur INTO e;

      EXIT WHEN r_cur%NOTFOUND;

      dbms_output.put_line(e.empno||'----'||e.ename||'----'||e.sal);

   END LOOP;
end;

------------------------------Oracle函数----------------------------------------
--存储在数据库中，可供客户端调用的pl/sql代码块
--和存储过程的区别：
----1.存储过程的参数包括：输入，输出，输入输出；函数只有输入参数。
----2.存储过程可以返回多个，而函数只能返回一个数据
----3.存储过程只能单独调用，而函数可以在sql语句块中完成调用。
--eg1:系统再带函数：
select ceil(23.45) from dual;
--二：创建函数：
create or replace function 函数名(参数)
return 返回值；
as/is
begin 
       sql语句块
end;
----1.无参函数
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

----2.有参 有返回值
--------计算两个数的和
create or replace function func_sum(num1 number,num2 number)
return number
as 
  num3 number;
begin
  num3:=num1+num2;
  return num3;
end;
select func_sum(12,12) from dual;


----编写：接受用户名返回该用户的年薪。
create or replace function fun_userSalSum(ename1 varchar2)
return number
as
   yearsal number;
begin
  select sal*12+nvl(comm,0) into  yearsal from emp where ename like ename1;
  return yearsal;
  exception
     when too_many_rows then
       dbms_output.put_line('你的结果有多行，不允许执行');
       return 0;
end;       
select   fun_userSalSum('%SMI%') from dual;
select * from emp


-------------------触发器------------------------------------
--当执行某张表的时候 ，系统自动执行存储在数据库中的pl/sql块
--触发器不能显示调用
--触发器分为DML触发器（6种），DDL触发器，系统触发器
--DML触发器 
--当删除emp表的记录时，将删除的记录备份到my_emp中
--创建触发器语法：
create or replace trigger  tri_emp_delete
after delete on emp
for each row 
begin
  dbms_output.put_line('你正在删除记录，删除的员工记录：'||:old.empno); 
  insert into tb_my(empno,ename,job,deptno,comm,mgr,sal) 
  values(:old.empno,:old.ename,:old.job,:old.deptno,:old.comm,:old.mgr,:old.sal);
  
  
end;
--备份第一条记录
create table tb_my as select * from emp where empno=1;

----2.DML Insert 触发器 只有 :new
--emp添加记录时，提示添加成功一条记录
create or replace trigger  tri_insert_emp
after insert on emp
for each row
  begin
    dbms_output.put_line('添加成功,ID为'||:new.empno);
  end;

insert into emp(empno,ename) values(1111,'张三')
----3.DML update触发器 有:new 和 :old两张伪表
create or replace trigger tri_emp_updateEmp
after update of sal on emp --锁定对那张表的那个字段修改会触发触发器
for each row
--when deptno=10
begin
    dbms_output.put_line('你修改的Deptno为'||:old.deptno);
    dbms_output.put_line('修改之前的工资'||:old.sal);
    dbms_output.put_line('修改之后的工资'||:new.sal);
end;

create or replace trigger tri_deleteEmp
before delete on emp
for each row 
  ---myexp exception
begin
  if to_char(sysdate,'day')='星期二' then
    dbms_output.put_line('今天是星期二，不能删除数据');
    raise_application_error(-20011,'今天不能删除数据');
  end if;
end;


select * from emp;
delete from emp where empno=1111;
select to_char(sysdate,'day') from dual

---第二类：DDL监控用户对表的改变，或者视图结构的改变，需要登录system创建
---------
--语法：
create or replace trigger 触发器名
after ddl on 用户名.schema
begin
  ....
end;

create table tb_ddl (
       ddl_id number
       
);

drop table tb_ddl;
alter table tb_ddl add username varchar2(15);
select * from tb_ddl;

------------------------程序包-----------------------------
--包分为：包头和包体
--将多个存储过程或者函数打包，更好的管理这些对象
--语法：
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
       
       
       
       
