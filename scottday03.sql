/*-------------------------------day03����----------------------------------------------*/
select * from emp where empno=&empno
---ָ����Ҫ��ѯ�������С����磺empno,sal,ename������
select &a  from emp

------------------------------------------------------------
--һ.�ۺϺ��������У� 5��sum��count��avg��max,min
----    1.���������˵Ĺ���
select sum(sal) from emp          ---�޶��������͵�����
----   2.��emp���������
select count(empno) from emp
----   3.��ѯ��߹���
select max(sal) from emp          ----����char��number����
select max(ename) from emp
select min(sal) from emp
----   4.ƽ�����ʣ�
select avg(sal) from emp;


-----�󽱽��ƽ��ֵ��
select avg(comm) from emp--����ֵΪ�յ����ݲ�����ͳ�ơ�������550��ֻ����4


----------------------------�ۺϺ���һ�����ڣ��Ӳ�ѯ�ͷ����ѯ------
------1��ѯ��߹��ʺ�Ա����������ְλ
select ename , job from emp where sal=(select max(sal) from emp)
------2.���ʸ���ƽ�����ʵ�Ա����
select ename , job from emp where sal>(select avg(sal) from emp)
------3.��ѯ���ʸ���30�Ų��ŵ������˵Ĺ���
select * from emp where sal>all(select sal from emp where deptno=30 )
---------�ȼ���
select * from emp where sal > (select max(sal) from emp where deptno=30)

-----4.������ͳ����߹��ʺ���͹���
select max(sal),min(sal) from emp group by deptno;
--------ע�⣺�ڷ���sql�У�select ����ֻ���Ƿ����ֶκ;ۺϺ���
select deptno, max(sal),min(sal) from emp group by deptno;
select deptno,ename, max(sal),min(sal) from emp group by deptno;--����д����ename�ֶβ�������group by����ķ����ֶ�
-----5.��ʾÿ�������ж����ˣ�
select deptno ,count(*) from emp group by deptno;
-----6.��ʾ�����ź͹�����λ��������
select deptno,job ,count(*) from emp group by deptno,job order by deptno desc;
select * from emp;
----7.��ѯ���ʸ���2000�Ĳ���ƽ������
select deptno,avg(sal) from emp where sal>2000 group by deptno

----8.��ѯ����ƽ�����ʸ���2000�Ĳ��ű��
select deptno,avg(sal) from emp group by deptno having avg(sal)>2000

----9.��ѯ���ʸ�����ǧ��Ա�����Ҳ���ƽ�����ʴ�����ǧ�Ĳ��ź�
select deptno ,avg(sal) from emp where sal>2000  group by deptno having avg(sal)>3000 order by avg(sal) desc;

---------------------------rollup��cube�÷�--------------------------------
---����group  by ֮��ģ���ͳ�Ƶ������ٴν��к���ͳ�ơ�
---1.
select deptno ,job,max(sal) from emp group by deptno,job
select deptno ,job,max(sal),sum(sal) from emp group by rollup( deptno,job)

---����ͳ��cube
select deptno ,job,max(sal),sum(sal) from emp group by cube( deptno,job)



/*�������к���-----------------------------------*/
--1.�ַ������� ������תΪ�ַ�����������ASCII��ֵ

select chr(97) from dual;

-----a.�����ַ���
select concat('���','����') from dual;
-----b.initcap ���ַ�������ĸת��Ϊ��д
select initcap('asd asd') from dual;
-----c.lower upper  ��Сдת��
select lower('ADD'),upper('asd') from dual;
select lower(ename) ,initcap(ename) from emp
-----d.lpad(field,length,full) ������ָ�����ַ������ڲ������ȵģ���
---------��empnoָ��Ϊ5�����ڲ���5�����ȵĽ��������0���
select lpad(empno,5,0) from emp
-----e.rpad(field,length,full) �ұ���䣬��lpadһ����ʹ��
select rpad(ename,7,'*') from emp
-----f:�������*
select rpad(lpad(ename,7,'*'),10,'*')from emp

-----g:ltrim rtrim(str,ste1) ,ɾ���ұ���ߵĿո�
select ltrim('   hello'),rtrim('abc*  123 *','*') from dual

