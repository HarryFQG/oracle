--������
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
--�������
insert into student values(1001,'����','��','163.@163.com','4-5��-1995',123.23,systimestamp);
insert into student values(1002,'����','��','163.@163.com','4-5��-1995',123.123,systimestamp);
insert into student values(1003,'����','��','163.@163.com','4-5��-1995',123.128,systimestamp);
insert into student values(idsequence.nextval,'Ǯ��','��','163.@163.com','4-5��-1995',123.128,systimestamp);

--������������Ψһ�����
create sequence idsequence
       --ָ���������е���ʼ��
       start with 10
       --ָ���������к�֮��ļ����С��������Ϊ1
       increment by 1
       --�������кţ�Ϊ30
       maxvalue 30
       --��СֵΪ10
       minvalue 8
       nocycle      --�Ƿ�ѭ��
       cache 2     --����һ������2��
--�޸�����
alter sequence idsequence maxvalue 1000 cycle

--ɾ������
drop sequence idsequence;


--�鿴����
select idsequence.nextval from dual;--������һ�����кţ�ÿ�����кŲ���֮���ٴ�ִ���򷵻���һ�����к�
--���ص�ǰ���к�
select idsequence.currval from dual


/*--------------------------------------------------------------------------*/
select * from emp;

select * from dept;
select * from dept;

select * from emp where deptno=10

select * from wangwu.tb_user

--��ʾ�кţ�rownum ,��ʾÿһ���������ڵ�λ��:rowid
select rownum ,empno,ename,job,rowid from emp

--ʹ��α��dual
select 1+1 as sum from dual

--orcale��ҳ
select * from (select rownum rn,emp.* from emp)where rn>0 and rn<5

select t2.* from (select rownum rn,emp.empno from emp) t1,emp t2 where t1.empno=t2.empno and rn>5 and rn<=10



--��ҳ��ѯ����������ѯ���д�A���˵���Ϣ������ÿҳ��ʾ5��
select * from emp
select t3.rn,t1.* from  (select rownum rn ,t2.empno from emp t2 )t3 ,emp t1
where t3.empno=t1.empno and t3.rn>0 and t3.rn<=5

--��ҳ��ѯ����ѯ������������A��ĸ���ˣ�����ÿҳ��ʾ����
select rownum rn ,t2.empno from (select * from  emp where ename like '%A%') t1,emp t2 where t1.empno=t2.empno

select * from  (select rownum rn ,t2.empno from (select * from  emp where ename like '%A%') t1,emp t2 where t1.empno=t2.empno
) t2,emp t3
where t2.empno=t3.empno and t2.rn>5 and t2.rn<=10 

select * from emp where ename like '%A%'

----��ʽ2��ʹ����������
select * from (select rownum rn ,t2.* from emp t1 left join emp t2 on t1.empno=t2.empno where t1.ename like '%A%' )t1 
where t1.rn>5 and t1.rn<=10




--��ʾ�͹���������20%
select ename,sal*1.2,sal from emp

--��ʾemp��Ĺ�Ա�����Լ����ʸ������ĺ�
-----nvl(arg1,arg2):�ж�arg1�ֶ��Ƿ�Ϊ�գ����Ϊ������arg2����
select ename,sal+nvl(comm,0) from emp
-----nvl2(arg1,arg2,arg3):���arg1Ϊ�գ��򷵻�arg3����Ϊ�յĻ��ͷ���arg2;
select comm,nvl2(comm,'�н���','�޽���') from emp;

--�������д��������ַ��ͼ�˫����("")��������('')�൱���������
select ename as "Ա�� ����" from emp
select ename as "Ա�� ����",'������  Ա�� ����' as "Ա�� ����" from emp


--���ӷ���concat()����:������ƴ���ַ�
select ename||'--------'||job as "Ա��ְ���" from emp
select concat(ename,concat('-----',job)) as "Ա��ְ���" from emp

---����accounting���ڵĳ���ΪnewYork


--distinct�����ظ���
select distinct job from emp

---���ղ��ź͹�������
select * from emp order by deptno asc,sal desc

--  ��ѯ��Ա�����͹�Ӷ���ڣ�������Ӷ�������򣬺��Ӷ������ʾ��
select * from emp order by hiredate desc

--�����ʺ͹����·ݵĳ˻��������벢ִ�в�ѯ
select emp.* ,sal*Months_between(sysdate,hiredate) as "���ʳ��Թ���" from emp 
--Months_between(ʱ��1��ʱ��2)����������ʱ��Ĳ�
select  Months_between(sysdate,hiredate) from emp

-- and or not 
select * from emp where sal>3000 and deptno=10;
select * from emp where sal>3000 or deptno=10;
select * from emp where job not in('manager');

--exists �Ƿ���� not exists

select * from emp t1 where exists(select * from emp t2 where deptno=10 and t1.deptno=t2.deptno)


---���ȼ� not >and   >or
--��ѯ10�Ų��ŵ�ְλ��manager��30 �Ų��ŵ�ְλ��salesman��Ա�� 
select * from emp where deptno=10 and job='manager' or deptno=30 and job='SALESMAN'



--��ʾְ��Ϊclerr����manager�Ĺ�Ա��־

--��ʾ����10�Ͳ���20�й���С��1500�Ĺ�Ա





--��ѯ��ʾ������1000~2000֮��Ĺ�Ա
select * from emp where sal between 1000 and 2000; 
---��ѯ��ְʱ����1980-1897��֮���Ա��
select * from emp where hiredate between '01-1��-1980' and '31-12��-85' order by hiredate desc  

--likeģ����ѯ
---��ѯ������S��ͷ�Ĺ�Ա��Ϣ
select * from emp  where ename like 'S%'
---��ѯ�����ڶ�����ĸ����a��ͷ������
select * from  emp where ename like '_A%'
---��ѯename�а���%��Ա������Ҫת��:escape ����ת���ַ�
select * from emp where ename like '%#%%'
select * from emp where ename like '%\%' escape '\'
--��ѯû�н����Ա����Ϣ
select * from emp where comm is null;

--any ��some ��Ӧ�ó���һ������ѯ����С��10���ŵ�����һ��Ա���Ĺ���(С�����Ĺ���)
select * from emp where sal<any(select sal from emp where deptno=10)


--all   ���� 
select * fROM emp where sal <all(select sal from emp where deptno=10)



--1Ӷ����ڹ���60%�Ĺ�Ա
select * from emp where mgr>sal*1.6
--2.�ҳ�����10 �����еľ���Ͳ���20�����а���Ա����ϸ����
select * from emp where (deptno=10 and job='MANAGER') or (deptno=20 and job='CLERK')

--4.



 
