USE default_db;

CREATE TRIGGER set_hire_date
BEFORE INSERT ON employeesset_hire_date
FOR EACH ROW
SET NEW.hire_date = IFNULL(NEW.hire_date, CURDATE());
