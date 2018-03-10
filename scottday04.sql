

declare 
  v_empno number:=&no;
  v_deptno number;
  v_job emp.job%type;
  begin
     select deptno,job into v_deptno,v_job from emp where empno=v_empno;
     if v_deptno=10 and v_job='MANAGER' then
       dbms_output.put_line('这个员工是10部门，并且是经理');
      end if;
      
      if v_deptno=20 then
        dbms_output.put_line('这个员工是20号部门，工作是：'||v_job);
      end if;
  end;
---------输入员工姓名。判断员工工资档位。
  --使用if...else写
  declare 
  v_sal emp.sal%type;---定义列变量
  v_empno number;    ---自定义普通变量
  v_name varchar2(20);--自定义普通变量
  begin
    v_name:='%'||'&no'||'%';--字符串的拼接
    select sal into v_sal from emp where ename like v_name;
    if v_sal<1000 then
      dbms_output.put_line('这个员工工资属于第5档位');
    elsif v_sal>=1000 and v_sal<2000 then
      dbms_output.put_line('这个员工工资属于第4档位');

    elsif v_sal>=2000 and v_sal<3000 then
      dbms_output.put_line('这个员工工资属于第三个档位');
    elsif v_sal>=3000 and v_sal<4000 then 
      dbms_output.put_line('这个员工的工资是第二档位');
    elsif v_sal>=4000 and v_sal<5000 then
      dbms_output.put_line('这个员工的工资是第一档位');
    end if;
   end;
   
   --使用case写
   select sal  , case when sal<1000 then '这个员工工资属于第5档位'
                   	when sal<2000 and sal>=1000 then '这个员工工资属于第4档位'
                    when sal<3000 and sal>=2000 then '这个员工工资属于第3档位'
                    when sal<4000 and sal>=3000 then '这个员工工资属于第2档位'
                    when sal<5000 and sal>=4000 then '这个员工工资属于第1档位'
                    else '这个员工工资不计算，可能是老板'
               end case from emp where empno=7499
               
               
--3. 查询员工部门  属性哪个部门

select deptno ,case deptno when 10 then '10号部门'    
                           when 20 then '20号部门'
                           when 30 then '30号部门'
                end case
   from emp
   
        -----或者在这样写

select deptno ,case  when deptno=10 then '10号部门'    
                           when deptno=20 then '20号部门'
                           when deptno=30 then '30号部门'
                end case
   from emp
   
   
--------------------循环结构--------------------------------   
--1. 输出10次 hello world
declare
     v_num number :=10;--自定义变量，并且赋初始值
begin
  loop
    dbms_output.put_line('这是第：'||v_num||'次');
    exit when v_num=0;
    v_num:=v_num-1;
   end loop;
end;
--2. 计算 100 以内的偶数和 
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
      dbms_output.put_line('结果是：'||v_sum);
      exit;
    end if;
    v_num:=v_num-1;
   end loop;
end;
--3.  判断一个数是否是 水仙花数 （）   判断一个数 是不是素数 
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
    dbms_output.put_line('你输入的数不是素数');
  else Dbms_Output.put_line('是素数');
  end if;
end;

--打印九九乘法表
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
-----------------------------异常--------------------------------------

---例子
declare
     v_name varchar2(20);
     v_no number:=&no;
begin
  select ename into v_name from emp where empno=v_no;
  dbms_output.put_line(v_name);
end;

---1.预定义异常
语法：
begin
  sql语句块
  exception
    when 异常名称1 then
      消息处理快
    when 异常名称2 then
      消息处理块2
    ...
    when others then
      消息处理块
end;

-----a.捕获除数为0的异常
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
  dbms_output.put_line('执行完两个数相除');
  select ename into v_ename from emp where empno=v_c;
  exception 
    when zero_divide then                 --捕获除数不为0的异常
      dbms_output.put_line('除数不为0');
    when no_data_found then
      dbms_output.put_line('没发现数据');
    when others then dbms_output.put_line('为知错误');
  dbms_output.put_line('执行完毕2');
    
end;


--b.根据部门编号查询员工信息
declare
  v_deptno emp.deptno%type;
  v_emp emp%rowtype;
begin 
  v_deptno:=&no;
  select * into v_emp from emp where deptno=v_deptno;
  dbms_output.put_line('员工姓名：'||v_emp.ename||'编号：'||v_emp.ename);
  exception 
    when too_many_rows then
    dbms_output.put_line('查询的结果有多行');
    
end;


--2.用户自定义异常
declare
    exp_my exception;---申明异常类型
begin
  raise exp_my;
  sql语句块
  exception 
    when exp_my then
      异常信息处理快
end;

