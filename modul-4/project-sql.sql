create database mydb3;
use mydb3;
drop table emp;
create table emp (
 Empno int not null primary key default 0,
 Ename varchar(10) default null,
 Job varchar(9) default null,
 Mgr int default null,
 Hiredate date default null,
 Sal decimal(7,2) default null,
 Comm decimal(7,2) default null,
 deptno int default null
 );
 
insert into emp
value (7369,"Smith", "Clerk",7902,"1980-12-17",800.00,null,20),
      (7499,"Allen", "Salesman",7698,"1981-02-20",1600.00,300.00,30),
      (7521,"Ward", "Salesman",7698,"1981-02-22",1250.00,500.00,30),
      (7566,"Jones", "Manager",7839,"1981-04-02",2975.00,null,20),
      (7654,"Martin", "Salesman",7698,"1981-09-28",1250.00,1400.00,30),
      (7698,"Blake", "Manager",7839,"1981-05-01",2850.00,null,30),
      (7782,"Clark", "Manager",7839,"1981-06-09",2450.00,null,10),
      (7788,"Scott", "Analyst",7566,"1987-06-11",3000.00,null,20),
      (7839,"King", "President",null,"1981-11-17",5000.00,null,10),
      (7844,"Turner", "Salesman",7698,"1981-08-09",1500.00,0.00,30),
      (7876,"Adams", "Clerk",7788,"1987-07-13",1100.00,null,20),
      (7900,"James", "Clerk",7698,"1981-03-12",950.00,null,30),
      (7902,"Ford", "Analyst",7566,"1981-03-12",3000.00,null,20),
      (7934,"Miller", "Clerk",7782,"1982-01-23",1300.00,null,10);
      
create table dept(
Deptno int not null primary key default 0,
Dname varchar(14) default null,
Loc varchar(13) default null
);


insert into dept
values (10,"Accountting","New york"),
       (20,"Research","Dallas"),
       (30,"Sales","Chicago"),
       (40,"Operations","Boston");
       drop table student;
create table student (
 Rno int not null primary key default 0,
 Sname varchar(14) default null ,
 City varchar(20) default null,
 Sate varchar(20) default null
);

insert into student
values (1,"heer","surat","gujarat"),
	(2,"isha","lal kot","delhi"),
	(3,"vishva","surat","gujarat"),
	(4,"nishtha","ahmedabad","gujarat"),
	(5,"harshvi","jaipur","rajasthan");
    select * from student;


create table emp_log(
emp_id int  not null primary key  default 0,
log_date date default null,
new_salary int default null,
action varchar(20) default null
);
insert into emp_log
values (11,"2005-01-11",15000,"salary update"),
(12,"2005-6-11",10000,"salary update"),
(13,"2005-06-12",8000,"salary update"),
(14,"2005-9-10",7000,"salary update"),
(15,"2005-10-11",5000,"salary update");
select * from emp_log;

# 1. Select unique job from EMP table.
select distinct job from emp;

#2. List the details of the emps in asc order of the Dptnos and desc of Jobs?
select * from emp
order by deptno asc,
		job desc;
        
#3. Display all the unique job groups in the descending order?
select distinct job from emp
order by job desc;

# 4. List the emps who joined before 1981. 
select*from emp
where hiredate < "1981-1-1";

#List the Empno, Ename, Sal, Daily sal of all emps in the asc order of annsal
select
empno,
ename,
sal,
sal /30 as daily_sal,
sal*12 as annual_sal
from emp
 order by annual_sal asc;
 
 # 6. List the Empno, Ename, Sal, Exp of all emps working for Mgr 7369.
 select 
 empno,
 ename,
 sal
 from emp
 where mgr =7369;
 
# 7. Display all the details of the emps who’s Comm. Is more than their Sal?
select*from emp
where comm > sal;

#8. List the emps who are either ‘CLERK’ or ‘ANALYST’ in the Desc order. 
select * from emp 
where job in ("clerk","analyst")
order by job desc;

# 9. List the emps Who Annual sal ranging from 22000 and 45000.
select * from emp
where (sal*12) between 22000 and 45000;

# 10. List the Enames those are starting with ‘S’ and with five characters.
select * from emp
where ename like "s%%%%";

# 11. List the emps whose Empno not starting with digit78.
select * from emp
where empno not like "78%%";

# 12. List all the Clerks of Deptno 20. 
select * from emp
where job = "clerk" and deptno = 20;

# 13. List the Emps who are senior to their own MGRS.
select ename from emp
where empno > mgr;


#14. List the Emps of Deptno 20 who’s Jobs are same as Deptno10.
select * from emp
where deptno =20 and job in (select job from emp where deptno =10);

#15. List the Emps who’s Sal is same as FORD or SMITH in desc order of Sal.
select * from emp
where sal in (select sal from emp where ename in ( "ford","smith"))
order by sal desc; 

# 16. List the emps whose jobs same as SMITH or ALLEN. 
select *from emp
where job in ( select job from emp where ename in ("smith","allen"))
order by job;

# 17. Any jobs of deptno 10 those that are not found in deptno 20.
select * from emp
where deptno = 10 and job not in ( select job from emp where deptno =20);

# 18. Find the highest sal of EMP table.
select max(sal)from emp;

#19. Find details of highest paid employee.
select * from emp
order by sal desc
limit 1;

#20. Find the total sal given to the MGR.
select sum(sal) from emp;

#21. List the emps whose names contains ‘A’.
select * from emp
where ename  like "a%%%%";

#22. Find all the emps who earn the minimum Salary for each job wise in ascending order. 
select 
 ename,
 job,
 min(sal) 
 from emp
group by ename,
         job
order by job asc;

#23. List the emps whose sal greater than Blake’s sal.
select * from emp
where sal > (select sal from emp where ename = "blake");

#24. Create view v1 to select ename, job, dname, loc whose deptno are same.  
create view v1 as 
select
 ename,
 job,
 dname,
 loc
from emp
join dept
on emp.deptno = dept.deptno;

#25. Create a procedure with dno as input parameter to fetch ename and dname.
delimiter $$
create procedure  dno ( in dno int)
begin 
 select 
 emp.ename,
 dept.dname
 from emp
 join dept
 on emp.deptno = dept.deptno
 where emp.deptno = dno;
 end $$
 delimiter ;
 call dno(30);
 drop procedure dno;
 
 #26. Add column Pin with bigint data type in table student. 
 alter table student
 add pin int;
 select * from student;
 
 #27. Modify the student table to change the sname length from 14 to 40.Create trigger to insert data in emp_log table whenever any update of sal in EMP table. You can set action as ‘New Salary’.
  alter table student
  modify column Sname varchar(40);
  select * from student;
  

delimiter $$
CREATE TRIGGER update_salary
after UPDATE ON emp_log
FOR EACH ROW
BEGIN
  IF NEW.new_salary <> OLD.new_salary THEN
    INSERT INTO emp_log (emp_id, log_date, new_salary, action)
    VALUES (NEW.emp_id, NOW(), NEW.new_salary, 'new salary');
  END IF;
END$$

UPDATE emp_log SET new_salary = 20000 where emp_id =11 ;
  

 
 
  











