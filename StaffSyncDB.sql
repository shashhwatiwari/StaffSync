CREATE DATABASE if not exists StaffSync;

USE StaffSync;

-- Organization Table
CREATE TABLE Organization (
    OrganizationID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Address VARCHAR(100) NOT NULL,
    RegistrationNumber VARCHAR(20) NOT NULL
);

-- Sample data for the Organization table
INSERT INTO Organization (Name, Address, RegistrationNumber) VALUES
('TechNova Solutions', '123 Innovation Drive, Silicon Valley, CA 94025', 'TN2024-001'),
('GreenLeaf Enterprises', '456 Eco Lane, Portland, OR 97201', 'GE2024-002'),
('GlobalLink Industries', '789 International Blvd, New York, NY 10001', 'GLI2024-003');


-- Department Table
CREATE TABLE Department (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50) NOT NULL
);

  -- Sample data for Department table
INSERT INTO Department (DepartmentID, DepartmentName)
VALUES
  (100 , 'Tech Support'),
  (201, 'Human Resources'),
  (311, 'Finance'),
  (47, 'Sales'),
  (16, 'Product Development');

-- JobTitle Table
CREATE TABLE JobTitle (
    JobTitleID INT AUTO_INCREMENT PRIMARY KEY,
    JobTitleName VARCHAR(50) NOT NULL
);

-- Sample data for JobTItle table
INSERT INTO JobTitle (JobTitleName)
VALUES
	("QA Engineer"),
    ('Software Engineer'),
	('Project Manager'),
	('Data Analyst'),
	('Human Resources Manager'),
	('Marketing Specialist'),
	('Financial Analyst');

    

-- PayGrade Table
CREATE TABLE PayGrade (
    PayGradeID INT AUTO_INCREMENT PRIMARY KEY,
    PayGradeName VARCHAR(50) NOT NULL,
    AnnualLeaveCount INT NOT NULL,
    CasualLeaveCount INT NOT NULL DEFAULT 10,
    MaternityLeaveCount INT NOT NULL,
    PayLeaveCount INT NOT NULL DEFAULT 20
);

INSERT INTO PayGrade (PayGradeName, AnnualLeaveCount, CasualLeaveCount, MaternityLeaveCount, PayLeaveCount) VALUES
('Entry Level', 	18, 7, 10, 4),
('Junior', 			18, 7, 10, 4),
('Mid-Level', 		20, 8, 14, 6),
('Senior', 			25, 10, 12, 5);



-- EmergencyContact Table
CREATE TABLE EmergencyContact (
    EmergencyContactID INT AUTO_INCREMENT PRIMARY KEY,
    PrimaryName VARCHAR(100),
    PrimaryPhoneNumber VARCHAR(20),
    SecondaryName VARCHAR(100),
    SecondaryPhoneNumber VARCHAR(20),
    Address VARCHAR(200)
);
    


-- Employee Table
CREATE TABLE Employee (
    EmployeeID INT AUTO_INCREMENT PRIMARY KEY,
    EmployeeName VARCHAR(100) NOT NULL,	
    DateOfBirth DATE,
    Gender ENUM('Male', 'Female','Other','Prefer Not to Say'),
    MaritalStatus ENUM('Married', 'Unmarried'),
    Address VARCHAR(200),
    Country VARCHAR(50),
    OrganizationID INT,
    DepartmentID INT,
    JobTitleID INT,
    PayGradeID INT,
    SupervisorID INT,
    FOREIGN KEY (OrganizationID) REFERENCES Organization(OrganizationID) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (JobTitleID) REFERENCES JobTitle(JobTitleID) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (PayGradeID) REFERENCES PayGrade(PayGradeID) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (SupervisorID) REFERENCES Employee(EmployeeID) ON UPDATE CASCADE ON DELETE CASCADE
);


-- Employee Emergency Contact table 
CREATE TABLE EmployeeEmergencyContact (
	EmergencyContactID INT,
    EmployeeID INT,
    PRIMARY KEY(EmergencyContactID, EmployeeID),
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (EmergencyContactID) REFERENCES EmergencyContact(EmergencyContactID) ON UPDATE CASCADE ON DELETE CASCADE
    );


-- DependentInfo Table
CREATE TABLE DependentInfo (
    DependentInfoID INT AUTO_INCREMENT PRIMARY KEY,
    EmployeeID INT NOT NULL,
    DependentName VARCHAR(100),
    DependentAge INT NOT NULL,
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
);


