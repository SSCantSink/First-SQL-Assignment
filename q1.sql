-- List the location(s) of the department where the employee with 'Michael' as a dependent, works for.

-- Michael is a dependent whose employee has a ssn.
-- This employee works for a department dno.
-- that department has location(s) dlocation.

select dlocation -- list location(s) of a department whose department number
from dept_locations
where dnumber in 
  (	select dno -- are the same as an employee's (employee is working for department)
	from employee
	where ssn in 
	  (	select essn -- that employee has a dependent whose name is 'Michael'
		from dependent
		where dependent_name = 'Michael'));