----a.测试自定义异常
declare 
      v_num number :=&no;
      exp_my exception;
      exp_my1 exception;
begin
      if v_num<0 then
        dbms_output.put_line(0/0);
        raise exp_my;
        dbms_output.put_line('没有抛异常则执行了这句话');
      else
      raise exp_my1;
      end if;

      exception
        when exp_my then
          dbms_output.put_line('自定义异常执行exp_my:并且输入的数字小于0');
        when exp_my1 then
          dbms_output.put_line('自定义异常执行exp_my1:并且输入的数字大于0');
        when zero_divide then                 --捕获除数不为0的异常
          dbms_output.put_line('除数不为0');
end;
---b.需求：查询输入部门编号的求它的平均工资， 根据工资等级，输出对应员工的福利（福利自定义）  通过自定义异常
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
      dbms_output.put_line('你还是小咯咯'||v_count);
    when exp_sal2 then
      dbms_output.put_line('恭喜你进入到了上层'||v_count);
    when others then 
      dbms_output.put_line('土豪我们做盆友吧！'||v_count);
end;
select * from emp

------------------------------顺序结构 GOTO和null--------------------------------
--goto 将语句块跳转到指定的标签标注的地方
declare
       v_i number;
begin 
  v_i:=&i;
  if v_i>5 then
    goto f_lable;
    dbms_output.put_line('没有跳转。');
  else
    goto s_label;
    dbms_output.put_line('s_label之后。');
  end if;
  
  <<f_lable>>
      dbms_output.put_line('跳转到了f_label标签里面。');
  <<s_label>>  
      dbms_output.put_line('跳转到了s_label标签里面。');
end;      
      
---------------------pl/sql中执行数据定义语言 DDL---------------------------     
begin
  execute immediate('sql语句块');      
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










--分页语句：
select t2.* from (select rownum rn,empno from emp) t1,emp t2 
where t1.empno=t2.empno and rn>15 and rn<=20;
select * from emp;




-------------------游标------------------------------------------
--作用：用于逐行读取查询的结果，以编程的方式处理数据
---游标分为：隐式游标和显示游标
---1.隐式游标，当执行DML语句时自动创建 ，名为SQL
	    --通过SQL游标的属性，可以获取DML执行信息
      --1.1%found : DML影响一行或多行时，返回true。
      --1.2%notfound: 判断结果有没有影响任意行，返回true。
      --1.3%rowcount：返回SQL影响到的行数
      --1.4%isOpen： 判断游标是否打开.(默认始终是关闭的)
      
declare 
   v_empno number;
begin
  v_empno:=&no;--DML自动创建一个SQL游标
  
  update emp set sal=sal+100 where empno=v_empno;
  
  
  
  if SQL%found then
    dbms_output.put_line('已经更细成功！');
    dbms_output.put_line('影响了：'||SQL%rowcount||'行');
  elsif sql%found then
    dbms_output.put_line('更新失败！');
  end if;
end;
  
    
--2.显示游标(cursor)，（自定义游标，需要手动创建，开启，关闭）
----使用场景：查询结果是多行，需要一行一行处理结果。
declare

begin

  select * from emp;

end;

---以上解决方案：先将查询结果放入游标中，再循环读取游标中的每一行数据。
declare
  --申明游标
  Cursor 游标名称[(参数列表)] is 查询sql语句
begin
  --打开游标
  open 游标名称[(参数列表)]  
  loop
       --逐行获取游标中的数据 into 给变量(args)
       fetch 游标名称 into 变量
       exit when 游标名称%notfound ;       
       --通过 args变量输出结果  
  end loop;
  --关闭游标
  close 游标名称；
end; 
  
  
---2.1定义游标
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

----eg1：查询某个部门的员工信息。
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


--3.ref游标：当声明游标时不知道对应的sql语句时，可以声明
declare
  --定义ref游标类型
  type 游标类型名称 is ref cursor;
  --声明游标
  游标名称 游标类型名称
  
begin
  open 游标名称 for sql语句

end;


---eg1:查询所有部门，通过定义ref完成
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

---需求：更据sql语句动态查询？将sql语句作为参数进行传递
----例如： 1.查询10号部门的员工信息？
----       2.做分页查询员工信息。
----       3.查询上下级领导的关系表（树状图）
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





---通过for循环遍历游标
declare
   type my_cursor_type is ref cursor;
   my_cursor my_cursor_type;
begin
  open my_cursor for select * from emp;
  for v_emp in my_cursor loop
    dbms_output.put_line(v_emp.ename||'----'||v_emp.job);
  end loop;
end;
------------------------Oracle学习笔记-----------------------------------------
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
---Oracle 学习笔记1ti
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

