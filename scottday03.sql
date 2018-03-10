/*-------------------------------day03函数----------------------------------------------*/
select * from emp where empno=&empno
---指定需要查询的输入列。例如：empno,sal,ename等列名
select &a  from emp

------------------------------------------------------------
--一.聚合函数（多行） 5个sum，count，avg，max,min
----    1.汇总所有人的工资
select sum(sal) from emp          ---限定数字类型的数据
----   2.求emp表的人数？
select count(empno) from emp
----   3.查询最高工资
select max(sal) from emp          ----兼容char，number类型
select max(ename) from emp
select min(sal) from emp
----   4.平均工资？
select avg(sal) from emp;


-----求奖金的平均值？
select avg(comm) from emp--对于值为空的数据不计入统计。这里是550，只除以4


----------------------------聚合函数一般用于：子查询和分组查询------
------1查询最高工资和员工的姓名和职位
select ename , job from emp where sal=(select max(sal) from emp)
------2.求工资高于平均工资的员工？
select ename , job from emp where sal>(select avg(sal) from emp)
------3.查询工资高于30号部门的所有人的工资
select * from emp where sal>all(select sal from emp where deptno=30 )
---------等价于
select * from emp where sal > (select max(sal) from emp where deptno=30)

-----4.按部门统计最高工资和最低工资
select max(sal),min(sal) from emp group by deptno;
--------注意：在分组sql中，select 后面只能是分组字段和聚合函数
select deptno, max(sal),min(sal) from emp group by deptno;
select deptno,ename, max(sal),min(sal) from emp group by deptno;--错误写法：ename字段不包含在group by后面的分组字段
-----5.显示每个部门有多少人？
select deptno ,count(*) from emp group by deptno;
-----6.显示按部门和工作岗位进行排序
select deptno,job ,count(*) from emp group by deptno,job order by deptno desc;
select * from emp;
----7.查询工资高于2000的部门平均工资
select deptno,avg(sal) from emp where sal>2000 group by deptno

----8.查询部门平均工资高于2000的部门编号
select deptno,avg(sal) from emp group by deptno having avg(sal)>2000

----9.查询工资高于两千的员工，且部门平均工资大于三千的部门号
select deptno ,avg(sal) from emp where sal>2000  group by deptno having avg(sal)>3000 order by avg(sal) desc;

---------------------------rollup，cube用法--------------------------------
---是在group  by 之后的，对统计的数据再次进行横向统计。
---1.
select deptno ,job,max(sal) from emp group by deptno,job
select deptno ,job,max(sal),sum(sal) from emp group by rollup( deptno,job)

---纵向统计cube
select deptno ,job,max(sal),sum(sal) from emp group by cube( deptno,job)



/*二。单行函数-----------------------------------*/
--1.字符串函数 将整数转为字符创，整数是ASCII码值

select chr(97) from dual;

-----a.链接字符串
select concat('你好','张三') from dual;
-----b.initcap 将字符串首字母转换为大写
select initcap('asd asd') from dual;
-----c.lower upper  大小写转换
select lower('ADD'),upper('asd') from dual;
select lower(ename) ,initcap(ename) from emp
-----d.lpad(field,length,full) 左边填充指定的字符，对于不够长度的，。
---------将empno指定为5，对于不够5个长度的将在左边以0填充
select lpad(empno,5,0) from emp
-----e.rpad(field,length,full) 右边填充，和lpad一样的使用
select rpad(ename,7,'*') from emp
-----f:左右填充*
select rpad(lpad(ename,7,'*'),10,'*')from emp

-----g:ltrim rtrim(str,ste1) ,删除右边左边的空格
select ltrim('   hello'),rtrim('abc*  123 *','*') from dual

-----h.substr(field,index,legth) 截取字符串 index 诺为负数从右边开始
select substr(ename,0,1) from emp;              ---截取第一个字符串
select substr(ename,length(ename)-(length(ename)-1),2),ename from emp;       --后两位的字符串



--2.数学函数
-----a.abs获取绝对值函数
select abs(-123) from dual;

-----b.ceil  floor 
select ceil(13.45) from dual;                                ---向上取整
select floor(13.45) from dual;                               ---向下取整

-----c.trunc(number,index)截取位数 index :正数为保留小数位，负数为对整数位进行截取。以小数点为准
select trunc(123.45) from dual;                              --截取整数
select trunc(123.45，1) from dual;                           --截取到一位小数

select trunc(123.45,-1) from dual;                           --截取整数，个位化为0
select trunc(123.45,-2) from dual;

--3.日期函数 
-----a.add_months(date,number)
select add_months(sysdate,2) from dual;--在当前的系统时间上增加2月
-----b.last_day 返回月份的最后一天
select last_day(sysdate) from dual;
select last_day('3-8月-2017') from dual;
-----c.month_between(date1,date2) date1-date2返回的是一个月份差
select months_between(sysdate,'3-6月-2017') from dual;
-----d.next_day（date1,'weekday'）返回指定日期的下一个最接近的日期
select next_day(sysdate,'星期六') from dual;