-----h.substr(field,index,legth) ��ȡ�ַ��� index ŵΪ�������ұ߿�ʼ
select substr(ename,0,1) from emp;              ---��ȡ��һ���ַ���
select substr(ename,length(ename)-(length(ename)-1),2),ename from emp;       --����λ���ַ���



--2.��ѧ����
-----a.abs��ȡ����ֵ����
select abs(-123) from dual;

-----b.ceil  floor 
select ceil(13.45) from dual;                                ---����ȡ��
select floor(13.45) from dual;                               ---����ȡ��

-----c.trunc(number,index)��ȡλ�� index :����Ϊ����С��λ������Ϊ������λ���н�ȡ����С����Ϊ׼
select trunc(123.45) from dual;                              --��ȡ����
select trunc(123.45��1) from dual;                           --��ȡ��һλС��

select trunc(123.45,-1) from dual;                           --��ȡ��������λ��Ϊ0
select trunc(123.45,-2) from dual;

--3.���ں��� 
-----a.add_months(date,number)
select add_months(sysdate,2) from dual;--�ڵ�ǰ��ϵͳʱ��������2��
-----b.last_day �����·ݵ����һ��
select last_day(sysdate) from dual;
select last_day('3-8��-2017') from dual;
-----c.month_between(date1,date2) date1-date2���ص���һ���·ݲ�
select months_between(sysdate,'3-6��-2017') from dual;
-----d.next_day��date1,'weekday'������ָ�����ڵ���һ����ӽ�������
select next_day(sysdate,'������') from dual;

-----f.round(x,'unit')     ��ʱ�䰴��ָ���ĸ�ʽ������������
select round(sysdate,'yyyy') from dual;
select round(to_date('02-7��-2019'),'yyyy') from dual;

-----g.trunc
select trunc(sysdate,'mm') from dual;
--4����ת������
-----a.to_char(obj,[format]):�����ڣ�����ת��Ϊָ����ʽ���ַ���
select to_char(1234412,'$999,999,999,999') from dual;---999�Ǵ��������
select to_char(12,'$0,000') from dual;--0:������ָ����ʽ�ͽ������
-----b.����ת���ַ���
select to_char(sysdate,'yyyy-mm-dd hh24:mi:ss') from dual;--hh24��ʾ24Сʱ�Ƶ�
select to_char(hiredate,'yyyy-mm-dd') from emp
select to_char(hiredate,'yyyy/mm/dd') from emp
select to_char(hiredate,'yyyy_mm_dd') from emp
-----c.to_date(str,format)�ַ���ת�����ں���
select to_date('2017-9-8 13:12:12','yyyy-mm-dd hh24:mi:ss') from dual;

-----d.to_number(str):��������Ϊ���ֵ��ַ���ת��Ϊ����
select to_number('123') from dual 





/*--------------------------------------------����-------------------------------------*/
--һ���Ӳ�ѯ��
----1.�����Ӳ�ѯ
------1.1    t1 inner join t2 on t1.����=t2.����
------��ѯԱ���Լ����ڲ�������
select ename,dname from emp t1 inner join dept t2 on t1.deptno=t2.deptno
------inner join t3 on t3.����=t1.����
select * from emp t1 
inner join dept t2 on t1.deptno=t2.deptno
inner join dept t3 on t1.deptno=t3.deptno

------
select * from dept, emp where dept.deptno=emp.deptno





----2������
------2.1��������
---------t1 left join  t2 on t1.����=t2.����
select * from emp t1 left join dept t2 on t1.deptno=t2.deptno 
---------orcal�����һ��д��:+�Ӻ����Ǳ߾��Զ����Ǳ�Ϊ����
select * from emp t1 , dept t2 where t1.deptno=t2.deptno(+)

------2.2��������
select * from emp t1 right join  dept t2 on t1.deptno=t2.deptno
---�ȼ���
select * from emp t1 ,  dept t2  where t1.deptno(+)=t2.deptno


