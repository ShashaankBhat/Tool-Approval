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
-- Table structure for table `ta_approval_matrix`
--

DROP TABLE IF EXISTS `ta_approval_matrix`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ta_approval_matrix` (
  `ta_approval_matrix_id` bigint NOT NULL AUTO_INCREMENT,
  `ta_business_unit_id` bigint DEFAULT NULL,
  `level_one` bigint NOT NULL,
  `level_one_position` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `level_two` bigint DEFAULT NULL,
  `level_two_position` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `level_three` bigint DEFAULT NULL,
  `level_three_position` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `level_four` bigint DEFAULT NULL,
  `level_four_position` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `matrix_active` int NOT NULL DEFAULT '1',
  `created_by` bigint NOT NULL,
  `created_on` datetime NOT NULL,
  `updated_by` bigint DEFAULT NULL,
  `updated_on` datetime DEFAULT NULL,
  PRIMARY KEY (`ta_approval_matrix_id`),
  KEY `approvalMatrixCreatedBy_idx` (`created_by`),
  KEY `approvalMatrixUpdatedBy_idx` (`updated_by`),
  KEY `approverLevelOne_idx` (`level_one`),
  KEY `approverLevelTwo_idx` (`level_two`),
  KEY `approverLevelThree_idx` (`level_three`),
  KEY `approverLevelFour_idx` (`level_four`),
  KEY `businessUnitRef_idx` (`ta_business_unit_id`),
  CONSTRAINT `approvalMatrixCreatedBy` FOREIGN KEY (`created_by`) REFERENCES `m_user` (`m_user_id`),
  CONSTRAINT `approvalMatrixUpdatedBy` FOREIGN KEY (`updated_by`) REFERENCES `m_user` (`m_user_id`),
  CONSTRAINT `approverLevelFour` FOREIGN KEY (`level_four`) REFERENCES `m_user` (`m_user_id`),
  CONSTRAINT `approverLevelOne` FOREIGN KEY (`level_one`) REFERENCES `m_user` (`m_user_id`),
  CONSTRAINT `approverLevelThree` FOREIGN KEY (`level_three`) REFERENCES `m_user` (`m_user_id`),
  CONSTRAINT `approverLevelTwo` FOREIGN KEY (`level_two`) REFERENCES `m_user` (`m_user_id`),
  CONSTRAINT `businessUnitRef` FOREIGN KEY (`ta_business_unit_id`) REFERENCES `ta_business_unit` (`ta_business_unit_id`)
) ENGINE=InnoDB AUTO_INCREMENT=110 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ta_approval_matrix`
--

