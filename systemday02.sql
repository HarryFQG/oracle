--day02

--1.������ռ�
create tablespace mytablespace datafile 'F:\app\Administrator\oradata\orcl\mydata1.dbf'
size 20M 
--autoextend on --�Զ�����
autoextend on  next 10M maxsize 50M--�Զ�����,��ÿ��10M,���Ϊ50M

--increment by 5M ������5M


--�����û�
create user wangwu identified by 123
default tablespace mytablespace
temporary tablespace temp
quota 5M on mytablespace

grant create session,create table to wangwu;
grant create sequence to wangwu
--�鿴���еı�ռ�
select * from dba_tablespaces
select * from v$tablespace


---ֻ��������������
desc dba_data_files

--�鿴��ϸ�����ļ�
select file_name,tablespace_name from dba_data_files;



--2.������ʱ��ռ�
create temporary tablespace mytemp tempfile 'F:\app\Administrator\oradata\orcl\mytemp.dbf'
size 10M

--�鿴��ʱ��ռ�
select * from dba_temp_files

--�޸ı�ռ�Ĵ�С
alter database datafile 'F:\app\Administrator\oradata\orcl\mydata1.dbf'
resize 21M;
--�޸ı�ռ������
alter tablespace mytemp rename to mytemp1

--ɾ����ռ�,����ɾ�������ļ��ü��ϣ�including contents and datafile��
drop tablespace mytablespace including contents and datafiles
--����scott��ɾ�Ĳ������tb_user��Ȩ��
grant select,delete,update on wangwu.tb_user to scott