----3. ȫ������ full out join on 
------�������ű��е����ݣ�ͬʱ���ظ������е�����
select * from emp t1 full  outer join dept t2 on t1.deptno=t2.deptno

----4 ������ �Լ�������Լ���
-------��ѯÿ��Ա����Ӧ���ϼ��쵼
select t1.ename ����,t1.mgr ,t2.ename �쵼 from emp t1,emp t2 where t1.mgr=t2.empno(+)
select t1.ename ����,t1.mgr ,t2.ename �����쵼,t3.ename �����쵼���쵼 from emp t1,emp t2,emp t3 where t1.mgr=t2.empno(+) and t2.mgr=t3.empno(+)

----5 �ѿ����� ����
select * from emp , dept

----6 3�ű�Ĳ�ѯ
-------��ѯԱ�����������ʣ����ţ����ʵȼ�
select * from emp
select * from dept
select * from salgrade
select initcap(t1.ename),t1.sal,initcap(t2.dname),t3.grade from salgrade t3,emp t1 left join dept t2 on t1.deptno=t2.deptno where t1.sal<t3.hisal and t1.sal>losal



----------------------------���������------------------------------------------
--union (ȥ���ظ���) union all intersect  deptno

select ename,sal from emp where deptno=10
union  
select ename,sal from emp where deptno=20
order by sal                ---�Ƚ�����ϲ�����order by


--1 union all����ȥ���ظ��
select ename,sal from emp where deptno=10
union all 
select ename,sal from emp where deptno=20
order by sal                ---�Ƚ�����ϲ�����order by


---2 intersect ȡ����
select ename,sal from emp where deptno=20
intersect
select ename,sal from emp where sal>=3000
---3 minus ȡ��ֵ 
----��ѯ10�Ų��ţ��ҹ���С��3000��
select * from emp where deptno=10
minus
select * from emp where sal>3000

-------------------------------------�Ӳ�ѯ------------------------------------------
--��Ϊ�����Բ�ѯ�Ͷ����Ӳ�ѯ���Ӳ�ѯ����Ƕ����insert,update,select,delete��
--1.�����Ӳ�ѯ
----a.��ĸ���
create table tb_copyEmp as select * from emp
select * from tb_copyEmp
----b.�Բ�ѯ�������ĸ���
select * from tb_user
insert into tb_user (user_id,user_name) select empno,initcap(ename) from emp;
delete from tb_user where user_id in (select empno  from emp where ename like 'S%' )

delete from tb_user


--�����Բ�ѯ
----any some all 
select * from emp
----��ѯһ����������ͨԱ�����ʻ��ߵľ�����
select t1.ename ,t1.mgr,t1.sal  from emp t1 where sal>(
   --��ͨԱ����ߵĹ���
   select max(sal)  from emp t2 where not exists(
          select * from emp t3 where t3.mgr=t2.empno
     )
   ) 
and empno in (
    select mgr from emp
)




---------------------------------��ҵ----------------------------------------
--1 �ҳ����ʸ��ڽ���60%�Ĺ�Ա��    
select * from emp where sal>(comm*1.6);


--2 �ҳ�����10�����о���Ͳ���20�����а���Ա����ϸ���ϡ�    
select * from emp where deptno =10 and job='MANAGER' or deptno=20 and job='CLERK'

 
--3 �ҳ�����10�����о�������20�����а���Ա�Լ��Ȳ��Ǿ����ֲ��ǰ���Ա����н����ڻ��2000�����й�Ա����ϸ���ϡ�    
SELECT * from emp where (deptno=10 and job='MANAGER') or (deptno=20 and job='CLERK') or ( deptno =20 and job not in('MANAGER','CLERK') and sal>2000 )
 
 
--4 �ҳ���ȡ����Ĺ�Ա�Ĳ�ͬ������    
select distinct job from emp where comm is not null;

--5 �ҳ�����ȡ�������ȡ�Ľ������300�Ĺ�Ա��    
select * from emp  where comm is null or comm <300  

--6 �ҳ��������һ���ܹ͵����й�Ա.
insert into emp(empno,ename,hiredate) values(6666,'aom','31-7��-1899')
select * from emp where hiredate=last_day(trunc(hiredate,'dd'))
--select  last_day(trunc(sysdate,'dd')) from dual

