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
-- Table structure for table `ta_approval_matrix_history`
--

DROP TABLE IF EXISTS `ta_approval_matrix_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ta_approval_matrix_history` (
  `ta_approval_matrix_history_id` bigint NOT NULL AUTO_INCREMENT,
  `ta_approval_matrix_id` bigint DEFAULT NULL,
  `ta_business_unit_id` bigint DEFAULT NULL,
  `level_one` bigint DEFAULT NULL,
  `level_one_position` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `level_two` bigint DEFAULT NULL,
  `level_two_position` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `level_three` bigint DEFAULT NULL,
  `level_three_position` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `level_four` bigint DEFAULT NULL,
  `level_four_position` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `matrix_active` int DEFAULT '1',
  `created_by` bigint DEFAULT NULL,
  `created_on` datetime DEFAULT NULL,
  PRIMARY KEY (`ta_approval_matrix_history_id`),
  KEY `parentApprovalMatrix_idx` (`ta_approval_matrix_id`),
  KEY `historyLevelOne_idx` (`level_one`),
  KEY `historyBusinessUnit_idx` (`ta_business_unit_id`),
  KEY `historyLevelTwo_idx` (`level_two`),
  KEY `historyLevelThree_idx` (`level_three`),
  KEY `historyLevelFour_idx` (`level_four`),
  KEY `approvalHistoryCreatedBy_idx` (`created_by`),
  CONSTRAINT `approvalHistoryCreatedBy` FOREIGN KEY (`created_by`) REFERENCES `m_user` (`m_user_id`),
  CONSTRAINT `historyBusinessUnit` FOREIGN KEY (`ta_business_unit_id`) REFERENCES `ta_business_unit` (`ta_business_unit_id`),
  CONSTRAINT `historyLevelFour` FOREIGN KEY (`level_four`) REFERENCES `m_user` (`m_user_id`),
  CONSTRAINT `historyLevelOne` FOREIGN KEY (`level_one`) REFERENCES `m_user` (`m_user_id`),
  CONSTRAINT `historyLevelThree` FOREIGN KEY (`level_three`) REFERENCES `m_user` (`m_user_id`),
  CONSTRAINT `historyLevelTwo` FOREIGN KEY (`level_two`) REFERENCES `m_user` (`m_user_id`),
  CONSTRAINT `parentApprovalMatrix` FOREIGN KEY (`ta_approval_matrix_id`) REFERENCES `ta_approval_matrix` (`ta_approval_matrix_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ta_approval_matrix_history`
--

LOCK TABLES `ta_approval_matrix_history` WRITE;
/*!40000 ALTER TABLE `ta_approval_matrix_history` DISABLE KEYS */;
INSERT INTO `ta_approval_matrix_history` VALUES (4,57,60,34,'One',33,'Two',32,'Three',31,'Four',NULL,1,'2026-03-07 14:22:07'),(5,109,57,34,'Level One',33,'Level Two',32,'Level Three',31,'Level Four',NULL,1,'2026-03-07 17:28:16'),(6,109,57,34,'Level One',33,'Level Two',32,'Level Three',31,'Level Four',NULL,1,'2026-03-07 17:29:33');
/*!40000 ALTER TABLE `ta_approval_matrix_history` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-03-10 11:07:50
