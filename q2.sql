-- List the last name of the manager for the project 'Computerization' along
-- with the number of work assignments for this project.

-- project 'Computerization' has a pnumber and a dnum.
-- That dnum is associated with a mgrssn in department.
-- get that manager's last name from employee.
-- pnumber can be associated with pno from works_on
-- get the count of all people who worked on it. 

drop table if exists theManager;

drop table if exists theCount;

create table theManager
select lname -- last name of an employee
from employee
where ssn in
  ( select mgrssn -- who is a manager of a department
	from department
	where dnumber in
	  (	select dnum -- which managers the project named 'Computerization'
		from project
		where pname = 'Computerization'));

create table theCount
select pno, count(*) as the_count -- project number and the count of project assignments
from works_on
where pno in
 (	select pnumber as pno -- project is named 'Computerization'
	from project
	where pname = 'Computerization')
group by pno; -- the count of people who have working on the project

select lname, the_count as projects
from theManager, theCount;