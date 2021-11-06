-- List the last name of employees supervised by the manager of 'Headquarters'
-- department. and the number of subordinates for each of these employees.

-- 'Headquarters' has a manager.
-- That manager's ssn can be associated with the superssn of other employees
-- List those employees' last names. With those employees, associate their
-- ssn with superssn of another employee table and group by the ones' that are equal
-- and get the count.

drop table if exists theSupervised;

drop table if exists subordCounts;

create table theSupervised
select lname, ssn -- last names and ssn of employees
from employee
where superssn in
  (	select mgrssn as superssn -- where their superior is the manager of the 'Headquarters' department
	from department 
	where dname = 'Headquarters');
	
create table subordCounts
select superssn, count(*) as Subordinates -- get the supervisors ssn and # of employee subordinates.
from employee
where superssn in
  (	select ssn -- those supervisors have other supervisors
	from employee
	where superssn in 
	  (	select mgrssn -- that is the manager of the 'Headquarters' department
		from department
		where dname = 'Headquarters'))
group by superssn;

select lname, Subordinates
from theSupervised, subordCounts
where theSupervised.ssn = subordCounts.superssn;
