--创建表
create table student(
       id number primary key,
       sname varchar2(20),
       sex nchar(1),
       email varchar2(30),
       birthday date,
       amount number(5,2),
       createdate timestamp

);
select * from student
--添加数据
insert into student values(1001,'张三','男','163.@163.com','4-5月-1995',123.23,systimestamp);
insert into student values(1002,'李四','男','163.@163.com','4-5月-1995',123.123,systimestamp);
insert into student values(1003,'王五','男','163.@163.com','4-5月-1995',123.128,systimestamp);
insert into student values(idsequence.nextval,'钱七','男','163.@163.com','4-5月-1995',123.128,systimestamp);

--序列用于生成唯一的序号
create sequence idsequence
       --指定生成序列的起始数
       start with 10
       --指定两个序列号之间的间隔大小，这里间隔为1
       increment by 1
       --最大的序列号，为30
       maxvalue 30
       --最小值为10
       minvalue 8
       nocycle      --是否循环
       cache 2     --生成一个缓存2个
--修改序列
alter sequence idsequence maxvalue 1000 cycle

--删除序列
drop sequence idsequence;


--查看序列
select idsequence.nextval from dual;--返回下一个序列号，每个序列号查完之后，再次执行则返回下一个序列号
--返回当前序列号
select idsequence.currval from dual


/*--------------------------------------------------------------------------*/
select * from emp;

select * from dept;
select * from dept;

select * from emp where deptno=10

select * from wangwu.tb_user

--显示行号：rownum ,显示每一行数据所在的位置:rowid
select rownum ,empno,ename,job,rowid from emp

--使用伪表：dual
select 1+1 as sum from dual

--orcale分页
select * from (select rownum rn,emp.* from emp)where rn>0 and rn<5

select t2.* from (select rownum rn,emp.empno from emp) t1,emp t2 where t1.empno=t2.empno and rn>5 and rn<=10



--分页查询带参数：查询所有带A的人的信息，并且每页显示5行
select * from emp
select t3.rn,t1.* from  (select rownum rn ,t2.empno from emp t2 )t3 ,emp t1
where t3.empno=t1.empno and t3.rn>0 and t3.rn<=5

--分页查询，查询所有名字中有A字母的人，并且每页显示五行
select rownum rn ,t2.empno from (select * from  emp where ename like '%A%') t1,emp t2 where t1.empno=t2.empno

select * from  (select rownum rn ,t2.empno from (select * from  emp where ename like '%A%') t1,emp t2 where t1.empno=t2.empno
) t2,emp t3
where t2.empno=t3.empno and t2.rn>5 and t2.rn<=10 

select * from emp where ename like '%A%'

----方式2：使用左外链接
select * from (select rownum rn ,t2.* from emp t1 left join emp t2 on t1.empno=t2.empno where t1.ename like '%A%' )t1 
where t1.rn>5 and t1.rn<=10




--显示雇工工资上涨20%
select ename,sal*1.2,sal from emp

--显示emp表的雇员名称以及工资个津贴的和
-----nvl(arg1,arg2):判断arg1字段是否为空，如果为空则用arg2代替
select ename,sal+nvl(comm,0) from emp
-----nvl2(arg1,arg2,arg3):如果arg1为空，则返回arg3，不为空的话就返回arg2;
select comm,nvl2(comm,'有奖金','无奖金') from emp;

--当别名中存在特殊字符就加双引号("")，单引号('')相当于虚拟的列
select ename as "员工 姓名" from emp
select ename as "员工 姓名",'虚拟列  员工 姓名' as "员工 姓名" from emp


--链接符和concat()函数:串用于拼接字符
select ename||'--------'||job as "员工职务表" from emp
select concat(ename,concat('-----',job)) as "员工职务表" from emp

---部门accounting所在的城市为newYork


--distinct消除重复项
select distinct job from emp

---按照部门和工资排序
select * from emp order by deptno asc,sal desc

--  查询雇员姓名和雇佣日期，并按雇佣日期排序，后雇佣的先显示。
select * from emp order by hiredate desc

--按工资和工作月份的乘积排序。输入并执行查询
select emp.* ,sal*Months_between(sysdate,hiredate) as "工资乘以工资" from emp 
--Months_between(时间1，时间2)：计算两个时间的差
select  Months_between(sysdate,hiredate) from emp

-- and or not 
select * from emp where sal>3000 and deptno=10;
select * from emp where sal>3000 or deptno=10;
select * from emp where job not in('manager');

--exists 是否存在 not exists

select * from emp t1 where exists(select * from emp t2 where deptno=10 and t1.deptno=t2.deptno)


---优先级 not >and   >or
--查询10号部门的职位是manager和30 号部门的职位是salesman的员工 
select * from emp where deptno=10 and job='manager' or deptno=30 and job='SALESMAN'



--显示职务为clerr或者manager的雇员日志

--显示部门10和部门20中工资小于1500的雇员





--查询显示工资在1000~2000之间的雇员
select * from emp where sal between 1000 and 2000; 
---查询入职时间在1980-1897年之间的员工
select * from emp where hiredate between '01-1月-1980' and '31-12月-85' order by hiredate desc  

--like模糊查询
---查询姓名以S开头的雇员信息
select * from emp  where ename like 'S%'
---查询姓名第二个字母是以a开头的姓名
select * from  emp where ename like '_A%'
---查询ename中包含%的员工，需要转义:escape 定义转义字符
select * from emp where ename like '%#%%'
select * from emp where ename like '%\%' escape '\'
--查询没有奖金的员工信息
select * from emp where comm is null;

--any 和some 的应用场景一样：查询工资小于10部门的其中一个员工的工资(小于最大的工资)
select * from emp where sal<any(select sal from emp where deptno=10)


--all   所有 
select * fROM emp where sal <all(select sal from emp where deptno=10)



--1佣金高于工资60%的雇员
select * from emp where mgr>sal*1.6
--2.找出部门10 中所有的经理和部门20中所有办事员的详细资料
select * from emp where (deptno=10 and job='MANAGER') or (deptno=20 and job='CLERK')

--4.



 