LOCK TABLES `ta_approval_matrix` WRITE;
/*!40000 ALTER TABLE `ta_approval_matrix` DISABLE KEYS */;
INSERT INTO `ta_approval_matrix` VALUES (1,63,1,'One',2,'Two',15,'Three',29,'Four',1,1,'2026-02-09 16:17:13',1,'2026-02-13 11:39:05'),(2,63,18,'One',21,'Two',19,'Three',26,'Four',0,1,'2026-02-13 11:14:13',1,'2026-02-13 12:15:00'),(3,63,16,'One',17,'Two',19,'Three',22,'Four',0,1,'2026-02-13 12:10:46',1,'2026-02-13 12:14:48'),(4,63,34,'One',34,'Two',31,'Three',30,'Four',1,1,'2026-03-07 13:15:10',NULL,NULL),(5,62,34,'One',33,'Two',32,'Three',31,'Four',0,1,'2026-03-07 13:31:31',NULL,NULL),(6,61,30,'ONe',31,'ONe',32,'ONe',33,'ONe',1,1,'2026-03-07 13:34:46',NULL,NULL),(7,60,34,'asdf',33,'asdf',32,'asdf',31,'asdf',1,1,'2026-03-07 13:37:11',NULL,NULL),(8,60,34,'asdf',33,'asdf',32,'asdf',31,'asdf',1,1,'2026-03-07 13:37:11',NULL,NULL),(9,60,34,'asdf',33,'asdf',32,'asdf',31,'asdf',1,1,'2026-03-07 13:37:11',NULL,NULL),(10,60,34,'asdf',33,'asdf',32,'asdf',31,'asdf',1,1,'2026-03-07 13:37:11',NULL,NULL),(11,60,34,'asdf',33,'asdf',32,'asdf',31,'asdf',1,1,'2026-03-07 13:37:11',NULL,NULL),(12,60,34,'asdf',33,'asdf',32,'asdf',31,'asdf',1,1,'2026-03-07 13:37:11',NULL,NULL),(13,60,34,'asdf',33,'asdf',32,'asdf',31,'asdf',1,1,'2026-03-07 13:37:11',NULL,NULL),(14,60,34,'asdf',33,'asdf',32,'asdf',31,'asdf',1,1,'2026-03-07 13:37:11',NULL,NULL),(15,60,34,'asdf',33,'asdf',32,'asdf',31,'asdf',1,1,'2026-03-07 13:37:11',NULL,NULL),(16,60,34,'asdf',33,'asdf',32,'asdf',31,'asdf',1,1,'2026-03-07 13:37:11',NULL,NULL),(17,60,34,'asdf',33,'asdf',32,'asdf',31,'asdf',1,1,'2026-03-07 13:37:11',NULL,NULL),(18,60,34,'asdf',33,'asdf',32,'asdf',31,'asdf',1,1,'2026-03-07 13:37:11',NULL,NULL),(19,60,34,'asdf',33,'asdf',32,'asdf',31,'asdf',1,1,'2026-03-07 13:37:11',NULL,NULL),(20,60,34,'asdf',33,'asdf',32,'asdf',31,'asdf',1,1,'2026-03-07 13:37:11',NULL,NULL),(21,60,34,'asdf',33,'asdf',32,'asdf',31,'asdf',1,1,'2026-03-07 13:37:11',NULL,NULL),(22,60,34,'asdf',33,'asdf',32,'asdf',31,'asdf',1,1,'2026-03-07 13:37:11',NULL,NULL),(23,60,34,'asdf',33,'asdf',32,'asdf',31,'asdf',1,1,'2026-03-07 13:37:11',NULL,NULL),(24,60,34,'asdf',33,'asdf',32,'asdf',31,'asdf',1,1,'2026-03-07 13:37:11',NULL,NULL),(25,60,34,'asdf',33,'asdf',32,'asdf',31,'asdf',1,1,'2026-03-07 13:37:11',NULL,NULL),(26,60,34,'asdf',33,'asdf',32,'asdf',31,'asdf',1,1,'2026-03-07 13:37:11',NULL,NULL),(27,60,34,'asdf',33,'asdf',32,'asdf',31,'asdf',1,1,'2026-03-07 13:37:11',NULL,NULL),(28,60,34,'asdf',33,'asdf',32,'asdf',31,'asdf',1,1,'2026-03-07 13:37:11',NULL,NULL),(29,60,34,'asdf',33,'asdf',32,'asdf',31,'asdf',1,1,'2026-03-07 13:37:11',NULL,NULL),(30,60,34,'asdf',33,'asdf',32,'asdf',31,'asdf',1,1,'2026-03-07 13:37:11',NULL,NULL),(31,60,34,'asdf',33,'asdf',32,'asdf',31,'asdf',1,1,'2026-03-07 13:37:11',NULL,NULL),(32,60,34,'asdf',33,'asdf',32,'asdf',31,'asdf',1,1,'2026-03-07 13:37:11',NULL,NULL),(33,60,34,'asdf',33,'asdf',32,'asdf',31,'asdf',1,1,'2026-03-07 13:37:11',NULL,NULL),(34,60,34,'asdf',33,'asdf',32,'asdf',31,'asdf',1,1,'2026-03-07 13:37:11',NULL,NULL),(35,60,34,'asdf',33,'asdf',32,'asdf',31,'asdf',1,1,'2026-03-07 13:37:11',NULL,NULL),(36,60,34,'asdf',33,'asdf',32,'asdf',31,'asdf',1,1,'2026-03-07 13:37:11',NULL,NULL),(37,60,34,'asdf',33,'asdf',32,'asdf',31,'asdf',1,1,'2026-03-07 13:37:11',NULL,NULL),(38,60,34,'asdf',33,'asdf',32,'asdf',31,'asdf',1,1,'2026-03-07 13:37:11',NULL,NULL),(39,60,34,'asdf',33,'asdf',32,'asdf',31,'asdf',1,1,'2026-03-07 13:37:11',NULL,NULL),(40,60,34,'asdf',33,'asdf',32,'asdf',31,'asdf',1,1,'2026-03-07 13:37:11',NULL,NULL),(41,60,34,'asdf',33,'asdf',32,'asdf',31,'asdf',1,1,'2026-03-07 13:37:11',NULL,NULL),(42,60,34,'asdf',33,'asdf',32,'asdf',31,'asdf',1,1,'2026-03-07 13:37:11',NULL,NULL),(43,60,34,'asdf',33,'asdf',32,'asdf',31,'asdf',1,1,'2026-03-07 13:37:11',NULL,NULL),(44,60,34,'asdf',33,'asdf',32,'asdf',31,'asdf',1,1,'2026-03-07 13:37:11',NULL,NULL),(45,60,34,'asdf',33,'asdf',32,'asdf',31,'asdf',1,1,'2026-03-07 13:37:11',NULL,NULL),(46,60,34,'asdf',33,'asdf',32,'asdf',31,'asdf',1,1,'2026-03-07 13:37:11',NULL,NULL),(47,60,34,'asdf',33,'asdf',32,'asdf',31,'asdf',1,1,'2026-03-07 13:37:11',NULL,NULL),(48,60,34,'asdf',33,'asdf',32,'asdf',31,'asdf',1,1,'2026-03-07 13:37:11',NULL,NULL),(49,60,34,'asdf',33,'asdf',32,'asdf',31,'asdf',1,1,'2026-03-07 13:37:11',NULL,NULL),(50,60,34,'asdf',33,'asdf',32,'asdf',31,'asdf',1,1,'2026-03-07 13:37:11',NULL,NULL),(51,60,34,'asdf',33,'asdf',32,'asdf',31,'asdf',1,1,'2026-03-07 13:37:11',NULL,NULL),(52,60,34,'asdf',33,'asdf',32,'asdf',31,'asdf',1,1,'2026-03-07 13:37:11',NULL,NULL),(53,60,34,'asdf',33,'asdf',32,'asdf',31,'asdf',1,1,'2026-03-07 13:37:11',NULL,NULL),(54,60,34,'asdf',33,'asdf',32,'asdf',31,'asdf',1,1,'2026-03-07 13:37:11',NULL,NULL),(55,60,34,'asdf',33,'asdf',32,'asdf',31,'asdf',1,1,'2026-03-07 13:37:11',NULL,NULL),(56,60,34,'asdf',33,'asdf',32,'asdf',31,'asdf',1,1,'2026-03-07 13:37:11',NULL,NULL),(57,59,34,'Test One',33,'Test Two',32,'Test Three',31,'Test Four',1,1,'2026-03-07 13:37:11',1,'2026-03-07 14:22:07'),(58,58,34,'Level One',33,'Level Two',32,'Level Three',31,'Level Four',0,1,'2026-03-07 17:22:18',NULL,NULL),(59,58,34,'Level One',33,'Level Two',32,'Level Three',31,'Level Four',0,1,'2026-03-07 17:22:18',NULL,NULL),(60,58,34,'Level One',33,'Level Two',32,'Level Three',31,'Level Four',0,1,'2026-03-07 17:22:18',NULL,NULL),(61,58,34,'Level One',33,'Level Two',32,'Level Three',31,'Level Four',0,1,'2026-03-07 17:22:18',NULL,NULL),(62,58,34,'Level One',33,'Level Two',32,'Level Three',31,'Level Four',0,1,'2026-03-07 17:22:18',NULL,NULL),(63,58,34,'Level One',33,'Level Two',32,'Level Three',31,'Level Four',0,1,'2026-03-07 17:22:18',NULL,NULL),(64,58,34,'Level One',33,'Level Two',32,'Level Three',31,'Level Four',0,1,'2026-03-07 17:22:18',NULL,NULL),(65,58,34,'Level One',33,'Level Two',32,'Level Three',31,'Level Four',0,1,'2026-03-07 17:22:18',NULL,NULL),(66,58,34,'Level One',33,'Level Two',32,'Level Three',31,'Level Four',0,1,'2026-03-07 17:22:18',NULL,NULL),(67,58,34,'Level One',33,'Level Two',32,'Level Three',31,'Level Four',0,1,'2026-03-07 17:22:18',NULL,NULL),(68,58,34,'Level One',33,'Level Two',32,'Level Three',31,'Level Four',0,1,'2026-03-07 17:22:18',NULL,NULL),(69,58,34,'Level One',33,'Level Two',32,'Level Three',31,'Level Four',0,1,'2026-03-07 17:22:18',NULL,NULL),(70,58,34,'Level One',33,'Level Two',32,'Level Three',31,'Level Four',0,1,'2026-03-07 17:22:18',NULL,NULL),(71,58,34,'Level One',33,'Level Two',32,'Level Three',31,'Level Four',0,1,'2026-03-07 17:22:18',NULL,NULL),(72,58,34,'Level One',33,'Level Two',32,'Level Three',31,'Level Four',0,1,'2026-03-07 17:22:18',NULL,NULL),(73,58,34,'Level One',33,'Level Two',32,'Level Three',31,'Level Four',0,1,'2026-03-07 17:22:18',NULL,NULL),(74,58,34,'Level One',33,'Level Two',32,'Level Three',31,'Level Four',0,1,'2026-03-07 17:22:18',NULL,NULL),(75,58,34,'Level One',33,'Level Two',32,'Level Three',31,'Level Four',0,1,'2026-03-07 17:22:18',NULL,NULL),(76,58,34,'Level One',33,'Level Two',32,'Level Three',31,'Level Four',0,1,'2026-03-07 17:22:18',NULL,NULL),(77,58,34,'Level One',33,'Level Two',32,'Level Three',31,'Level Four',0,1,'2026-03-07 17:22:18',NULL,NULL),(78,58,34,'Level One',33,'Level Two',32,'Level Three',31,'Level Four',0,1,'2026-03-07 17:22:18',NULL,NULL),(79,58,34,'Level One',33,'Level Two',32,'Level Three',31,'Level Four',0,1,'2026-03-07 17:22:18',NULL,NULL),(80,58,34,'Level One',33,'Level Two',32,'Level Three',31,'Level Four',0,1,'2026-03-07 17:22:18',NULL,NULL),(81,58,34,'Level One',33,'Level Two',32,'Level Three',31,'Level Four',0,1,'2026-03-07 17:22:18',NULL,NULL),(82,58,34,'Level One',33,'Level Two',32,'Level Three',31,'Level Four',0,1,'2026-03-07 17:22:18',NULL,NULL),(83,58,34,'Level One',33,'Level Two',32,'Level Three',31,'Level Four',0,1,'2026-03-07 17:22:18',NULL,NULL),(84,58,34,'Level One',33,'Level Two',32,'Level Three',31,'Level Four',0,1,'2026-03-07 17:22:18',NULL,NULL),(85,58,34,'Level One',33,'Level Two',32,'Level Three',31,'Level Four',0,1,'2026-03-07 17:22:18',NULL,NULL),(86,58,34,'Level One',33,'Level Two',32,'Level Three',31,'Level Four',0,1,'2026-03-07 17:22:18',NULL,NULL),(87,58,34,'Level One',33,'Level Two',32,'Level Three',31,'Level Four',0,1,'2026-03-07 17:22:18',NULL,NULL),(88,58,34,'Level One',33,'Level Two',32,'Level Three',31,'Level Four',0,1,'2026-03-07 17:22:18',NULL,NULL),(89,58,34,'Level One',33,'Level Two',32,'Level Three',31,'Level Four',0,1,'2026-03-07 17:22:18',NULL,NULL),(90,58,34,'Level One',33,'Level Two',32,'Level Three',31,'Level Four',0,1,'2026-03-07 17:22:18',NULL,NULL),(91,58,34,'Level One',33,'Level Two',32,'Level Three',31,'Level Four',0,1,'2026-03-07 17:22:18',NULL,NULL),(92,58,34,'Level One',33,'Level Two',32,'Level Three',31,'Level Four',0,1,'2026-03-07 17:22:18',NULL,NULL),(93,58,34,'Level One',33,'Level Two',32,'Level Three',31,'Level Four',0,1,'2026-03-07 17:22:18',NULL,NULL),(94,58,34,'Level One',33,'Level Two',32,'Level Three',31,'Level Four',0,1,'2026-03-07 17:22:18',NULL,NULL),(95,58,34,'Level One',33,'Level Two',32,'Level Three',31,'Level Four',0,1,'2026-03-07 17:22:18',NULL,NULL),(96,58,34,'Level One',33,'Level Two',32,'Level Three',31,'Level Four',0,1,'2026-03-07 17:22:18',NULL,NULL),(97,58,34,'Level One',33,'Level Two',32,'Level Three',31,'Level Four',0,1,'2026-03-07 17:22:18',NULL,NULL),(98,58,34,'Level One',33,'Level Two',32,'Level Three',31,'Level Four',0,1,'2026-03-07 17:22:18',NULL,NULL),(99,58,34,'Level One',33,'Level Two',32,'Level Three',31,'Level Four',0,1,'2026-03-07 17:22:18',NULL,NULL),(100,58,34,'Level One',33,'Level Two',32,'Level Three',31,'Level Four',0,1,'2026-03-07 17:22:18',NULL,NULL),(101,58,34,'Level One',33,'Level Two',32,'Level Three',31,'Level Four',0,1,'2026-03-07 17:22:18',NULL,NULL),(102,58,34,'Level One',33,'Level Two',32,'Level Three',31,'Level Four',0,1,'2026-03-07 17:22:18',NULL,NULL),(103,58,34,'Level One',33,'Level Two',32,'Level Three',31,'Level Four',0,1,'2026-03-07 17:22:18',NULL,NULL),(104,58,34,'Level One',33,'Level Two',32,'Level Three',31,'Level Four',0,1,'2026-03-07 17:22:18',NULL,NULL),(105,58,34,'Level One',33,'Level Two',32,'Level Three',31,'Level Four',0,1,'2026-03-07 17:22:18',NULL,NULL),(106,58,34,'Level One',33,'Level Two',32,'Level Three',31,'Level Four',0,1,'2026-03-07 17:22:18',NULL,NULL),(107,58,34,'Level One',33,'Level Two',32,'Level Three',31,'Level Four',0,1,'2026-03-07 17:22:18',NULL,NULL),(108,58,34,'Level One',33,'Level Two',32,'Level Three',31,'Level Four',0,1,'2026-03-07 17:22:18',NULL,NULL),(109,57,34,'Level One',33,'Level Two',32,'Level Three',31,'Level Four',1,1,'2026-03-07 17:28:08',1,'2026-03-07 17:29:33');
/*!40000 ALTER TABLE `ta_approval_matrix` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-03-10 11:07:49
