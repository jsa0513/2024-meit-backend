-- MySQL dump 10.13  Distrib 9.0.1, for Win64 (x86_64)
--
-- Host: localhost    Database: esp32
-- ------------------------------------------------------
-- Server version	9.0.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customers` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `cus_ID` varchar(45) NOT NULL,
  `cus_pwd` varchar(45) NOT NULL,
  `cus_name` varchar(45) NOT NULL,
  `cus_email` varchar(45) NOT NULL,
  `cus_birth` date NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `cus_ID_UNIQUE` (`cus_ID`),
  UNIQUE KEY `cus_email_UNIQUE` (`cus_email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers`
--

LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
/*!40000 ALTER TABLE `customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `medications`
--

DROP TABLE IF EXISTS `medications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `medications` (
  `medicationID` int NOT NULL AUTO_INCREMENT,
  `ID` int NOT NULL,
  `medi_num` int NOT NULL,
  `medi_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`medicationID`),
  KEY `medi_num_idx` (`medi_num`),
  KEY `ID_idx` (`ID`),
  CONSTRAINT `ID2` FOREIGN KEY (`ID`) REFERENCES `medicines` (`ID`),
  CONSTRAINT `medi_num` FOREIGN KEY (`medi_num`) REFERENCES `medicines` (`medi_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `medications`
--

LOCK TABLES `medications` WRITE;
/*!40000 ALTER TABLE `medications` DISABLE KEYS */;
/*!40000 ALTER TABLE `medications` ENABLE KEYS */;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `medications_AFTER_INSERT` AFTER INSERT ON `medications` FOR EACH ROW BEGIN
	DECLARE current_amount INT;

    SELECT `medi_amount` INTO current_amount
    FROM `esp32`.`medicines`
    WHERE `ID` = NEW.ID AND `medi_num` = NEW.medi_num;

    IF current_amount > 0 THEN
        UPDATE `esp32`.`medicines`
        SET `medi_amount` = `medi_amount` - 1
        WHERE `ID` = NEW.ID AND `medi_num` = NEW.medi_num;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `medicine_inputs`
--

DROP TABLE IF EXISTS `medicine_inputs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `medicine_inputs` (
  `ID` int NOT NULL,
  `medi_num` int NOT NULL,
  `input_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `input_amount` int NOT NULL,
  PRIMARY KEY (`ID`,`medi_num`,`input_time`),
  KEY `medi_num_idx` (`medi_num`),
  CONSTRAINT `ID3` FOREIGN KEY (`ID`) REFERENCES `medicines` (`ID`),
  CONSTRAINT `medi_num2` FOREIGN KEY (`medi_num`) REFERENCES `medicines` (`medi_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `medicine_inputs`
--

LOCK TABLES `medicine_inputs` WRITE;
/*!40000 ALTER TABLE `medicine_inputs` DISABLE KEYS */;
/*!40000 ALTER TABLE `medicine_inputs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `medicines`
--

DROP TABLE IF EXISTS `medicines`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `medicines` (
  `ID` int NOT NULL,
  `medi_num` int NOT NULL AUTO_INCREMENT,
  `medi_name` varchar(45) NOT NULL,
  `medi_schedule` time NOT NULL,
  `medi_amount` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`medi_num`,`ID`),
  UNIQUE KEY `medi_num_UNIQUE` (`medi_num`),
  UNIQUE KEY `ID_UNIQUE` (`ID`),
  CONSTRAINT `ID` FOREIGN KEY (`ID`) REFERENCES `customers` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `medicines`
--

LOCK TABLES `medicines` WRITE;
/*!40000 ALTER TABLE `medicines` DISABLE KEYS */;
/*!40000 ALTER TABLE `medicines` ENABLE KEYS */;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `medicines_BEFORE_INSERT` BEFORE INSERT ON `medicines` FOR EACH ROW BEGIN
	DECLARE max_medi_num INT;

    SELECT IFNULL(MAX(medi_num), 0) INTO max_medi_num
    FROM medicines
    WHERE ID = NEW.ID;

    IF max_medi_num >= 6 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Each ID can only have up to 6 medicines.';
    ELSE
        SET NEW.medi_num = max_medi_num + 1;
    END IF;
END */;;
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

-- Dump completed on 2024-10-01 15:54:27
