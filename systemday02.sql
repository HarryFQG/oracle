--day02

--1.创建表空间
create tablespace mytablespace datafile 'F:\app\Administrator\oradata\orcl\mydata1.dbf'
size 20M 
--autoextend on --自动增长
autoextend on  next 10M maxsize 50M--自动增长,且每次10M,最大为50M

--increment by 5M 自增长5M


--创建用户
create user wangwu identified by 123
default tablespace mytablespace
temporary tablespace temp
quota 5M on mytablespace

grant create session,create table to wangwu;
grant create sequence to wangwu
--查看所有的表空间
select * from dba_tablespaces
select * from v$tablespace


---只能在命令行运行
desc dba_data_files

--查看详细数据文件
select file_name,tablespace_name from dba_data_files;



--2.创建临时表空间
create temporary tablespace mytemp tempfile 'F:\app\Administrator\oradata\orcl\mytemp.dbf'
size 10M

--查看临时表空间
select * from dba_temp_files

--修改表空间的大小
alter database datafile 'F:\app\Administrator\oradata\orcl\mydata1.dbf'
resize 21M;
--修改表空间的名称
alter tablespace mytemp rename to mytemp1

--删除表空间,并且删除数据文件得加上（including contents and datafile）
drop tablespace mytablespace including contents and datafiles
--赋予scott增删改查王五的tb_user的权限
grant select,delete,update on wangwu.tb_user to scott

