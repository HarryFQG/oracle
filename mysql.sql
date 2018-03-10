--1.创建用户
create user fqg
identified by f123 
default tablespace users                    --指定该用户可操作的表空间
temporary tablespace temp                   --指定该用户可操作的临时表空间
quota 10M on users

--创建用户时必须指定表空间，意味着该用户下所有的数据存储，都放在
--对应的表空里，由于每个表空间对应一个无理数据库，所有指定表空间就是该用户可以操作的数据文件

---查询所有表空间
select * from dba_tablespaces



--给该用户赋予登陆的权限
grant create session to fqg


--撤销用户权限或角色的权限
--remove 权限 from 用户
remove create session from fqg 

--修改用户
alter user fqg identified by abc

--修改用户能够操作的表空间大小
alter user fqg quota 10M on users

--删除用户 级联操作，该用户的所有对象和数据均被删除
drop user fqg cascade

--给fqg 赋予创建表的权限
grant create table to fqg
--给fqg 赋予创建表空间的权限
grant create tablespace to fqg
--当用户需要做什么操作，管理员就必须分配权限
--orcale中有三个默认的角色
--     1.connect        链接角色（包括create session）
--     2.resource       资源管理角色resource提供给用户另外的权限以创建他们自己的表、序列、过程(procedure)、触发器(trigger)、索引(index)和簇(cluster)
--     3.dba            管理员角色。包括无限制的空间限额和给其他用户授予各种权限的能力

select * from dba_users
grant  resource to fqg

--查看系统的权限
select * from system_privilege_map

--查看当前用户的系统权限，
select * from user_sys_privs

--查看所有用户的系统权限
select * from dba_sys_privs where grantee='FQG'



--创建口令限制文件，限制指定的用户
create profile myprofile limit failed_login_attempts 3
password_lock_time 2;
--创建一个口令限制文件，限制该用户最多只能登陆3次如果还没成功就锁定2天
--将该口令文件绑定到指定的用户上。
alter user fqg profile myprofile;
--给账户解锁
alter user fqg account unlock;



--创建一个口令限制文件限制文件，要求用户每隔半天就修改密码，宽限期为2天
create profile myprofile2 limit password_life_time 0.5
password_grace_time 2
--给fqg添加验证
alter user fqg profile myprofile2;
--删除口令文件
drop profile myprofile2 cascade;

--权限：系统权限    对象权限
--查看系统权限
select * from system_privilege_map;

--给用户一般都是赋予系统权限。
grant ~ to fqg


select * from scott.emp
delete from  scott.emp where scott.emp.empno=7369


--给别的用户赋予多个权限
grant delete ,insert,update on scott.emp to fqg


--创建角色
create role myrole
---将多个权限赋予给myrole
grant create session,create table to myrole        --不能将表空间的权限授予角色
grant create tablespace to myrole
--将 myrole赋予给指定的用户
create user lisi identified by 123
default tablespace Users temporary tablespace temp
grant myrole to lisi 
--移除myrole
remove myrole from lisi
--查看myrole下面有哪些角色
select * from role_sys_privs 
--查看当前用户的对象下面权限
select * from user_sys_privs

--查询用户所具有的角色
select * from dba_role_privs where grantee='LISI' 
--查询角色有哪些权限
select *  from dba_sys_privs where grantee='myrole'


--   作业 创建一个用户，要求2次登陆失败就锁3天，每3天检查一次用户更改密码
create profile myprofile3 limit failed_login_attempts 2
password_lock_time 3;
create profile myprofile4 limit failed_login_attempts 3
password_grace_time 0;
alter user lisi profile myprofile3;
alter user lisi profile myprofile4;
-- 赋予一些权限，系统权限 和 对象权限
grant select,update,delete,insert on scott.emp to lisi;
grant create trigger to lisi;

-- 创建一个角色（myrole），绑定 登陆，创建表的权限
create role myrole1 
grant create session,create table to myrole1;
grant myrole1 to lisi



--1.	案例完成思路要求：（每题10分，必须有sql语句）
--1)	登录系统用户来创建新用户s_1108，密码s1108
create user s_1108 identified by s1108
default tablespace users
temporary tablespace temp


--2)	给用户系统赋予角色DBA
grant dba to s_1108
--3)	在当前用户中创建表t_1108（id，主键）
create table tb_s(
       id int primary key ,
       name varchar(10),
       pwd varchar(12)
);

--4)	给表中插入5条数据
insert into tb_s(id,name,pwd)values(1,'李四','123');
insert into tb_s(id,name,pwd)values(2,'张三','123');
insert into tb_s(id,name,pwd)values(3,'赵六','123');
insert into tb_s(id,name,pwd)values(4,'钱七','234');
insert into tb_s(id,name,pwd)values(5,'王五','345');
--5)	给表中增加一个字段birthday(date)，删掉pwd字段
alter table tb_s add sage int;
alter table tb_s add birthday date;
alter table tb_s drop column pwd;
--6)	将李四的生日修改为系统当前时间
update tb_s set birthday=sysdate where name='李四'
--7)	查询出表中的所有数据，按照年龄降序排列
select * from tb_s order by sage desc
--8)	查询出年龄最大的人员的信息
select * from tb_s where sage = (select max(sage) from tb_s)
--9)	将表中所有年龄小于18的人员的密码修改为abc
alter table tb_s add pwd varchar(12);
select * from tb_s where sage = (select max(sage) from tb_s)
update tb_s set pwd='abc' where sage<18







