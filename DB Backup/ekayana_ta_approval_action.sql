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
-- Table structure for table `ta_approval_action`
--

DROP TABLE IF EXISTS `ta_approval_action`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ta_approval_action` (
  `ta_approval_action_id` bigint NOT NULL AUTO_INCREMENT,
  `ta_tool_request_id` bigint NOT NULL,
  `approver_user_id` bigint NOT NULL,
  `action_code` int NOT NULL,
  `approval_remark` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `action_on` datetime NOT NULL,
  `action_active` int NOT NULL DEFAULT '1',
  `created_by` bigint NOT NULL,
  `created_on` datetime NOT NULL,
  PRIMARY KEY (`ta_approval_action_id`),
  KEY `fk_ta_aa_request` (`ta_tool_request_id`),
  KEY `fk_ta_aa_approver_user` (`approver_user_id`),
  KEY `fk_ta_aa_created_by` (`created_by`),
  CONSTRAINT `fk_ta_aa_approver_user` FOREIGN KEY (`approver_user_id`) REFERENCES `m_user` (`m_user_id`),
  CONSTRAINT `fk_ta_aa_created_by` FOREIGN KEY (`created_by`) REFERENCES `m_user` (`m_user_id`),
  CONSTRAINT `fk_ta_aa_request` FOREIGN KEY (`ta_tool_request_id`) REFERENCES `ta_tool_request` (`ta_tool_request_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ta_approval_action`
--

LOCK TABLES `ta_approval_action` WRITE;
/*!40000 ALTER TABLE `ta_approval_action` DISABLE KEYS */;
/*!40000 ALTER TABLE `ta_approval_action` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-03-10 11:07:53