-- UserAccount Table
CREATE TABLE UserAccount (
    UserID INT AUTO_INCREMENT PRIMARY KEY,
    Username VARCHAR(50) UNIQUE NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    PasswordHash VARCHAR(255) NOT NULL,
    EmployeeID INT NOT NULL,
    User_Role ENUM("Admin","HR","Regular") NOT NULL,
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
);

-- Leave Table
CREATE TABLE Leave_tracker (
    LeaveID INT AUTO_INCREMENT PRIMARY KEY,
    LeaveLogDateTime DATETIME DEFAULT CURRENT_TIMESTAMP,
    EmployeeID INT NOT NULL,
    Approved BOOLEAN DEFAULT FALSE, 
    Reason VARCHAR(255),
    LeaveType ENUM('Annual', 'Casual', 'Maternity', 'No-Pay'),
    FirstAbsentDate DATE,
    LastAbsentDate DATE,
    LeaveDayCount INT,
    ApprovedDateTime DATETIME DEFAULT NULL,
    ApprovedByID INT DEFAULT NULL,
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID),
    FOREIGN KEY (ApprovedByID) REFERENCES Employee(EmployeeID)
);

-- AuditLog Table for tracking actions like deletions
CREATE TABLE AuditLog (
  LogID INT AUTO_INCREMENT PRIMARY KEY,
  Action VARCHAR(50),
  TableName VARCHAR(50),
  RecordID VARCHAR(20),
  Timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);



-- Triggers introduced here, they are listed as follows along with their purposes.


-- Checking for existing email when creating a user account
DELIMITER //
CREATE TRIGGER before_useraccount_insert_check_email
BEFORE INSERT ON UserAccount
FOR EACH ROW
BEGIN
    -- Check if the email already exists
    IF EXISTS (SELECT 1 FROM UserAccount WHERE Email = NEW.Email) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Duplicate email detected!';
    END IF;
END;
//
DELIMITER //



-- deleting dependent records when deleting an employees records from the database.
DELIMITER $$
CREATE TRIGGER before_employee_delete
BEFORE DELETE ON Employee
FOR EACH ROW
BEGIN
    -- Delete related records in the DependentInfo table
    DELETE FROM DependentInfo WHERE EmployeeID = OLD.EmployeeID;
    
    -- Delete related records in the UserAccount table
    DELETE FROM UserAccount WHERE EmployeeID = OLD.EmployeeID;
    
    -- Set NULL to supervisor references in Employee table
    UPDATE Employee SET SupervisorID = NULL WHERE SupervisorID = OLD.EmployeeID;
    
    -- Delete related records in the Leave table
    DELETE FROM Leave_tracker WHERE EmployeeID = OLD.EmployeeID OR ApprovedByID = OLD.EmployeeID;
END;
$$
DELIMITER ;



-- trigger to check the leave count for the employee before inserting a new leave
DELIMITER //
CREATE TRIGGER before_leave_insert
BEFORE INSERT ON Leave_tracker
FOR EACH ROW
BEGIN
    DECLARE available_leave_count INT;
    DECLARE paygrade_id INT;

    -- Get the PayGradeID for the employee
    SELECT PayGradeID INTO paygrade_id FROM Employee WHERE EmployeeID = NEW.EmployeeID;

    -- Check available leave count based on the leave type
    CASE NEW.LeaveType
        WHEN 'Annual' THEN
            SELECT AnnualLeaveCount INTO available_leave_count FROM PayGrade WHERE PayGradeID = paygrade_id;
        WHEN 'Casual' THEN
            SELECT CasualLeaveCount INTO available_leave_count FROM PayGrade WHERE PayGradeID = paygrade_id;
        WHEN 'Maternity' THEN
            SELECT MaternityLeaveCount INTO available_leave_count FROM PayGrade WHERE PayGradeID = paygrade_id;
        WHEN 'No-Pay' THEN
            SELECT PayLeaveCount INTO available_leave_count FROM PayGrade WHERE PayGradeID = paygrade_id;
    END CASE;

    -- If applied leave count is more than available leave count, throw an error
    IF NEW.LeaveDayCount > available_leave_count THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Not enough leaves available';
    END IF;
END;
//
DELIMITER ;


