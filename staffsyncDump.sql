CREATE DATABASE  IF NOT EXISTS `staffsync` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `staffsync`;
-- MySQL dump 10.13  Distrib 8.0.38, for macos14 (x86_64)
--
-- Host: localhost    Database: staffsync
-- ------------------------------------------------------
-- Server version	8.0.39

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `AuditLog`
--

DROP TABLE IF EXISTS `AuditLog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `AuditLog` (
  `LogID` int NOT NULL AUTO_INCREMENT,
  `Action` varchar(50) DEFAULT NULL,
  `TableName` varchar(50) DEFAULT NULL,
  `RecordID` varchar(20) DEFAULT NULL,
  `Timestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`LogID`)
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `AuditLog`
--

LOCK TABLES `AuditLog` WRITE;
/*!40000 ALTER TABLE `AuditLog` DISABLE KEYS */;
INSERT INTO `AuditLog` VALUES (1,'INSERT','Organization','1','2024-12-04 06:03:17'),(2,'INSERT','Organization','2','2024-12-04 06:03:17'),(3,'INSERT','Organization','3','2024-12-04 06:03:17'),(4,'INSERT','Organization','4','2024-12-04 06:03:17'),(5,'INSERT','Department','1','2024-12-04 06:05:03'),(6,'INSERT','Department','2','2024-12-04 06:05:03'),(7,'INSERT','Department','3','2024-12-04 06:05:03'),(8,'INSERT','Department','4','2024-12-04 06:05:03'),(9,'INSERT','Department','5','2024-12-04 06:05:03'),(10,'INSERT','Department','6','2024-12-04 06:05:03'),(11,'INSERT','Department','7','2024-12-04 06:05:03'),(12,'INSERT','Department','8','2024-12-04 06:05:03'),(13,'INSERT','Department','9','2024-12-04 06:05:03'),(14,'INSERT','Department','10','2024-12-04 06:05:03'),(15,'INSERT','JobTitle','1','2024-12-04 06:06:30'),(16,'INSERT','JobTitle','2','2024-12-04 06:06:30'),(17,'INSERT','JobTitle','3','2024-12-04 06:06:30'),(18,'INSERT','JobTitle','4','2024-12-04 06:06:30'),(19,'INSERT','JobTitle','5','2024-12-04 06:06:30'),(20,'INSERT','JobTitle','6','2024-12-04 06:06:30'),(21,'INSERT','JobTitle','7','2024-12-04 06:06:30'),(22,'INSERT','JobTitle','8','2024-12-04 06:06:30'),(23,'INSERT','JobTitle','9','2024-12-04 06:06:30'),(24,'INSERT','JobTitle','10','2024-12-04 06:06:30'),(25,'INSERT','JobTitle','11','2024-12-04 06:06:30'),(26,'INSERT','JobTitle','12','2024-12-04 06:06:30'),(27,'INSERT','JobTitle','13','2024-12-04 06:06:30'),(28,'INSERT','JobTitle','14','2024-12-04 06:06:30'),(29,'INSERT','JobTitle','15','2024-12-04 06:06:30'),(30,'INSERT','JobTitle','16','2024-12-04 06:06:30'),(31,'INSERT','PayGrade','1','2024-12-04 06:07:09'),(32,'INSERT','PayGrade','2','2024-12-04 06:07:09'),(33,'INSERT','PayGrade','3','2024-12-04 06:07:09'),(34,'INSERT','PayGrade','4','2024-12-04 06:07:09'),(35,'INSERT','PayGrade','5','2024-12-04 06:07:09'),(36,'INSERT','PayGrade','6','2024-12-04 06:07:09'),(37,'INSERT','PayGrade','7','2024-12-04 06:07:09'),(38,'INSERT','PayGrade','8','2024-12-04 06:07:09'),(39,'INSERT','PayGrade','9','2024-12-04 06:07:09'),(40,'INSERT','PayGrade','10','2024-12-04 06:07:09'),(41,'INSERT','Employee','1','2024-12-04 06:09:42'),(42,'INSERT','Employee','2','2024-12-04 06:09:42'),(43,'INSERT','Employee','3','2024-12-04 06:09:42'),(44,'INSERT','Employee','4','2024-12-04 06:09:42'),(45,'INSERT','Employee','5','2024-12-04 06:09:42'),(46,'INSERT','Employee','6','2024-12-04 06:18:17'),(47,'UPDATE','Organization','1','2024-12-04 06:25:15'),(48,'UPDATE','Organization','2','2024-12-04 06:25:15'),(49,'UPDATE','Organization','3','2024-12-04 06:25:15'),(50,'UPDATE','Organization','4','2024-12-04 06:25:15'),(51,'INSERT','Employee','7','2024-12-04 06:33:23'),(52,'INSERT','UserAccount','1','2024-12-04 06:34:08'),(53,'INSERT','UserAccount','2','2024-12-04 06:37:13'),(54,'INSERT','Employee','8','2024-12-04 06:53:13'),(55,'UPDATE','Employee','5','2024-12-04 07:11:11'),(56,'UPDATE','Employee','5','2024-12-04 07:11:15'),(57,'INSERT','UserAccount','3','2024-12-04 07:27:09'),(58,'UPDATE','Employee','1','2024-12-05 05:34:03');
/*!40000 ALTER TABLE `AuditLog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Department`
--

DROP TABLE IF EXISTS `Department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Department` (
  `DepartmentID` int NOT NULL,
  `DepartmentName` varchar(50) NOT NULL,
  PRIMARY KEY (`DepartmentID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Department`
--

LOCK TABLES `Department` WRITE;
/*!40000 ALTER TABLE `Department` DISABLE KEYS */;
INSERT INTO `Department` VALUES (1,'Human Resources'),(2,'Research and Development'),(3,'Sales and Marketing'),(4,'Finance'),(5,'Information Technology'),(6,'Customer Support'),(7,'Operations'),(8,'Procurement'),(9,'Legal Affairs'),(10,'Public Relations');
/*!40000 ALTER TABLE `Department` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `department_insert_audit` AFTER INSERT ON `department` FOR EACH ROW BEGIN
    INSERT INTO AuditLog (Action, TableName, RecordID)
    VALUES ('INSERT', 'Department', CAST(NEW.DepartmentID AS CHAR));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `department_update_audit` AFTER UPDATE ON `department` FOR EACH ROW BEGIN
    INSERT INTO AuditLog (Action, TableName, RecordID)
    VALUES ('UPDATE', 'Department', CAST(NEW.DepartmentID AS CHAR));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `DependentInfo`
--

DROP TABLE IF EXISTS `DependentInfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `DependentInfo` (
  `DependentInfoID` int NOT NULL AUTO_INCREMENT,
  `EmployeeID` int NOT NULL,
  `DependentName` varchar(100) DEFAULT NULL,
  `DependentAge` int NOT NULL,
  PRIMARY KEY (`DependentInfoID`),
  KEY `EmployeeID` (`EmployeeID`),
  CONSTRAINT `dependentinfo_ibfk_1` FOREIGN KEY (`EmployeeID`) REFERENCES `Employee` (`EmployeeID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `DependentInfo`
--

LOCK TABLES `DependentInfo` WRITE;
/*!40000 ALTER TABLE `DependentInfo` DISABLE KEYS */;
INSERT INTO `DependentInfo` VALUES (1,1,'Emily Doe',5),(2,2,'Charlie Smith',8),(3,3,'Sofia Martinez',3),(4,4,'Ethan Green',6),(5,5,'Olivia Brown',4);
/*!40000 ALTER TABLE `DependentInfo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `EmergencyContact`
--

DROP TABLE IF EXISTS `EmergencyContact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `EmergencyContact` (
  `EmergencyContactID` int NOT NULL AUTO_INCREMENT,
  `EmployeeID` int NOT NULL,
  `ContactName` varchar(100) DEFAULT NULL,
  `PhoneNumber` varchar(20) DEFAULT NULL,
  `Address` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`EmergencyContactID`),
  KEY `EmployeeID` (`EmployeeID`),
  CONSTRAINT `emergencycontact_ibfk_1` FOREIGN KEY (`EmployeeID`) REFERENCES `Employee` (`EmployeeID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `EmergencyContact`
--

LOCK TABLES `EmergencyContact` WRITE;
/*!40000 ALTER TABLE `EmergencyContact` DISABLE KEYS */;
INSERT INTO `EmergencyContact` VALUES (1,1,'Jane Doe','555-1234','123 Main St, Springfield, IL'),(2,2,'Bob Smith','555-5678','456 Oak Ave, Boston, MA'),(3,3,'Maria Martinez','555-9876','789 Pine Rd, Austin, TX'),(4,4,'Tom Green','555-4321','101 Maple Ln, Denver, CO'),(5,5,'Laura Brown','555-8765','202 Birch St, Miami, FL');
/*!40000 ALTER TABLE `EmergencyContact` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Employee`
--

DROP TABLE IF EXISTS `Employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Employee` (
  `EmployeeID` int NOT NULL AUTO_INCREMENT,
  `EmployeeName` varchar(100) NOT NULL,
  `DateOfBirth` date DEFAULT NULL,
  `Gender` enum('Male','Female','Other','Prefer Not to Say') DEFAULT NULL,
  `MaritalStatus` enum('Married','Unmarried') DEFAULT NULL,
  `Address` varchar(200) DEFAULT NULL,
  `Country` varchar(50) DEFAULT NULL,
  `OrganizationID` int DEFAULT NULL,
  `DepartmentID` int DEFAULT NULL,
  `JobTitleID` int DEFAULT NULL,
  `PayGradeID` int DEFAULT NULL,
  `SupervisorID` int DEFAULT NULL,
  `NumberOfLeaves` int DEFAULT '20',
  PRIMARY KEY (`EmployeeID`),
  KEY `OrganizationID` (`OrganizationID`),
  KEY `DepartmentID` (`DepartmentID`),
  KEY `JobTitleID` (`JobTitleID`),
  KEY `PayGradeID` (`PayGradeID`),
  KEY `SupervisorID` (`SupervisorID`),
  CONSTRAINT `employee_ibfk_1` FOREIGN KEY (`OrganizationID`) REFERENCES `Organization` (`OrganizationID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `employee_ibfk_2` FOREIGN KEY (`DepartmentID`) REFERENCES `Department` (`DepartmentID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `employee_ibfk_3` FOREIGN KEY (`JobTitleID`) REFERENCES `JobTitle` (`JobTitleID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `employee_ibfk_4` FOREIGN KEY (`PayGradeID`) REFERENCES `PayGrade` (`PayGradeID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `employee_ibfk_5` FOREIGN KEY (`SupervisorID`) REFERENCES `Employee` (`EmployeeID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Employee`
--

LOCK TABLES `Employee` WRITE;
/*!40000 ALTER TABLE `Employee` DISABLE KEYS */;
INSERT INTO `Employee` VALUES (1,'John Doe','1990-03-25','Male','Married','123 Main St, Springfield, IL','USA',1,2,1,5,NULL,20),(2,'Alice Smith','1985-07-12','Female','Unmarried','456 Oak Ave, Boston, MA','USA',2,4,7,6,1,20),(3,'Carlos Martinez','1992-01-15','Male','Unmarried','789 Pine Rd, Austin, TX','USA',3,6,5,4,2,20),(4,'Rachel Green','1988-11-20','Female','Married','101 Maple Ln, Denver, CO','USA',4,9,2,8,3,20),(5,'Michael Brown','1995-09-05','Male','Unmarried','202 Birch St, Miami, FL','USA',1,1,1,1,NULL,20),(6,'Sarah Johnson','1983-04-10','Female','Married','123 HR St, Chicago, IL','USA',1,1,1,3,NULL,20),(7,'David Williams','1990-05-22','Male','Unmarried','500 Tech Lane, Silicon Valley, CA','USA',1,5,6,4,NULL,20),(8,'John Abraham','1985-08-15','Male','Married','123 Tech Avenue, Springfield, IL','USA',1,5,15,5,1,20);
/*!40000 ALTER TABLE `Employee` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `employee_insert_audit` AFTER INSERT ON `employee` FOR EACH ROW BEGIN
    INSERT INTO AuditLog (Action, TableName, RecordID)
    VALUES ('INSERT', 'Employee', CAST(NEW.EmployeeID AS CHAR));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `employee_update_audit` AFTER UPDATE ON `employee` FOR EACH ROW BEGIN
    INSERT INTO AuditLog (Action, TableName, RecordID)
    VALUES ('UPDATE', 'Employee', CAST(NEW.EmployeeID AS CHAR));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `update_user_role_after_employee_update` AFTER UPDATE ON `employee` FOR EACH ROW BEGIN
    DECLARE new_job_title_name VARCHAR(50);

    -- Check if JobTitleID has changed
    IF NEW.JobTitleID != OLD.JobTitleID THEN
        -- Get the new JobTitleName
        SELECT JobTitleName INTO new_job_title_name
        FROM JobTitle
        WHERE JobTitleID = NEW.JobTitleID;

        -- Update the UserAccount's user_role based on the new JobTitleName
        IF new_job_title_name IN ('HR', 'Human Resources','Human Resources Manager') THEN
            UPDATE UserAccount
            SET User_Role = 'HR'
            WHERE EmployeeID = NEW.EmployeeID;
        ELSE
            UPDATE UserAccount
            SET User_Role = 'Regular'
            WHERE EmployeeID = NEW.EmployeeID;
        END IF;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `JobTitle`
--

DROP TABLE IF EXISTS `JobTitle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `JobTitle` (
  `JobTitleID` int NOT NULL AUTO_INCREMENT,
  `JobTitleName` varchar(50) NOT NULL,
  PRIMARY KEY (`JobTitleID`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `JobTitle`
--

LOCK TABLES `JobTitle` WRITE;
/*!40000 ALTER TABLE `JobTitle` DISABLE KEYS */;
INSERT INTO `JobTitle` VALUES (1,'HR Manager'),(2,'Recruitment Specialist'),(3,'Training and Development Coordinator'),(4,'R&D Scientist'),(5,'Product Development Manager'),(6,'Innovation Specialist'),(7,'Sales Manager'),(8,'Marketing Strategist'),(9,'Digital Marketing Specialist'),(10,'Financial Analyst'),(11,'Accountant'),(12,'Treasury Manager'),(13,'IT Support Specialist'),(14,'System Administrator'),(15,'Customer Service Representative'),(16,'Customer Support Manager');
/*!40000 ALTER TABLE `JobTitle` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `jobtitle_insert_audit` AFTER INSERT ON `jobtitle` FOR EACH ROW BEGIN
    INSERT INTO AuditLog (Action, TableName, RecordID)
    VALUES ('INSERT', 'JobTitle', CAST(NEW.JobTitleID AS CHAR));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `jobtitle_update_audit` AFTER UPDATE ON `jobtitle` FOR EACH ROW BEGIN
    INSERT INTO AuditLog (Action, TableName, RecordID)
    VALUES ('UPDATE', 'JobTitle', CAST(NEW.JobTitleID AS CHAR));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `Leave_tracker`
--

DROP TABLE IF EXISTS `Leave_tracker`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Leave_tracker` (
  `LeaveID` int NOT NULL AUTO_INCREMENT,
  `LeaveLogDateTime` datetime DEFAULT CURRENT_TIMESTAMP,
  `EmployeeID` int NOT NULL,
  `Reason` varchar(255) DEFAULT NULL,
  `LeaveType` enum('Annual','Casual','Maternity','No-Pay') DEFAULT NULL,
  `FirstAbsentDate` date DEFAULT NULL,
  `LastAbsentDate` date DEFAULT NULL,
  `ApprovedByID` int DEFAULT NULL,
  `LeaveDayCount` int DEFAULT NULL,
  PRIMARY KEY (`LeaveID`),
  KEY `EmployeeID` (`EmployeeID`),
  KEY `ApprovedByID` (`ApprovedByID`),
  CONSTRAINT `leave_tracker_ibfk_1` FOREIGN KEY (`EmployeeID`) REFERENCES `Employee` (`EmployeeID`),
  CONSTRAINT `leave_tracker_ibfk_2` FOREIGN KEY (`ApprovedByID`) REFERENCES `Employee` (`EmployeeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Leave_tracker`
--

LOCK TABLES `Leave_tracker` WRITE;
/*!40000 ALTER TABLE `Leave_tracker` DISABLE KEYS */;
/*!40000 ALTER TABLE `Leave_tracker` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Organization`
--

DROP TABLE IF EXISTS `Organization`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Organization` (
  `OrganizationID` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(50) NOT NULL,
  `Address` varchar(100) NOT NULL,
  `RegistrationNumber` varchar(20) NOT NULL,
  PRIMARY KEY (`OrganizationID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Organization`
--

LOCK TABLES `Organization` WRITE;
/*!40000 ALTER TABLE `Organization` DISABLE KEYS */;
INSERT INTO `Organization` VALUES (1,'GreenTech Solutions','123 Elm Street, Springfield, IL','REG-452839'),(2,'GreenTech Solutions','456 Oak Avenue, Boston, MA','REG-763092'),(3,'GreenTech Solutions','789 Pine Road, Austin, TX','REG-204561'),(4,'GreenTech Solutions','321 Maple Lane, Denver, CO','REG-982745');
/*!40000 ALTER TABLE `Organization` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `organization_insert_audit` AFTER INSERT ON `organization` FOR EACH ROW BEGIN
    INSERT INTO AuditLog (Action, TableName, RecordID)
    VALUES ('INSERT', 'Organization', CAST(NEW.OrganizationID AS CHAR));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `organization_update_audit` AFTER UPDATE ON `organization` FOR EACH ROW BEGIN
    INSERT INTO AuditLog (Action, TableName, RecordID)
    VALUES ('UPDATE', 'Organization', CAST(NEW.OrganizationID AS CHAR));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `PayGrade`
--

DROP TABLE IF EXISTS `PayGrade`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PayGrade` (
  `PayGradeID` int NOT NULL AUTO_INCREMENT,
  `PayGradeName` varchar(50) NOT NULL,
  `SalaryAmount` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`PayGradeID`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PayGrade`
--

LOCK TABLES `PayGrade` WRITE;
/*!40000 ALTER TABLE `PayGrade` DISABLE KEYS */;
INSERT INTO `PayGrade` VALUES (1,'Junior',35000.00),(2,'Mid-Level',50000.00),(3,'Senior',75000.00),(4,'Lead',95000.00),(5,'Manager',120000.00),(6,'Director',150000.00),(7,'Vice President',200000.00),(8,'Senior Vice President',250000.00),(9,'Executive',300000.00),(10,'Chief Officer',450000.00);
/*!40000 ALTER TABLE `PayGrade` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `paygrade_insert_audit` AFTER INSERT ON `paygrade` FOR EACH ROW BEGIN
    INSERT INTO AuditLog (Action, TableName, RecordID)
    VALUES ('INSERT', 'PayGrade', CAST(NEW.PayGradeID AS CHAR));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `paygrade_update_audit` AFTER UPDATE ON `paygrade` FOR EACH ROW BEGIN
    INSERT INTO AuditLog (Action, TableName, RecordID)
    VALUES ('UPDATE', 'PayGrade', CAST(NEW.PayGradeID AS CHAR));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `UserAccount`
--

DROP TABLE IF EXISTS `UserAccount`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `UserAccount` (
  `UserID` int NOT NULL AUTO_INCREMENT,
  `Username` varchar(50) NOT NULL,
  `Email` varchar(100) NOT NULL,
  `PasswordHash` varchar(255) NOT NULL,
  `EmployeeID` int NOT NULL,
  `User_Role` enum('Admin','HR','Regular') NOT NULL,
  PRIMARY KEY (`UserID`),
  UNIQUE KEY `Username` (`Username`),
  UNIQUE KEY `Email` (`Email`),
  KEY `EmployeeID` (`EmployeeID`),
  CONSTRAINT `useraccount_ibfk_1` FOREIGN KEY (`EmployeeID`) REFERENCES `Employee` (`EmployeeID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `UserAccount`
--

LOCK TABLES `UserAccount` WRITE;
/*!40000 ALTER TABLE `UserAccount` DISABLE KEYS */;
INSERT INTO `UserAccount` VALUES (1,'admin','admin@gtechsol.com','admin',7,'Admin'),(2,'sarahJ','saraj@gtechsol.com','pbkdf2_sha256$870000$hpbJDPdWtB6ib72EcibEE1$Gcuii4bPv4XhZfIlcbguf2N7Ma8oG3DzgbTswZIeJL4=',6,'HR'),(3,'carlosM','carlosm@gtechsol.com','pbkdf2_sha256$870000$HTVhU629VHBPOkxNgs2Zxx$ByWpr7it7KiEO2XSMcEjYobOSpTx2yvQTdGGsIcl4k8=',3,'Regular');
/*!40000 ALTER TABLE `UserAccount` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `useraccount_insert_audit` AFTER INSERT ON `useraccount` FOR EACH ROW BEGIN
    INSERT INTO AuditLog (Action, TableName, RecordID)
    VALUES ('INSERT', 'UserAccount', CAST(NEW.UserID AS CHAR));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `useraccount_update_audit` AFTER UPDATE ON `useraccount` FOR EACH ROW BEGIN
    INSERT INTO AuditLog (Action, TableName, RecordID)
    VALUES ('UPDATE', 'UserAccount', CAST(NEW.UserID AS CHAR));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Dumping events for database 'staffsync'
--

--
-- Dumping routines for database 'staffsync'
--
/*!50003 DROP PROCEDURE IF EXISTS `CreateUserAccount` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `CreateUserAccount`(
    IN p_Username VARCHAR(50),
    IN p_Email VARCHAR(100),
    IN p_PasswordHash VARCHAR(255),
    IN p_EmployeeID INT,
    IN p_UserRole ENUM("Admin", "HR", "Regular")
)
BEGIN
    -- Check if the EmployeeID exists
    IF NOT EXISTS (
        SELECT 1 
        FROM Employee 
        WHERE EmployeeID = p_EmployeeID
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: EmployeeID does not exist';
    END IF;

    -- Check if the Username already exists
    IF EXISTS (
        SELECT 1 
        FROM UserAccount 
        WHERE Username = p_Username
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: Username already exists';
    END IF;

    -- Check if the EmployeeID already has a user account
    IF EXISTS (
        SELECT 1
        FROM UserAccount
        WHERE EmployeeID = p_EmployeeID
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: Employee already has a user account';
    END IF;

    -- Insert the new UserAccount record if all checks pass
    INSERT INTO UserAccount (Username, Email, PasswordHash, EmployeeID, User_Role)
    VALUES (p_Username, p_Email, p_PasswordHash, p_EmployeeID, p_UserRole);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DeleteUserAccount` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteUserAccount`(
    IN p_UserID INT
)
BEGIN
    -- Declare a handler for any SQL exceptions (errors)
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        -- Rollback if any error occurs
        ROLLBACK;
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error occurred while deleting user account.';
    END;

    -- Start a transaction for the delete operations
    START TRANSACTION;

    -- Log audit action for deleting the user account (outside transaction)
    -- Ensure the AuditLog table is valid and has the right structure
    INSERT INTO AuditLog (Action, TableName, RecordID)
VALUES ('DELETE', 'UserAccount', CAST(p_UserID AS CHAR));

    -- Delete the user account record from the UserAccount table
    DELETE FROM UserAccount WHERE UserID = p_UserID;

    -- Check if the DELETE was successful
    IF ROW_COUNT() = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'UserAccount not found.';
    END IF;

    -- Commit the transaction if everything is successful
    COMMIT;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_department` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_department`(
    IN p_DepartmentID INT
)
BEGIN
    -- Error handler for SQL exceptions
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error occurred while deleting department.';
    END;

    -- Log audit action for deleting the department (outside transaction)
    INSERT INTO AuditLog (Action, TableName, RecordID)
    VALUES ('DELETE', 'Department', CAST(p_DepartmentID AS CHAR));

    -- Start a transaction for the delete operations
    START TRANSACTION;

    -- Example: Handle foreign key references if applicable
    -- If DepartmentID is referenced elsewhere, update or delete related data
    -- For instance, if Employee table references DepartmentID:
    -- UPDATE Employee SET DepartmentID = NULL WHERE DepartmentID = p_DepartmentID;

    -- Delete the department record from the Department table
    DELETE FROM Department WHERE DepartmentID = p_DepartmentID;

    -- Check if the DELETE was successful
    IF ROW_COUNT() = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Department not found.';
    END IF;

    -- Commit the transaction if everything is successful
    COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_dependent` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_dependent`(
    IN p_DependentInfoID INT
)
BEGIN
    DELETE FROM DependentInfo WHERE DependentInfoID = p_DependentInfoID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_emergency_contact` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_emergency_contact`(
    IN p_EmergencyContactID INT
)
BEGIN
    DELETE FROM EmergencyContact 
    WHERE EmergencyContactID = p_EmergencyContactID;
    
    IF ROW_COUNT() = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Emergency contact not found.';
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_employee` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_employee`(
    IN p_EmployeeID INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error occurred while deleting employee.';
    END;

    -- Log audit action for deleting the employee (outside transaction)
    INSERT INTO AuditLog (Action, TableName, RecordID)
    VALUES ('DELETE', 'Employee', CAST(p_EmployeeID AS CHAR));

    -- Start a transaction for the delete operations
    START TRANSACTION;

    -- Delete related records in the UserAccount table first
    DELETE FROM UserAccount WHERE EmployeeID = p_EmployeeID;

    -- Delete related records in the EmergencyContact table
    DELETE FROM EmergencyContact WHERE EmployeeID = p_EmployeeID;

    -- Delete related records in the DependentInfo table
    DELETE FROM DependentInfo WHERE EmployeeID = p_EmployeeID;

    -- Delete related records in the Leave table
    DELETE FROM Leave_tracker WHERE EmployeeID = p_EmployeeID OR ApprovedByID = p_EmployeeID;

    -- Update supervisor references in Employee table
    UPDATE Employee SET SupervisorID = NULL WHERE SupervisorID = p_EmployeeID;

    -- Finally, delete the employee record from the Employee table
    DELETE FROM Employee WHERE EmployeeID = p_EmployeeID;

    -- Check if the DELETE was successful
    IF ROW_COUNT() = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Employee not found.';
    END IF;

    -- If we reach here, commit the transaction
    COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_job_title` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_job_title`(
    IN p_JobTitleID INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error occurred while deleting job title.';
    END;

    -- Log audit action for deleting the job title (outside transaction)
    INSERT INTO AuditLog (Action, TableName, RecordID)
    VALUES ('DELETE', 'JobTitle', CAST(p_JobTitleID AS CHAR));

    -- Start a transaction for the delete operations
    START TRANSACTION;

    -- Remove foreign key references or related data
    -- Example: If JobTitleID is referenced in Employee table
    UPDATE Employee SET JobTitleID = NULL WHERE JobTitleID = p_JobTitleID;

    -- Delete the job title record from the JobTitle table
    DELETE FROM JobTitle WHERE JobTitleID = p_JobTitleID;

    -- Check if the DELETE was successful
    IF ROW_COUNT() = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Job title not found.';
    END IF;

    -- Commit the transaction if everything is successful
    COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_organization` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_organization`(
    IN p_OrganizationID INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error occurred while deleting organization.';
    END;

    -- Log audit action for deleting the organization (outside transaction)
    INSERT INTO AuditLog (Action, TableName, RecordID)
    VALUES ('DELETE', 'Organization', CAST(p_OrganizationID AS CHAR));

    -- Start a transaction for the delete operations
    START TRANSACTION;

    -- Remove foreign key references or related data
    -- Example: If OrganizationID is referenced in Employee table
    UPDATE Employee SET OrganizationID = NULL WHERE OrganizationID = p_OrganizationID;

    -- Delete the organization record from the Organization table
    DELETE FROM Organization WHERE OrganizationID = p_OrganizationID;

    -- Check if the DELETE was successful
    IF ROW_COUNT() = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Organization not found.';
    END IF;

    -- Commit the transaction if everything is successful
    COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_paygrade` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_paygrade`(
    IN p_PayGradeID INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error occurred while deleting paygrade.';
    END;

    -- Log audit action for deleting the organization (outside transaction)
    INSERT INTO AuditLog (Action, TableName, RecordID)
    VALUES ('DELETE', 'PayGrade', CAST(p_PayGradeID AS CHAR));

    -- Start a transaction for the delete operations
    START TRANSACTION;

    -- Remove foreign key references or related data
    -- Example: If OrganizationID is referenced in Employee table
    UPDATE Employee SET PayGradeID = NULL WHERE PayGradeID = p_PayGradeID;

    -- Delete the organization record from the Organization table
    DELETE FROM PayGrade WHERE PayGradeID = p_PayGradeID;

    -- Check if the DELETE was successful
    IF ROW_COUNT() = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'PayGrade not found.';
    END IF;

    -- Commit the transaction if everything is successful
    COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `EmployeeDetailsByID` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `EmployeeDetailsByID`(IN p_EmployeeID INT)
BEGIN
    SELECT 
        e.EmployeeID,
        e.EmployeeName,
        e.Address,
        e.Country,
        e.DateOfBirth,
        e.Gender,
        e.MaritalStatus,
        e.NumberOfLeaves,
        e.DepartmentID,  -- Returning Department ID
        e.JobTitleID,    -- Returning Job Title ID
        e.PayGradeID,    -- Returning Pay Grade ID
        e.OrganizationID, -- Returning Organization ID
        e.SupervisorID,   -- Returning Supervisor ID
        (SELECT COUNT(*) 
         FROM DependentInfo di 
         WHERE di.EmployeeID = e.EmployeeID) AS DependentCount,
        (SELECT COUNT(*) 
         FROM EmergencyContact ec 
         WHERE ec.EmployeeID = e.EmployeeID) AS EmergencyContactCount,
        (SELECT COALESCE(SUM(l.LeaveDayCount), 0)
         FROM Leave_tracker l 
         WHERE l.EmployeeID = e.EmployeeID) AS TotalLeavesUsed,
        (e.NumberOfLeaves - COALESCE((SELECT SUM(l.LeaveDayCount)
                                      FROM Leave_tracker l 
                                      WHERE l.EmployeeID = e.EmployeeID), 0)) AS LeavesLeft
    FROM 
        Employee e
    WHERE 
        e.EmployeeID = p_EmployeeID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetEmployeeDetails` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetEmployeeDetails`(IN p_EmployeeID INT)
BEGIN
    SELECT 
        e.EmployeeID,
        e.EmployeeName,
        e.Address,
        e.Country,
        e.DateOfBirth,
        e.Gender,
        e.MaritalStatus,
        e.NumberOfLeaves,
        d.DepartmentName,
        j.JobTitleName,
        p.PayGradeName,
        o.Name AS OrganizationName,
        COALESCE(s.EmployeeName, '-') AS SupervisorName,
        (SELECT COUNT(*) 
         FROM DependentInfo di 
         WHERE di.EmployeeID = e.EmployeeID) AS DependentCount,
        (SELECT COUNT(*) 
         FROM EmergencyContact ec 
         WHERE ec.EmployeeID = e.EmployeeID) AS EmergencyContactCount,
        (SELECT COALESCE(SUM(l.LeaveDayCount), 0)
         FROM Leave_tracker l 
         WHERE l.EmployeeID = e.EmployeeID) AS TotalLeavesUsed,
        (e.NumberOfLeaves - COALESCE((SELECT SUM(l.LeaveDayCount)
                                      FROM Leave_tracker l 
                                      WHERE l.EmployeeID = e.EmployeeID), 0)) AS LeavesLeft
    FROM 
        Employee e
    LEFT JOIN Department d ON e.DepartmentID = d.DepartmentID
    LEFT JOIN JobTitle j ON e.JobTitleID = j.JobTitleID
    LEFT JOIN PayGrade p ON e.PayGradeID = p.PayGradeID
    LEFT JOIN Organization o ON e.OrganizationID = o.OrganizationID
    LEFT JOIN Employee s ON e.SupervisorID = s.EmployeeID
    WHERE 
        e.EmployeeID = p_EmployeeID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetEmployeeDistributionByDepartment` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetEmployeeDistributionByDepartment`(IN org_id INT)
BEGIN
    SELECT 
        d.DepartmentID,
        CONCAT(d.DepartmentID, ': ', d.DepartmentName) AS DepartmentLabel, 
        COUNT(e.EmployeeID) AS EmployeeCount
    FROM 
        Employee e
    JOIN 
        Department d ON e.DepartmentID = d.DepartmentID
    WHERE 
        e.OrganizationID = org_id
    GROUP BY 
        d.DepartmentID, d.DepartmentName
    ORDER BY 
        d.DepartmentID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetEmployeeDistributionByPayGrade` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetEmployeeDistributionByPayGrade`(IN org_id INT)
BEGIN
    SELECT 
        p.PayGradeID,
        CONCAT(p.PayGradeID, ': ', p.PayGradeName) AS PayGradeLabel, 
        COUNT(e.EmployeeID) AS EmployeeCount
    FROM 
        Employee e
    JOIN 
        PayGrade p ON e.PayGradeID = p.PayGradeID
    WHERE 
        e.OrganizationID = org_id
    GROUP BY 
        p.PayGradeID, p.PayGradeName
    ORDER BY 
        p.PayGradeID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetEmployeeLeaveData` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetEmployeeLeaveData`(IN employee_id INT)
BEGIN
    SELECT 
        LeaveType,
        COUNT(LeaveDayCount) AS leave_count
    FROM Leave_tracker
    WHERE EmployeeID = employee_id
    GROUP BY LeaveType;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_employee_dependents` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_employee_dependents`(
    IN p_EmployeeID INT
)
BEGIN
    SELECT DependentName, DependentAge,DependentInfoID
    FROM DependentInfo
    WHERE EmployeeID = p_EmployeeID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_employee_emergency_contacts` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_employee_emergency_contacts`(
    IN p_EmployeeID INT
)
BEGIN
    SELECT 
        EC.EmergencyContactID,
        EC.ContactName,
        EC.PhoneNumber,
        EC.Address
    FROM 
        EmergencyContact EC
    WHERE 
        EC.EmployeeID = p_EmployeeID
    ORDER BY 
        EC.EmergencyContactID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_employee_leaves` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_employee_leaves`(IN p_EmployeeID INT)
BEGIN
    SELECT 
        lt.LeaveID,
        lt.LeaveLogDateTime,
        lt.Reason,
        lt.LeaveType,
        lt.FirstAbsentDate,
        lt.LastAbsentDate,
        lt.LeaveDayCount,
        CASE 
            WHEN lt.ApprovedByID = NULL THEN 'Pending'
            ELSE 'Approved'
        END AS ApprovalStatus
    FROM 
        Leave_tracker lt
    LEFT JOIN 
        Employee e ON lt.ApprovedByID = e.EmployeeID
    WHERE 
        lt.EmployeeID = p_EmployeeID
    ORDER BY 
        lt.LeaveLogDateTime DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insert_department` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_department`(
    IN p_DepartmentID INT,
    IN p_DepartmentName VARCHAR(50)
)
BEGIN
    INSERT INTO Department (DepartmentID, DepartmentName)
    VALUES (p_DepartmentID, p_DepartmentName);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insert_dependent` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_dependent`(
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insert_emergency_contact` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_emergency_contact`(
    IN p_EmployeeID INT,
    IN p_ContactName VARCHAR(100),
    IN p_PhoneNumber VARCHAR(20),
    IN p_Address VARCHAR(200),
    OUT p_EmergencyContactID INT
)
BEGIN
    DECLARE contact_count INT;
    
    SELECT COUNT(*) INTO contact_count
    FROM EmergencyContact
    WHERE EmployeeID = p_EmployeeID;
    
    IF contact_count < 3 THEN
        INSERT INTO EmergencyContact (EmployeeID, ContactName, PhoneNumber, Address)
        VALUES (p_EmployeeID, p_ContactName, p_PhoneNumber, p_Address);
        
        SET p_EmergencyContactID = LAST_INSERT_ID();
    ELSE
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Employee already has 3 emergency contacts.';
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insert_employee` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_employee`(
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
    IN p_NumberOfLeaves INT,
    OUT p_EmployeeID INT
)
BEGIN
    INSERT INTO Employee (
        EmployeeName, DateOfBirth, Gender, MaritalStatus, Address, Country,
        OrganizationID, DepartmentID, JobTitleID, PayGradeID, SupervisorID, NumberOfLeaves
    ) VALUES (
        p_EmployeeName, p_DateOfBirth, p_Gender, p_MaritalStatus, p_Address, p_Country,
        p_OrganizationID, p_DepartmentID, p_JobTitleID, p_PayGradeID, p_SupervisorID, 
        IFNULL(p_NumberOfLeaves, 20)
    );
    
    SET p_EmployeeID = LAST_INSERT_ID();
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insert_job_title` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_job_title`(
    IN p_JobTitleName VARCHAR(50)
)
BEGIN
    INSERT INTO JobTitle (JobTitleName)
    VALUES (p_JobTitleName);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insert_organization` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_organization`(
    IN p_Name VARCHAR(50),
    IN p_Address VARCHAR(100),
    IN p_RegistrationNumber VARCHAR(20)
)
BEGIN
    INSERT INTO Organization (Name, Address, RegistrationNumber)
    VALUES (p_Name, p_Address, p_RegistrationNumber);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insert_paygrade` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_paygrade`(
    IN p_PayGradeName VARCHAR(50),
    IN p_SalaryAmount DECIMAL(10,2)
)
BEGIN
    INSERT INTO PayGrade (PayGradeName,SalaryAmount)
    VALUES (p_PayGradeName,p_SalaryAmount);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `LogLeave` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `LogLeave`(
    IN p_EmployeeID INT,
    IN p_Reason VARCHAR(255),
    IN p_LeaveType ENUM('Annual', 'Casual', 'Maternity', 'No-Pay'),
    IN p_FirstAbsentDate DATE,
    IN p_LastAbsentDate DATE,
    OUT p_LeaveID INT
)
BEGIN
    DECLARE v_LeaveDayCount INT;

    -- Calculate the number of leave days
    SET v_LeaveDayCount = DATEDIFF(p_LastAbsentDate, p_FirstAbsentDate) + 1;

    INSERT INTO Leave_tracker (
        EmployeeID,
        Reason,
        LeaveType,
        FirstAbsentDate,
        LastAbsentDate,
        LeaveDayCount
    ) VALUES (
        p_EmployeeID,
        p_Reason,
        p_LeaveType,
        p_FirstAbsentDate,
        p_LastAbsentDate,
        v_LeaveDayCount
    );

    SET p_LeaveID = LAST_INSERT_ID();
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UpdateUserAccount` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateUserAccount`(
    IN p_UserID INT,
    IN p_Username VARCHAR(50),
    IN p_Email VARCHAR(100),
    IN p_PasswordHash VARCHAR(255),
    IN p_EmployeeID INT,
    IN p_UserRole ENUM("Admin", "HR", "Regular")
)
BEGIN
    -- Check if the EmployeeID exists
    IF NOT EXISTS (
        SELECT 1 
        FROM Employee 
        WHERE EmployeeID = p_EmployeeID
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: EmployeeID does not exist';
    END IF;

    -- Check if the Username already exists for another account
    IF EXISTS (
        SELECT 1 
        FROM UserAccount 
        WHERE Username = p_Username AND UserID != p_UserID
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: Username already exists';
    END IF;

    -- Update the UserAccount record if checks pass
    UPDATE UserAccount
    SET Username = p_Username, 
        Email = p_Email, 
        PasswordHash = p_PasswordHash, 
        EmployeeID = p_EmployeeID, 
        User_Role = p_UserRole
    WHERE UserID = p_UserID;

    -- Check if the update was successful
    IF ROW_COUNT() = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: UserAccount not found';
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_department_name` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_department_name`(
    IN p_DepartmentID INT,
    IN p_NewDepartmentName VARCHAR(50)
)
BEGIN
    UPDATE Department
    SET DepartmentName = p_NewDepartmentName
    WHERE DepartmentID = p_DepartmentID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_dependent` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_dependent`(
    IN p_DependentInfoID INT,
    IN p_DependentName VARCHAR(100),
    IN p_DependentAge INT
)
BEGIN
    UPDATE DependentInfo
    SET DependentName = p_DependentName,
        DependentAge = p_DependentAge
    WHERE DependentInfoID = p_DependentInfoID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_emergency_contact` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_emergency_contact`(
    IN p_EmergencyContactID INT,
    IN p_ContactName VARCHAR(100),
    IN p_PhoneNumber VARCHAR(20),
    IN p_Address VARCHAR(200)
)
BEGIN
    UPDATE EmergencyContact
    SET ContactName = p_ContactName,
        PhoneNumber = p_PhoneNumber,
        Address = p_Address
    WHERE EmergencyContactID = p_EmergencyContactID;
    
    IF ROW_COUNT() = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Emergency contact not found.';
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_employee` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_employee`(
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
    IN p_SupervisorID INT,
    IN p_NumberOfLeaves INT
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
        SupervisorID = IF(p_SupervisorID IS NULL, NULL, p_SupervisorID),
        NumberOfLeaves = IFNULL(p_NumberOfLeaves, NumberOfLeaves)
    WHERE EmployeeID = p_EmployeeID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_job_title_name` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_job_title_name`(
    IN p_JobTitleID INT,
    IN p_NewJobTitleName VARCHAR(50)
)
BEGIN
    UPDATE JobTitle
    SET JobTitleName = p_NewJobTitleName
    WHERE JobTitleID = p_JobTitleID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_organization` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_organization`(
    IN p_OrganizationID INT,
    IN p_Name VARCHAR(50),
    IN p_Address VARCHAR(100),
    IN p_RegistrationNumber VARCHAR(20)
)
BEGIN
    UPDATE Organization
    SET Name = p_Name,
        Address = p_Address,
        RegistrationNumber = p_RegistrationNumber
    WHERE OrganizationID = p_OrganizationID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_paygrade` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_paygrade`(
    IN p_PayGradeID INT,
    IN p_PayGradeName VARCHAR(50),
    IN p_SalaryAmount DECIMAL(10,2)
)
BEGIN
    UPDATE PayGrade
    SET PayGradeName = p_PayGradeName,
        SalaryAmount = p_SalaryAmount
    WHERE PayGradeID = p_PayGradeID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-12-05 14:42:47