-----f.round(x,'unit')     将时间按照指定的格式进行四舍五入
select round(sysdate,'yyyy') from dual;
select round(to_date('02-7月-2019'),'yyyy') from dual;

-----g.trunc
select trunc(sysdate,'mm') from dual;
--4类型转换函数
-----a.to_char(obj,[format]):将日期，数字转化为指定格式的字符串
select to_char(1234412,'$999,999,999,999') from dual;---999是待填充数字
select to_char(12,'$0,000') from dual;--0:不满足指定格式就进行填充
-----b.日期转换字符串
select to_char(sysdate,'yyyy-mm-dd hh24:mi:ss') from dual;--hh24表示24小时制的
select to_char(hiredate,'yyyy-mm-dd') from emp
select to_char(hiredate,'yyyy/mm/dd') from emp
select to_char(hiredate,'yyyy_mm_dd') from emp
-----c.to_date(str,format)字符串转换日期函数
select to_date('2017-9-8 13:12:12','yyyy-mm-dd hh24:mi:ss') from dual;

-----d.to_number(str):将字面量为数字的字符创转换为数字
select to_number('123') from dual 





/*--------------------------------------------下午-------------------------------------*/
--一链接查询：
----1.内链接查询
------1.1    t1 inner join t2 on t1.条件=t2.条件
------查询员工以及所在部门名称
select ename,dname from emp t1 inner join dept t2 on t1.deptno=t2.deptno
------inner join t3 on t3.条件=t1.条件
select * from emp t1 
inner join dept t2 on t1.deptno=t2.deptno
inner join dept t3 on t1.deptno=t3.deptno

------
select * from dept, emp where dept.deptno=emp.deptno





----2外联结
------2.1左外链接
---------t1 left join  t2 on t1.条件=t2.条件
select * from emp t1 left join dept t2 on t1.deptno=t2.deptno 
---------orcal另外的一种写法:+加号在那边就以对面那边为主表
select * from emp t1 , dept t2 where t1.deptno=t2.deptno(+)

------2.2右外链接
select * from emp t1 right join  dept t2 on t1.deptno=t2.deptno
---等价于
select * from emp t1 ,  dept t2  where t1.deptno(+)=t2.deptno


----3. 全外联结 full out join on 
------返回两张表公有的数据，同时返回各自特有的数据
select * from emp t1 full  outer join dept t2 on t1.deptno=t2.deptno

----4 自连接 自己表关联自己表
-------查询每个员工对应的上级领导
select t1.ename 姓名,t1.mgr ,t2.ename 领导 from emp t1,emp t2 where t1.mgr=t2.empno(+)
select t1.ename 姓名,t1.mgr ,t2.ename 部门领导,t3.ename 部门领导的领导 from emp t1,emp t2,emp t3 where t1.mgr=t2.empno(+) and t2.mgr=t3.empno(+)

----5 笛卡尔积 链接
select * from emp , dept

----6 3张表的查询
-------查询员工姓名，工资，部门，工资等级
select * from emp
select * from dept
select * from salgrade
select initcap(t1.ename),t1.sal,initcap(t2.dname),t3.grade from salgrade t3,emp t1 left join dept t2 on t1.deptno=t2.deptno where t1.sal<t3.hisal and t1.sal>losal



----------------------------集合运算符------------------------------------------
--union (去掉重复项) union all intersect  deptno

select ename,sal from emp where deptno=10
union  
select ename,sal from emp where deptno=20
order by sal                ---先将结果合并，再order by


--1 union all（不去掉重复项）
select ename,sal from emp where deptno=10
union all 
select ename,sal from emp where deptno=20
order by sal                ---先将结果合并，再order by


---2 intersect 取交集
select ename,sal from emp where deptno=20
intersect
select ename,sal from emp where sal>=3000
---3 minus 取差值 
----查询10号部门，且工资小于3000的
select * from emp where deptno=10
minus
select * from emp where sal>3000

-------------------------------------子查询------------------------------------------
--分为多行自查询和多行子查询，子查询可以嵌套在insert,update,select,delete中
--1.单行子查询
----a.表的复制
create table tb_copyEmp as select * from emp
select * from tb_copyEmp
----b.对查询结果结果的复制
select * from tb_user
insert into tb_user (user_id,user_name) select empno,initcap(ename) from emp;
delete from tb_user where user_id in (select empno  from emp where ename like 'S%' )

delete from tb_user


--多行自查询
----any some all 
select * from emp
----查询一个比所有普通员工工资还高的经理工资
select t1.ename ,t1.mgr,t1.sal  from emp t1 where sal>(
   --普通员工最高的工资
   select max(sal)  from emp t2 where not exists(
          select * from emp t3 where t3.mgr=t2.empno
     )
   ) 
