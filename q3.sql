-- List the name of project(s) managed by the 'Research' department with
-- total number of work hours assigned to each of these projects.

-- 'Research' department has its dnumber.
-- that dnumber is associated with pnumbers for projects in project table.
-- project names are also in the table.
-- Use the pnumbers to list the total hours from works_on table.

drop table if exists totalHours;

drop table if exists projectNames;

create table totalHours
select pno, sum(hours) as hoursSum -- get the sum of hours and pno from the project assignments.
from works_on
where pno in 
  (	select pnumber as pno -- the pno is managed by a department
	from project
	where dnum in
	  (	select dnumber as dnum -- that has the name 'Research'
		from department
		where dname = 'Research'))
group by pno; -- sum the hours up based on which project it is.

create table projectNames
select pname, pnumber as pno -- get the name of the project and the pnumber
from project
where dnum in
  (	select dnumber as dnum -- for the projects whose department managing it is 'Research'
	from department
	where dname = 'Research');
	
select pname, hoursSum as TotalHours -- just the combine the two tables seeing if the pnumbers are the same.
from projectNames, totalHours
where projectNames.pno = totalHours.pno;