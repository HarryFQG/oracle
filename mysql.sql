--1.�����û�
create user fqg
identified by f123 
default tablespace users                    --ָ�����û��ɲ����ı�ռ�
temporary tablespace temp                   --ָ�����û��ɲ�������ʱ��ռ�
quota 10M on users

--�����û�ʱ����ָ����ռ䣬��ζ�Ÿ��û������е����ݴ洢��������
--��Ӧ�ı�������ÿ����ռ��Ӧһ���������ݿ⣬����ָ����ռ���Ǹ��û����Բ����������ļ�

---��ѯ���б�ռ�
select * from dba_tablespaces



--�����û������½��Ȩ��
grant create session to fqg


--�����û�Ȩ�޻��ɫ��Ȩ��
--remove Ȩ�� from �û�
remove create session from fqg 

--�޸��û�
alter user fqg identified by abc

--�޸��û��ܹ������ı�ռ��С
alter user fqg quota 10M on users

--ɾ���û� �������������û������ж�������ݾ���ɾ��
drop user fqg cascade

--��fqg ���贴�����Ȩ��
grant create table to fqg
--��fqg ���贴����ռ��Ȩ��
grant create tablespace to fqg
--���û���Ҫ��ʲô����������Ա�ͱ������Ȩ��
--orcale��������Ĭ�ϵĽ�ɫ
--     1.connect        ���ӽ�ɫ������create session��
--     2.resource       ��Դ�����ɫresource�ṩ���û������Ȩ���Դ��������Լ��ı����С�����(procedure)��������(trigger)������(index)�ʹ�(cluster)
--     3.dba            ����Ա��ɫ�����������ƵĿռ��޶�͸������û��������Ȩ�޵�����

select * from dba_users
grant  resource to fqg

--�鿴ϵͳ��Ȩ��
select * from system_privilege_map

--�鿴��ǰ�û���ϵͳȨ�ޣ�
select * from user_sys_privs

--�鿴�����û���ϵͳȨ��
select * from dba_sys_privs where grantee='FQG'



--�������������ļ�������ָ�����û�
create profile myprofile limit failed_login_attempts 3
password_lock_time 2;
--����һ�����������ļ������Ƹ��û����ֻ�ܵ�½3�������û�ɹ�������2��
--���ÿ����ļ��󶨵�ָ�����û��ϡ�
alter user fqg profile myprofile;
--���˻�����
alter user fqg account unlock;



--����һ�����������ļ������ļ���Ҫ���û�ÿ��������޸����룬������Ϊ2��
create profile myprofile2 limit password_life_time 0.5
password_grace_time 2
--��fqg�����֤
alter user fqg profile myprofile2;
--ɾ�������ļ�
drop profile myprofile2 cascade;

--Ȩ�ޣ�ϵͳȨ��    ����Ȩ��
--�鿴ϵͳȨ��
select * from system_privilege_map;

--���û�һ�㶼�Ǹ���ϵͳȨ�ޡ�
grant ~ to fqg


select * from scott.emp
delete from  scott.emp where scott.emp.empno=7369


--������û�������Ȩ��
grant delete ,insert,update on scott.emp to fqg


--������ɫ
create role myrole
---�����Ȩ�޸����myrole
grant create session,create table to myrole        --���ܽ���ռ��Ȩ�������ɫ
grant create tablespace to myrole
--�� myrole�����ָ�����û�
create user lisi identified by 123
default tablespace Users temporary tablespace temp
grant myrole to lisi 
--�Ƴ�myrole
remove myrole from lisi
--�鿴myrole��������Щ��ɫ
select * from role_sys_privs 
--�鿴��ǰ�û��Ķ�������Ȩ��
select * from user_sys_privs

--��ѯ�û������еĽ�ɫ
select * from dba_role_privs where grantee='LISI' 
--��ѯ��ɫ����ЩȨ��
select *  from dba_sys_privs where grantee='myrole'


--   ��ҵ ����һ���û���Ҫ��2�ε�½ʧ�ܾ���3�죬ÿ3����һ���û���������
create profile myprofile3 limit failed_login_attempts 2
password_lock_time 3;
create profile myprofile4 limit failed_login_attempts 3
password_grace_time 0;
alter user lisi profile myprofile3;
alter user lisi profile myprofile4;
-- ����һЩȨ�ޣ�ϵͳȨ�� �� ����Ȩ��
grant select,update,delete,insert on scott.emp to lisi;
grant create trigger to lisi;

-- ����һ����ɫ��myrole������ ��½���������Ȩ��
create role myrole1 
grant create session,create table to myrole1;
grant myrole1 to lisi



--1.	�������˼·Ҫ�󣺣�ÿ��10�֣�������sql��䣩
--1)	��¼ϵͳ�û����������û�s_1108������s1108
create user s_1108 identified by s1108
default tablespace users
temporary tablespace temp


--2)	���û�ϵͳ�����ɫDBA
grant dba to s_1108
--3)	�ڵ�ǰ�û��д�����t_1108��id��������
create table tb_s(
       id int primary key ,
       name varchar(10),
       pwd varchar(12)
);

--4)	�����в���5������
insert into tb_s(id,name,pwd)values(1,'����','123');
insert into tb_s(id,name,pwd)values(2,'����','123');
insert into tb_s(id,name,pwd)values(3,'����','123');
insert into tb_s(id,name,pwd)values(4,'Ǯ��','234');
insert into tb_s(id,name,pwd)values(5,'����','345');
--5)	����������һ���ֶ�birthday(date)��ɾ��pwd�ֶ�
alter table tb_s add sage int;
alter table tb_s add birthday date;
alter table tb_s drop column pwd;
--6)	�����ĵ������޸�Ϊϵͳ��ǰʱ��
update tb_s set birthday=sysdate where name='����'
--7)	��ѯ�����е��������ݣ��������併������
select * from tb_s order by sage desc
--8)	��ѯ������������Ա����Ϣ
select * from tb_s where sage = (select max(sage) from tb_s)
--9)	��������������С��18����Ա�������޸�Ϊabc
alter table tb_s add pwd varchar(12);
select * from tb_s where sage = (select max(sage) from tb_s)
update tb_s set pwd='abc' where sage<18