and empno in (
    select mgr from emp
)




---------------------------------作业----------------------------------------
--1 找出工资高于奖金60%的雇员。    
select * from emp where sal>(comm*1.6);


--2 找出部门10中所有经理和部门20中所有办事员的详细资料。    
select * from emp where deptno =10 and job='MANAGER' or deptno=20 and job='CLERK'

 
--3 找出部门10中所有经理，部门20中所有办事员以及既不是经理又不是办事员但其薪金大于或等2000的所有雇员的详细资料。    
SELECT * from emp where (deptno=10 and job='MANAGER') or (deptno=20 and job='CLERK') or ( deptno =20 and job not in('MANAGER','CLERK') and sal>2000 )
 
 
--4 找出收取奖金的雇员的不同工作。    
select distinct job from emp where comm is not null;

--5 找出不收取奖金或收取的奖金低于300的雇员。    
select * from emp  where comm is null or comm <300  

--6 找出各月最后一天受雇的所有雇员.
insert into emp(empno,ename,hiredate) values(6666,'aom','31-7月-1899')
select * from emp where hiredate=last_day(trunc(hiredate,'dd'))
--select  last_day(trunc(sysdate,'dd')) from dual

--7 找出晚于26(26*12个月)年之前受雇的雇员。    
select * from emp where Months_between(sysdate,hiredate)<30*12

 
--8 显示只有首字母大写的的所有雇员的姓名。    
select * from  emp where ename=initcap(ename) and (ascii(substr(ename,0,1))>65 and ascii(substr(ename,0,1))<90);


--9 显示正好为5个字符的雇员的姓名。    
select * from emp where length(ename)=5

 
--10显示不带有“R”的雇员姓名。    
select * from emp t1 where not exists(
       select * from emp t2 where ename like '%R%' and t2.ename=t1.ename
) 



--11显示所有雇员的姓名的前三个字符。    
select substr(ename,0,3) from emp



--12显所有雇员的姓名，用a替换所有“A”。
select translate(ename,'A','a') from emp
select translate(ename,'a','A') from emp

    
 
--13显示所有雇员的姓名以及满10年服务年限的日期。    
select  ename from emp where months_between(sysdate,hiredate)>10*12

--14显示雇员的详细资料，按姓名排序。    
select * from emp order by ename asc 

--15显示雇员姓名，根据其服务年限，将最老的雇员排在最前面。    
select * from emp order by trunc(hiredate,'yyyy') asc


--16显示所有雇员的姓名、工作和薪金，按工作的降序排序，而工作按薪金排序。    
select ename ,job,sal from emp order by job desc,sal desc

--17显示所有雇员的姓名和加入公司的年份和月份，按雇员受雇日所在月排序，并将最早年份的项目排在最前面。    
select ename ,trunc (hiredate,'dd') from emp order by hiredate asc, trunc(hiredate ,'mm') desc  


--18显示在一个月为30天的情况下所有雇员的日薪金，取整。    
select ename,sal/30 from emp

 
--19找出在（任何年份的）2月受聘的所有雇员。    
select * from emp where substr(to_char(hiredate,'yyyy-mm-dd'),6,2)='02'
select substr(to_char(hiredate,'yyyy-mm-dd'),6,2) from emp
--20对于每个雇员，显示其加入公司的天数。
select  ename,hiredate, trunc(sysdate-hiredate,0) 入职天数 from emp


--21求部门平均薪水等级：
select de,t1.grade from (select avg(sal) ag,deptno de  from emp group by deptno),salgrade t1 where ag> t1.losal and ag<t1.hisal

--22求部门平均的薪水等级


--23雇员中哪些人是经理人：
select * from emp t1 where exists(
       select * from emp t2 where t1.empno=t2.mgr       
); 

--24不准用聚合函数，求薪水的最高值
 select t1.empno ,t2.ename,t1.sal from (select rownum rn ,empno,sal from (select * from emp where sal is not null order by sal desc )) t1 , emp t2 where t1.empno=t2.empno and rn=1
--25求平均薪水最高的部门的部门编号  
select * from (select deptno, avg(sal) ag from emp where sal is not null group by deptno order by avg(sal) desc)
where ag=(select max(ag1) from (select avg(sal) ag1 from emp where sal is not null group by deptno  ))
--26求平均薪水最高的部门的部门名字
select * from (select rownum rn,deptno,dname from( 
  select t2.deptno,t2.dname from dept t2,
  (select  deptno, avg(sal) from emp where sal is not null group by deptno order by avg(sal) desc) t3
  where t2.deptno=t3.deptno 
) t4)where rn=1



--26求比普通员工的最高薪水还要高的经理人名称
select ename from emp t where sal>( 
    select max(sal) from emp t1 where not exists(
           select * from emp t2 where t1.empno=t2.mgr       
    )
  )
and exists (
    select * from emp t3 where t.empno=t3.mgr
  )