-- before inserting a dependent
DELIMITER //
CREATE TRIGGER check_dependent_limit
BEFORE INSERT ON DependentInfo
FOR EACH ROW
BEGIN
    DECLARE dependent_count INT;

    -- Count the current number of dependents for the employee
    SELECT COUNT(*) INTO dependent_count 
    FROM DependentInfo 
    WHERE EmployeeID = NEW.EmployeeID;

    -- If the count is 4 or more, raise an error
    IF dependent_count >= 4 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'An employee cannot have more than 4 dependents';
    END IF;
END;
//
DELIMITER ;



-- trigger for instances where we might delete a department and set every associated employee to a temporary holding department
DELIMITER //
CREATE TRIGGER after_department_delete
AFTER DELETE ON Department
FOR EACH ROW
BEGIN
    -- Automatically reassign employees to a new department after a department is deleted
    UPDATE Employee
    SET DepartmentID = 404 -- holding department
    WHERE DepartmentID = OLD.DepartmentID;
END;
//
DELIMITER ;



-- trigger for instances where we might delete a job title and set every associated employee to a temporary  job title
DELIMITER //
CREATE TRIGGER after_job_title_delete
AFTER DELETE ON JobTitle
FOR EACH ROW
BEGIN
    -- Automatically reassign employees to a new job title after a job title is deleted
    UPDATE Employee
    SET JobTitleID = 8  -- temporary job title
    WHERE JobTitleID = OLD.JobTitleID;
END;
//
DELIMITER ;













-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Procedures


-- procedure to add employees.
DELIMITER //
CREATE PROCEDURE insert_employee(
    IN p_EmployeeName VARCHAR(100),
    IN p_DateOfBirth DATE,
    IN p_Gender ENUM('Male', 'Female', 'Other', 'Prefer Not to Say'),
    IN p_MaritalStatus ENUM('Married', 'Unmarried'),
    IN p_Address VARCHAR(200),
    IN p_Country VARCHAR(50),
    IN p_OrganizationID INT,
    IN p_DepartmentID INT,
    IN p_JobTitleID INT,
    IN p_PayGradeID INT,
    IN p_SupervisorID INT,
    OUT p_EmployeeID INT
)
BEGIN
    INSERT INTO Employee (
        EmployeeName, DateOfBirth, Gender, MaritalStatus, Address, Country,
        OrganizationID, DepartmentID, JobTitleID, PayGradeID, SupervisorID
    ) VALUES (
        p_EmployeeName, p_DateOfBirth, p_Gender, p_MaritalStatus, p_Address, p_Country,
        p_OrganizationID, p_DepartmentID, p_JobTitleID, p_PayGradeID, p_SupervisorID
    );
    
    SET p_EmployeeID = LAST_INSERT_ID();
END;
//
DELIMITER ;


-- test
CALL insert_employee(
    "Abhinav Mishra", 
    '1998-07-22', 
    'Male', 
    'Unmarried', 
    '700 ABC Apartments County Rd', 
    'United States of America', 
    1,  -- Assuming 1 is the OrganizationID for TechNova Solutions
    16,  -- DepartmentID
    1,  -- JobTitleID
    1,  -- PayGradeID
    NULL,  -- SupervisorID
    @new_employee_id  -- This will store the new employee's ID
);



-- procedure to update an employees details 
DELIMITER //
CREATE PROCEDURE update_employee(
    IN p_EmployeeID INT,
    IN p_EmployeeName VARCHAR(100),
    IN p_DateOfBirth DATE,
    IN p_Gender ENUM('Male', 'Female', 'Other', 'Prefer Not to Say'),
    IN p_MaritalStatus ENUM('Married', 'Unmarried'),
    IN p_Address VARCHAR(200),
    IN p_Country VARCHAR(50),
    IN p_OrganizationID INT,
    IN p_DepartmentID INT,
    IN p_JobTitleID INT,
    IN p_PayGradeID INT,
    IN p_SupervisorID INT
)
BEGIN
    UPDATE Employee
    SET
        EmployeeName = p_EmployeeName,
        DateOfBirth = p_DateOfBirth,
        Gender = p_Gender,
        MaritalStatus = p_MaritalStatus,
        Address = p_Address,
        Country = p_Country,
        OrganizationID = p_OrganizationID,
        DepartmentID = p_DepartmentID,
        JobTitleID = p_JobTitleID,
        PayGradeID = p_PayGradeID,
        SupervisorID = p_SupervisorID
    WHERE EmployeeID = p_EmployeeID;