--7 �ҳ�����26(26*12����)��֮ǰ�ܹ͵Ĺ�Ա��    
select * from emp where Months_between(sysdate,hiredate)<30*12

 
--8 ��ʾֻ������ĸ��д�ĵ����й�Ա��������    
select * from  emp where ename=initcap(ename) and (ascii(substr(ename,0,1))>65 and ascii(substr(ename,0,1))<90);


--9 ��ʾ����Ϊ5���ַ��Ĺ�Ա��������    
select * from emp where length(ename)=5

 
--10��ʾ�����С�R���Ĺ�Ա������    
select * from emp t1 where not exists(
       select * from emp t2 where ename like '%R%' and t2.ename=t1.ename
) 



--11��ʾ���й�Ա��������ǰ�����ַ���    
select substr(ename,0,3) from emp



--12�����й�Ա����������a�滻���С�A����
select translate(ename,'A','a') from emp
select translate(ename,'a','A') from emp

    
 
--13��ʾ���й�Ա�������Լ���10��������޵����ڡ�    
select  ename from emp where months_between(sysdate,hiredate)>10*12

--14��ʾ��Ա����ϸ���ϣ�����������    
select * from emp order by ename asc 

--15��ʾ��Ա������������������ޣ������ϵĹ�Ա������ǰ�档    
select * from emp order by trunc(hiredate,'yyyy') asc


--16��ʾ���й�Ա��������������н�𣬰������Ľ������򣬶�������н������    
select ename ,job,sal from emp order by job desc,sal desc

--17��ʾ���й�Ա�������ͼ��빫˾����ݺ��·ݣ�����Ա�ܹ������������򣬲���������ݵ���Ŀ������ǰ�档    
select ename ,trunc (hiredate,'dd') from emp order by hiredate asc, trunc(hiredate ,'mm') desc  


--18��ʾ��һ����Ϊ30�����������й�Ա����н��ȡ����    
select ename,sal/30 from emp

 
--19�ҳ��ڣ��κ���ݵģ�2����Ƹ�����й�Ա��    
select * from emp where substr(to_char(hiredate,'yyyy-mm-dd'),6,2)='02'
select substr(to_char(hiredate,'yyyy-mm-dd'),6,2) from emp
--20����ÿ����Ա����ʾ����빫˾��������
select  ename,hiredate, trunc(sysdate-hiredate,0) ��ְ���� from emp


--21����ƽ��нˮ�ȼ���
select de,t1.grade from (select avg(sal) ag,deptno de  from emp group by deptno),salgrade t1 where ag> t1.losal and ag<t1.hisal

--22����ƽ����нˮ�ȼ�


--23��Ա����Щ���Ǿ����ˣ�
select * from emp t1 where exists(
       select * from emp t2 where t1.empno=t2.mgr       
); 

--24��׼�þۺϺ�������нˮ�����ֵ
 select t1.empno ,t2.ename,t1.sal from (select rownum rn ,empno,sal from (select * from emp where sal is not null order by sal desc )) t1 , emp t2 where t1.empno=t2.empno and rn=1
--25��ƽ��нˮ��ߵĲ��ŵĲ��ű��  
select * from (select deptno, avg(sal) ag from emp where sal is not null group by deptno order by avg(sal) desc)
where ag=(select max(ag1) from (select avg(sal) ag1 from emp where sal is not null group by deptno  ))
--26��ƽ��нˮ��ߵĲ��ŵĲ�������
select * from (select rownum rn,deptno,dname from( 
  select t2.deptno,t2.dname from dept t2,
  (select  deptno, avg(sal) from emp where sal is not null group by deptno order by avg(sal) desc) t3
  where t2.deptno=t3.deptno 
) t4)where rn=1



--26�����ͨԱ�������нˮ��Ҫ�ߵľ���������
select ename from emp t where sal>( 
    select max(sal) from emp t1 where not exists(
           select * from emp t2 where t1.empno=t2.mgr       
    )
  )
and exists (
    select * from emp t3 where t.empno=t3.mgr
  )


