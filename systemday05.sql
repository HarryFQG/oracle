create table my_event(
   event varchar2(25),    
   username varchar2(30),
   createdate date


       
);
create or replace trigger tri_ddl
after ddl on scott.schema
begin
  dbms_output.put_line('�û�����ִ��DDL���'||ora_login_user);
  insert into my_event values(ora_sysevent,ora_login_user,sysdate);
  
end;

select *  from my_event;

---ϵͳ������
create table log_table(
        username varchar2(20),      
        logon_time date,
        logoff_time date,
        address varchar2(30)
     
);
select * from log_table;
create or replace trigger tri_sys_event
after logon  on database
begin
  dbms_output.put_line(ora_login_user||'���ڵ�½');
  Insert into log_table values(ora_login_user,sysdate,null,ora_client_ip_address);
end;


