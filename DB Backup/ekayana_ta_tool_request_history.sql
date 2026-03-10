-- MySQL dump 10.13  Distrib 8.0.42, for Win64 (x86_64)
--
-- Host: localhost    Database: ekayana
-- ------------------------------------------------------
-- Server version	8.0.41

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
-- Table structure for table `ta_tool_request_history`
--

DROP TABLE IF EXISTS `ta_tool_request_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ta_tool_request_history` (
  `ta_tool_request_history_id` bigint NOT NULL AUTO_INCREMENT,
  `ta_tool_request_id` bigint DEFAULT NULL,
  `request_number` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `customer_name` varchar(155) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `project_name` varchar(155) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sop_date` datetime DEFAULT NULL,
  `entity_id` bigint DEFAULT NULL,
  `peak_annual_volume` int DEFAULT NULL,
  `unit` tinyint DEFAULT NULL,
  `expense_type` tinyint DEFAULT NULL,
  `ta_business_unit_id` bigint DEFAULT NULL,
  `commodity_manager_user_id` bigint DEFAULT NULL,
  `background` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `remark` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `ta_recovery_type_id` bigint DEFAULT NULL,
  `ta_status_id` bigint DEFAULT NULL,
  `request_active` int DEFAULT NULL,
  `created_by` bigint DEFAULT NULL,
  `created_on` datetime DEFAULT NULL,
  `updated_by` bigint DEFAULT NULL,
  `updated_on` datetime DEFAULT NULL,
  PRIMARY KEY (`ta_tool_request_history_id`),
  KEY `fk_ta_tr_business_unit_history` (`ta_business_unit_id`),
  KEY `fk_ta_tr_created_by_history` (`created_by`),
  KEY `fk_ta_tr_entity_history` (`entity_id`),
  KEY `fk_ta_tr_recovery_type_history` (`ta_recovery_type_id`),
  KEY `fk_ta_tr_status_history` (`ta_status_id`),
  KEY `fk_ta_tr_updated_by_history` (`updated_by`),
  CONSTRAINT `fk_ta_tr_business_unit_history` FOREIGN KEY (`ta_business_unit_id`) REFERENCES `ta_business_unit` (`ta_business_unit_id`),
  CONSTRAINT `fk_ta_tr_created_by_history` FOREIGN KEY (`created_by`) REFERENCES `m_user` (`m_user_id`),
  CONSTRAINT `fk_ta_tr_entity_history` FOREIGN KEY (`entity_id`) REFERENCES `m_entity` (`m_entity_id`),
  CONSTRAINT `fk_ta_tr_recovery_type_history` FOREIGN KEY (`ta_recovery_type_id`) REFERENCES `ta_recovery_type` (`ta_recovery_type_id`),
  CONSTRAINT `fk_ta_tr_status_history` FOREIGN KEY (`ta_status_id`) REFERENCES `ta_status` (`ta_status_id`),
  CONSTRAINT `fk_ta_tr_updated_by_history` FOREIGN KEY (`updated_by`) REFERENCES `m_user` (`m_user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ta_tool_request_history`
--

LOCK TABLES `ta_tool_request_history` WRITE;
/*!40000 ALTER TABLE `ta_tool_request_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `ta_tool_request_history` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-03-10 11:07:52