END;
//
DELIMITER ;


-- procedure to get employee details
DELIMITER //
CREATE PROCEDURE get_employee_details(IN p_EmployeeID INT)
BEGIN
    SELECT e.*, d.DepartmentName, j.JobTitleName, p.PayGradeName, o.Name AS OrganizationName
    FROM Employee e
    LEFT JOIN Department d ON e.DepartmentID = d.DepartmentID
    LEFT JOIN JobTitle j ON e.JobTitleID = j.JobTitleID
    LEFT JOIN PayGrade p ON e.PayGradeID = p.PayGradeID
    LEFT JOIN Organization o ON e.OrganizationID = o.OrganizationID
    WHERE e.EmployeeID = p_EmployeeID;
END;
//
DELIMITER ;


-- inserting a new department
DELIMITER //
CREATE PROCEDURE insert_department (
    IN p_DepartmentID INT,
    IN p_DepartmentName VARCHAR(50)
)
BEGIN
    INSERT INTO Department (DepartmentID, DepartmentName)
    VALUES (p_DepartmentID, p_DepartmentName);
END;
//
DELIMITER ;

call insert_department(404,"Holding");


-- updating department name 
DELIMITER //
CREATE PROCEDURE update_department_name (
    IN p_DepartmentID INT,
    IN p_NewDepartmentName VARCHAR(50)
)
BEGIN
    UPDATE Department
    SET DepartmentName = p_NewDepartmentName
    WHERE DepartmentID = p_DepartmentID;
END;
//
DELIMITER ;


-- deleting an existing department and reassigning all concerned employees to a new departmennt 
DELIMITER //
CREATE PROCEDURE delete_department_reassign (
    IN p_DepartmentID INT,
    IN p_NewDepartmentID INT
)
BEGIN
    -- Reassign employees to a new department
    UPDATE Employee
    SET DepartmentID = p_NewDepartmentID
    WHERE DepartmentID = p_DepartmentID;

    -- Delete the department
    DELETE FROM Department WHERE DepartmentID = p_DepartmentID;
END;
//
DELIMITER ;


-- inserting a new job title
DELIMITER //
CREATE PROCEDURE insert_job_title (
    IN p_JobTitleName VARCHAR(50)
)
BEGIN
    INSERT INTO JobTitle (JobTitleName)
    VALUES (p_JobTitleName);
END;
//
DELIMITER ;

call insert_job_title(8,"Temporary");


-- updating job titles
DELIMITER //
CREATE PROCEDURE update_job_title_name (
    IN p_JobTitleID INT,
    IN p_NewJobTitleName VARCHAR(50)
)
BEGIN
    UPDATE JobTitle
    SET JobTitleName = p_NewJobTitleName
    WHERE JobTitleID = p_JobTitleID;
END;
//
DELIMITER ;


-- deleting a new job title and reassigning the employees associated to another 
DELIMITER //
CREATE PROCEDURE delete_job_title_reassign (
    IN p_JobTitleID INT,
    IN p_NewJobTitleID INT
)
BEGIN
    -- Reassign employees to a new job title
    UPDATE Employee
    SET JobTitleID = p_NewJobTitleID
    WHERE JobTitleID = p_JobTitleID;

    -- Delete the job title
    DELETE FROM JobTitle WHERE JobTitleID = p_JobTitleID;
END;
//
DELIMITER ;


-- adding emergency contacts for an employee. (upper bound of 3 contacts per employee)
DELIMITER //
CREATE PROCEDURE insert_emergency_contact (
    IN p_EmployeeID INT,
    IN p_PrimaryName VARCHAR(100),
    IN p_PrimaryPhoneNumber VARCHAR(20),
    IN p_SecondaryName VARCHAR(100),
    IN p_SecondaryPhoneNumber VARCHAR(20),
    IN p_Address VARCHAR(200),
    OUT p_EmergencyContactID INT
)
BEGIN
    -- Check if the employee already has 3 emergency contacts
    DECLARE contact_count INT;
    
    SELECT COUNT(*) INTO contact_count
    FROM EmployeeEmergencyContact
    WHERE EmployeeID = p_EmployeeID;
    
    -- If the count is less than 3, proceed with the insertion
    IF contact_count < 3 THEN
        -- Insert the new emergency contact
        INSERT INTO EmergencyContact (PrimaryName, PrimaryPhoneNumber, SecondaryName, SecondaryPhoneNumber, Address)
        VALUES (p_PrimaryName, p_PrimaryPhoneNumber, p_SecondaryName, p_SecondaryPhoneNumber, p_Address);
        
        SET p_EmergencyContactID = LAST_INSERT_ID();
        
        -- Link the emergency contact with the employee
        INSERT INTO EmployeeEmergencyContact (EmployeeID, EmergencyContactID)
        VALUES (p_EmployeeID, p_EmergencyContactID);
    ELSE
        -- If the count is 3 or more, raise an error
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Employee already has 3 emergency contacts.';
    END IF;
END;
//
DELIMITER ;



-- updating emergency contact
DELIMITER //
CREATE PROCEDURE update_emergency_contact (
    IN p_EmergencyContactID INT,
    IN p_PrimaryName VARCHAR(100),
    IN p_PrimaryPhoneNumber VARCHAR(20),
    IN p_SecondaryName VARCHAR(100),
    IN p_SecondaryPhoneNumber VARCHAR(20),
    IN p_Address VARCHAR(200)
)
BEGIN
    UPDATE EmergencyContact
    SET PrimaryName = p_PrimaryName,
        PrimaryPhoneNumber = p_PrimaryPhoneNumber,
        SecondaryName = p_SecondaryName,
        SecondaryPhoneNumber = p_SecondaryPhoneNumber,
        Address = p_Address
    WHERE EmergencyContactID = p_EmergencyContactID;
END;
//
DELIMITER ;


-- deleting emergency contact
DELIMITER //
CREATE PROCEDURE delete_emergency_contact (
    IN p_EmergencyContactID INT
)
BEGIN
    DELETE FROM EmergencyContact WHERE EmergencyContactID = p_EmergencyContactID;
END;
//
DELIMITER ;


-- inserting dependents of employees, (giving a maximum limit of 4 dependents per employee)
DELIMITER //
CREATE PROCEDURE insert_dependent (
    IN p_EmployeeID INT,
    IN p_DependentName VARCHAR(100),
    IN p_DependentAge INT,
    OUT p_DependentInfoID INT
)
BEGIN
    -- Check if the employee already has 4 dependents
    DECLARE dependent_count INT;

    SELECT COUNT(*) INTO dependent_count
    FROM DependentInfo
    WHERE EmployeeID = p_EmployeeID;

    -- If the count is less than 4, proceed with the insertion
    IF dependent_count < 4 THEN
        -- Insert the new dependent
        INSERT INTO DependentInfo (EmployeeID, DependentName, DependentAge)
        VALUES (p_EmployeeID, p_DependentName, p_DependentAge);

        SET p_DependentInfoID = LAST_INSERT_ID();
    ELSE
        -- If the count is 4 or more, raise an error
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Employee already has 4 dependents.';
    END IF;
END;
//
DELIMITER ;

-- updating dependent information
DELIMITER //
CREATE PROCEDURE update_dependent (
    IN p_DependentInfoID INT,
    IN p_DependentName VARCHAR(100),
    IN p_DependentAge INT
)
BEGIN
    UPDATE DependentInfo
    SET DependentName = p_DependentName,
        DependentAge = p_DependentAge
    WHERE DependentInfoID = p_DependentInfoID;
END;
//
DELIMITER ;


-- deleting a dependent
DELIMITER //
CREATE PROCEDURE delete_dependent (
    IN p_DependentInfoID INT
)
BEGIN
    DELETE FROM DependentInfo WHERE DependentInfoID = p_DependentInfoID;
END;
//
DELIMITER ;


-- viewing an employee's emergency contacts
DELIMITER //
CREATE PROCEDURE get_employee_emergency_contacts (
    IN p_EmployeeID INT
)
BEGIN
    SELECT ec.*
    FROM EmployeeEmergencyContact eec
    JOIN EmergencyContact ec ON eec.EmergencyContactID = ec.EmergencyContactID
    WHERE eec.EmployeeID = p_EmployeeID;
END;
//
DELIMITER ;


-- vieweing employee's dependent information
DELIMITER //
CREATE PROCEDURE get_employee_dependents (
    IN p_EmployeeID INT
)
BEGIN
    SELECT DependentName, DependentAge
    FROM DependentInfo
    WHERE EmployeeID = p_EmployeeID;
END;
//
DELIMITER ;